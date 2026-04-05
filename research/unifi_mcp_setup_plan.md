# UniFi MCP Setup Plan

**Status:** RESEARCH — Not adopted
**Date:** 2026-03-28
**Based on:** unifi_mcp_investigation.md, unifi_mcp_udm_compatibility.md, unifi_mcp_optimization_capabilities.md

---

## Recommendation

**Primary: enuno/unifi-mcp-server**

| Factor | Why it matters |
|--------|---------------|
| Uses official Ubiquiti API | Stable against firmware updates; not reverse-engineered |
| API key auth (not username/password) | Cleaner credential model; no password stored in env |
| Python 3.10+ | Works on both Python 3.12 and 3.13 available on this machine |
| UDM-compatible from the start | Handles `/proxy/network/` path prefix natively — no version-specific bug workarounds |
| 1,160 unit tests + CodeQL/Trivy/Bandit scanning | Best engineering rigor in the ecosystem |
| Dry-run mode + audit logging | Safe for initial experimentation |

**Tradeoff to know:** enuno has ~74 tools vs sirkirby's 130+. sirkirby has a built-in 16-benchmark firewall security audit scorer that enuno lacks. If the firewall audit is a priority, see the Alternative section at the bottom.

**Critical limitation across both:** The official API key (`Settings > Control Plane > Integrations`) gives read-only access. For write operations (modifying firewall rules, QoS, VLAN config, etc.) you need a dedicated local admin account with username/password. Start read-only; switch auth when you need writes.

---

## Installation Steps

### Step 1: Generate API Key on UDM

1. Log into the UDM local web UI: `https://<UDM-IP>` (use your UDM's local IP — typically 192.168.1.1)
2. Navigate to: **Settings > Control Plane > Integrations**
   - Note: older guides say "Settings > Admin" — that path is wrong on UniFi OS
3. Click **Create API Key**, give it a name (e.g., `claude-mcp-readonly`)
4. Copy the key immediately — it is shown only once
5. Store it in a secure location (password manager)

**Scope note:** API keys on UDM inherit permissions from the admin account that creates them. The key is bound to that account's access level. For read-only use, this is fine. Ubiquiti does not currently offer scoped/reduced-privilege API keys.

**Prerequisite:** Your UDM must be running UniFi OS 3.x+ (shipped ~2023). UniFi Network app 9.0+ is required for the enuno server's full tool set. Check under **Settings > System > Updates**.

---

### Step 2: Install enuno/unifi-mcp-server

Open Git Bash and run:

```bash
pip install unifi-mcp-server
```

Verify the install:

```bash
python -m unifi_mcp --version
# or
pip show unifi-mcp-server
```

**Windows-specific notes:**
- Both servers have no Windows-native install docs, but pip install works cleanly on Windows with Python 3.12/3.13
- SSL: the server defaults to `UNIFI_VERIFY_SSL=false` — this is expected and correct for local UDM installs with self-signed certs. Do not fight it.
- If you get a `command not found` for `unifi-mcp`, use the full Python invocation: `python -m unifi_mcp`

**Docker alternative** (if pip causes any dependency friction):

```bash
docker run -e UNIFI_HOST=https://192.168.1.1 \
           -e UNIFI_API_KEY=your-key-here \
           -e UNIFI_SITE=default \
           ghcr.io/enuno/unifi-mcp-server:latest
```

Docker multi-arch images are published and maintained. Use this if you hit any Windows Python packaging issues.

---

### Step 3: Configure MCP in Claude Code

Add the server to `.claude/settings.local.json`. If the file already has an `mcpServers` block, add the entry there; otherwise add the block.

**stdio transport (recommended for local use):**

```json
{
  "mcpServers": {
    "unifi": {
      "command": "python",
      "args": ["-m", "unifi_mcp"],
      "env": {
        "UNIFI_HOST": "https://192.168.1.1",
        "UNIFI_API_KEY": "your-api-key-here",
        "UNIFI_SITE": "default",
        "UNIFI_VERIFY_SSL": "false"
      }
    }
  }
}
```

Replace `192.168.1.1` with your actual UDM IP. `UNIFI_SITE` is `default` unless you've renamed your site in the controller.

**Environment variable alternative** (keeps the key out of settings.local.json):

Set the env vars in your Windows user environment (`System Properties > Environment Variables`) or in a `.env` file in the project root, then simplify the config:

```json
{
  "mcpServers": {
    "unifi": {
      "command": "python",
      "args": ["-m", "unifi_mcp"],
      "env": {
        "UNIFI_HOST": "https://192.168.1.1",
        "UNIFI_SITE": "default",
        "UNIFI_VERIFY_SSL": "false"
      }
    }
  }
}
```

And set `UNIFI_API_KEY` as a Windows user environment variable. Claude Code inherits the shell environment.

**Reload Claude Code** after editing settings.local.json — MCP servers are registered at startup.

**Verify the connection:** Ask Claude: "List all connected UniFi clients." If the MCP is working, you'll get a live client list. If it fails, check the UDM IP, API key, and that the UDM is reachable from the machine running Claude Code.

---

### Step 4: Security Hardening

**Start read-only.** The API key auth mode is inherently read-only — no firewall rule creation, no VLAN changes. This is the correct starting posture. Do not add username/password auth until you have a specific write task in mind.

**Claude Code permissions — what to allow/deny:**

In `.claude/settings.local.json`, you can restrict which MCP tools Claude can invoke without asking. Recommended initial posture:

```json
{
  "permissions": {
    "allow": [
      "mcp__unifi__list_clients",
      "mcp__unifi__get_client",
      "mcp__unifi__list_devices",
      "mcp__unifi__get_device",
      "mcp__unifi__list_networks",
      "mcp__unifi__get_network_stats",
      "mcp__unifi__list_wlans",
      "mcp__unifi__get_site_stats"
    ],
    "deny": [
      "mcp__unifi__create_firewall_rule",
      "mcp__unifi__delete_firewall_rule",
      "mcp__unifi__block_client",
      "mcp__unifi__restart_device"
    ]
  }
}
```

Exact tool names depend on enuno's published tool list — adjust based on what `unifi_mcp --list-tools` returns. The principle: explicitly deny any tool that modifies network state until you've audited the read-only tools and are confident in how write operations work.

**Localhost-only access:** The stdio transport (configured above) never opens a network port — it communicates only via stdin/stdout between Claude Code and the Python process. There is no port to restrict. The Docker/SSE transport option does open a port; if you use Docker, bind it to `127.0.0.1` only:

```bash
docker run -p 127.0.0.1:8000:8000 ...
```

**API key scope:** Ubiquiti does not currently offer reduced-scope API keys. The key you generate has the same access level as the admin account that created it. Mitigation: create a dedicated read-only UniFi admin account, generate the API key from that account.

**Prompt injection risk:** Do not feed untrusted documents (web pages, emails, external files) to Claude while the UniFi MCP is active. A crafted document could trigger tool calls against your network. This is a general MCP risk, not UniFi-specific.

**Audit log:** enuno writes mutations to `audit.log` in the working directory. Review it periodically once you enable write operations.

---

### Step 5: First Network Audit Commands

Once the MCP is running, these are concrete things to ask Claude. All are read-only and safe with API key auth:

1. **"List all connected clients and their current bandwidth usage — sort by highest to lowest."**
   Uses `stat/sta` endpoint. Identifies bandwidth hogs immediately.

2. **"Show me all WiFi networks, which band each AP is using, current channel assignments, and transmit power levels."**
   Combines `stat/device` radio_table data with WLAN config.

3. **"Pull all IDS/IPS alerts from the last 7 days and tell me if any patterns stand out."**
   Uses `stat/alarm` (3,000 result limit). Good for identifying persistent threats or misbehaving devices.

4. **"Identify any clients that haven't been seen in more than 30 days but still have DHCP leases or firewall rules referencing their MAC."**
   Stale device cleanup — fully readable, no writes needed to audit.

5. **"Show me all firewall rules and flag any that are disabled, have overlapping source/dest ranges, or allow unrestricted outbound from IoT VLANs."**
   Human-readable firewall audit. More limited than sirkirby's automated scorer, but useful.

6. **"List all devices and their firmware versions — identify anything not on the latest release."**
   Uses `stat/device` version field. Prioritize gateway and switches first.

7. **"Show me traffic broken down by application category for the last 24 hours — what's consuming the most bandwidth by type?"**
   Uses `stat/sitedpi` with DPI data. Requires UDM (gateway-level DPI).

8. **"List all VLANs and which SSIDs are mapped to each — identify any SSID that is on the main LAN that probably shouldn't be (IoT, guest, etc.)."**
   VLAN/SSID mapping audit. Pure read — `rest/networkconf` + `rest/wlanconf`.

9. **"Show me which clients have the worst signal quality (low RSSI, high retry rate) and which AP they're connected to."**
   Roaming issue detection via `stat/sta` signal/satisfaction fields.

10. **"List all port forwarding rules currently active and describe what each one exposes to the internet."**
    Attack surface review. Uses `rest/portforward`. Ask Claude to flag anything that looks unnecessary.

---

## Alternative: sirkirby/unifi-mcp

Use this if you want the firewall security audit scorer (16 benchmarks, 0-100 score with remediation guidance) or broader tool coverage (130 Network tools vs enuno's ~74).

**Key differences from enuno:**
- Requires Python 3.13 (hard requirement — will not install on 3.12)
- Username/password auth for full functionality (API key support is experimental and read-only)
- 130+ tools including the built-in firewall scorer
- Claude Code plugin marketplace installable: `/plugin marketplace add sirkirby/unifi-mcp`
- Last commit March 19, 2026 (more recently active than enuno's Feb 19)

**Install:**

```bash
# Option 1: Claude Code marketplace (installs automatically)
/plugin marketplace add sirkirby/unifi-mcp

# Option 2: pip
pip install unifi-network-mcp
```

**Claude Code config for sirkirby:**

```json
{
  "mcpServers": {
    "unifi-network": {
      "command": "python",
      "args": ["-m", "unifi_network_mcp"],
      "env": {
        "UNIFI_HOST": "https://192.168.1.1",
        "UNIFI_USERNAME": "your-admin-username",
        "UNIFI_PASSWORD": "your-admin-password",
        "UNIFI_SITE": "default",
        "UNIFI_VERIFY_SSL": "false"
      }
    }
  }
}
```

Create a dedicated UniFi admin account for this (not your primary admin account) so you can revoke it independently. The account needs local admin access — cloud-only accounts won't work.

**Verify the UDM version fix is in place:** sirkirby's UDM compatibility was broken before v0.1.4. The pip install will pull the latest version (v0.1.4+) automatically, but verify: `pip show unifi-network-mcp` — confirm version is 0.1.4 or higher.

**First thing to run with sirkirby:** Ask Claude to "run the firewall security audit." This runs 16 automated benchmarks across Ingress Control, Egress Control, Rule Hygiene, and Topology, returning a 0-100 score and per-finding remediation steps. No equivalent exists in enuno.

---

## Quick Decision Matrix

| You want... | Use |
|-------------|-----|
| Clean API key auth, no password stored | enuno |
| Python 3.12 (not 3.13) | enuno |
| Best engineering quality / audit logs | enuno |
| Automated firewall security scoring | sirkirby |
| Broadest tool coverage (Protect/Access too) | sirkirby |
| Claude Code marketplace one-command install | sirkirby |
| IoT-safe read-only start with upgrade path | enuno → add sirkirby later |
