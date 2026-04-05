# UniFi / Ubiquiti MCP Server Investigation

**Status:** RESEARCH — Not adopted
**Date:** 2026-03-28
**Related:** N/A

---

## Executive Summary

The UniFi MCP ecosystem is active and surprisingly mature for a community-driven effort. At least 10 distinct GitHub repositories implement MCP servers for UniFi, the strongest being `sirkirby/unifi-mcp` (223 stars, 130+ tools across Network/Protect/Access) and `enuno/unifi-mcp-server` (86 stars, 74 tools, PyPI-published, 1160 unit tests). No official Ubiquiti MCP integration exists as of March 2026 — all projects are community-built, though several use Ubiquiti's own official REST API. The primary risks are standard MCP security concerns: prompt injection, credential exposure, and unconfirmed mutations on live network infrastructure.

---

## Key Findings

### 1. Official Ubiquiti Position

No official MCP integration from Ubiquiti/UI.com as of March 2026. Ubiquiti does offer an **official REST API** (Settings → Control Plane → Integrations → API Key) that community projects build on top of. The official API has three access modes:
- **Local Gateway API** — full feature access, requires local network
- **Cloud Early Access API** — limited, aggregate stats only
- **Cloud V1 API** — stable, rate-limited to 10,000 req/min

A community-posted thread on community.ui.com titled "A UniFi MCP Server Using the Official UniFi API" (Nov 2025) generated visibility but no official Ubiquiti response or endorsement.

### 2. Most Mature Projects

See comparison table below. The two standout projects are:

**sirkirby/unifi-mcp** — most polished, purpose-built for Claude Code integration, has a dedicated website (unifimcp.com), Claude Code plugin marketplace entry, and covers Network + Protect + Access. Last commit March 19, 2026.

**enuno/unifi-mcp-server** — best engineering rigor (1,160 unit tests, CodeQL, Trivy, Bandit security scanning, PyPI package, Docker multi-arch images). More conservative tool set (74 tools vs 130+). Last commit Feb 19, 2026.

### 3. Feature Coverage

Across the ecosystem, UniFi MCP servers collectively expose:

| Category | Representative Tools |
|----------|---------------------|
| Device management | List, restart, locate, upgrade, provision APs/switches/gateways |
| Client management | Query, block, unblock, reconnect, bandwidth stats |
| WLAN/SSID | Create, modify, enable/disable SSIDs, guest networks, WPA2/WPA3 |
| VLAN/network config | Create/modify VLANs, DHCP, port profiles, 802.1X |
| Firewall | Rule creation/deletion, ACLs, zone-based policies, port forwarding |
| QoS | Traffic prioritization, bandwidth limits, DPI statistics |
| Security cameras (Protect) | Snapshots, event timelines, motion detection, recording management |
| Access control | Door unlock, badge logs, visitor credentials, access policies |
| Site Manager | Multi-site listing, host inventory, deployment status (cloud API) |
| Diagnostics | Topology discovery, network health checks, alarm listing |
| Operations | Backup scheduling/restoration, VPN config, multi-site management |

### 4. Go-Based Alternative

`claytono/go-unifi-mcp` is noteworthy: written in Go, exposes **242 operations** auto-generated from UniFi controller API definitions. Available as pre-built binaries for macOS/Linux and via Homebrew/Nix. Lower maturity (1 star) but the code-generation approach means it tracks the UniFi API closely. Uses lazy mode (3 meta-tools, ~200 token cost) vs eager mode (all 242 tools, ~55K tokens).

### 5. Underlying REST API Wrappers

Several mature REST wrappers exist that UniFi MCP servers build on or that could be wrapped independently:

| Package | Language | Stars | Supports |
|---------|----------|-------|---------|
| `node-unifi` (jens-maus) | Node.js | 158 | CloudKey Gen1/2, UDM-Pro, UDM-SE, UDM, UDR, UDW, self-hosted. API v4–v9 |
| `unifi-client` (thib3113) | Node.js | — | Full Unifi products |
| `go-unifi` (paultyng) | Go | — | Used by claytono/go-unifi-mcp and Terraform UniFi provider |
| Python `requests` + official API | Python | — | Used directly by sirkirby and enuno projects |

### 6. Registries / Package Distribution

| Registry | Entry |
|----------|-------|
| PyPI | `unifi-network-mcp` (sirkirby, updated Mar 27, 2026), `unifi-protect-mcp` (sirkirby, updated Mar 25, 2026), `unifi-mcp-server` (enuno, v0.2.4) |
| Claude Code marketplace | `sirkirby/unifi-mcp` — installable via `/plugin marketplace add sirkirby/unifi-mcp` |
| mcp.so | `unifi-mcp-server` by mikecutalo |
| Glama.ai | `zcking/mcp-server-unifi` — Quality/Security/License all grade A |
| PulseMCP | enuno server listed, 15.9K all-time visitors; sirkirby listed, 41.2K all-time visitors |
| lobehub.com | Multiple listings |

---

## Comparison Table

| Repo | Stars | Last Commit | Lang | Tools | Controller Support | Install |
|------|-------|-------------|------|-------|-------------------|---------|
| **sirkirby/unifi-mcp** | 223 | Mar 19, 2026 | Python 3.13 | 130 (Network) + 34 (Protect) + 29 (Access) | Local controller + multi-controller | PyPI, Claude Code marketplace, uvx |
| **enuno/unifi-mcp-server** | 86 | Feb 19, 2026 | Python 3.10+ | 74 | Local Gateway, Cloud Early Access, Cloud V1 | PyPI (`pip install unifi-mcp-server`), Docker |
| **claytono/go-unifi-mcp** | 1 | Jan 23, 2026 | Go | 242 (auto-generated) | Any controller in go-unifi range | Homebrew, Nix, pre-built binaries |
| **ry-ops/unifi-mcp-server** | 6 | Feb 27, 2025 | Python | Monitoring-focused | Local + Site Manager cloud | uv |
| **DataKnifeAI/unifi-manager-mcp** | 0 | Jan 1, 2025 | Go | 11 (read-only Site Manager) | Cloud Site Manager only | Build from source |
| **DataKnifeAI/unifi-network-mcp** | — | — | Python | Network management | Local | — |
| **DataKnifeAI/unifi-protect-mcp** | — | — | Python | Protect/cameras | Local | — |
| **mjrestivo16/mcp-unifi** | 0 | Feb 29, 2024 | TypeScript | 24 | Cloud Gateway, UDM, self-hosted | Node.js 20+, npm |
| **zcking/mcp-server-unifi** | 4,702 (Glama rank) | — | Python | Core querying | Local + cloud | uv, API key |
| **gilberth/mcp-unifi-network** | — | — | — | Device, client, firewall, monitoring | Local | — |

---

## Security Considerations

**Credential handling:**
- All projects require admin credentials (IP, username, password) or an official API key
- Credentials passed via environment variables — no plaintext config in most projects
- SSL certificate verification: configurable in most; some tutorials disable it (`verify=False`) — a known risk

**Mutation safety:**
- sirkirby: "preview-then-confirm" flow for all mutations; read-only by default
- enuno: `confirm=True` required flag on all mutating calls; dry-run mode; audit logging to `audit.log`
- DataKnifeAI: explicit "Prompt Injection Risk" warning in README — users are responsible
- claytono: last-write-wins on concurrent updates (race condition documented)

**MCP-level risks (general):**
- Prompt injection is the primary attack vector for all MCP servers with network/firewall access
- A malicious web page or document fed to Claude could craft tool calls targeting your network infrastructure
- 492+ MCP servers identified as publicly exposed without proper authentication (industry-wide, not UniFi-specific) [UNVERIFIED — from secondary source]
- Recommendation: run UniFi MCP only on trusted, local-only setups; never expose the MCP server endpoint to the internet

**Controller access scope:**
- Local Gateway API has full read/write access — the most capable and most dangerous mode
- Official API key (read-mostly) limits some mutations — safer starting point

---

## What a UniFi MCP Exposes to an AI Agent

Effectively: full network admin capability through natural language. This includes:
- Blocking/unblocking network clients
- Creating and deleting firewall rules
- Modifying VLAN configurations
- Enabling/disabling wireless networks
- Restarting or factory-resetting devices
- Viewing camera feeds and motion events (Protect)
- Unlocking physical doors (Access)
- Viewing all connected client devices, MACs, IPs, traffic stats

The safety surface is wide. "Read-only by default" implementations mitigate much of the risk for casual use.

---

## Bidirectional Search

- **Searched FOR:** "unifi mcp server github", "ubiquiti model context protocol", "unifi mcp pypi npm smithery", "unifimcp.com", community.ui.com MCP posts, r/Ubiquiti MCP discussion
- **Searched AGAINST:** "ubiquiti official MCP announcement", "ubiquiti AI integration official", "unifi mcp broken NOT working", "unifi mcp security vulnerability", "UniFi MCP prompt injection risk"
- **Contradicting evidence found:** Yes — partial. No evidence of official Ubiquiti endorsement or MCP integration from UI.com (searched their What's New and press releases — JavaScript-blocked but no indexed news found). Security concerns confirmed real: DataKnifeAI repos explicitly warn about prompt injection; broader MCP security research confirms this is a live threat class for any MCP server with infrastructure access. No evidence of catastrophic community failures or abandoned broken implementations — most active projects show continuous commits through early 2026.

---

## Recommendations

**Best option for immediate use:** `sirkirby/unifi-mcp`
- Most mature, highest star count (223), actively maintained through March 2026
- Claude Code native (plugin marketplace installable)
- Covers Network + Protect + Access in one project
- Python 3.13+, MIT license, read-only default with opt-in mutations
- Dedicated documentation site at unifimcp.com

**Best option for production/scripting reliability:** `enuno/unifi-mcp-server`
- Best engineering rigor of any project (1,160 tests, full CI/CD security scanning)
- PyPI-published, Docker multi-arch, audit logging
- Narrower tool set but more carefully tested
- Requires official API key (Gateway/Cloud mode)

**If you prefer Go:** `claytono/go-unifi-mcp`
- 242 auto-generated operations — comprehensive coverage
- Pre-built binaries, Homebrew/Nix installable
- Very low community adoption (1 star) — less battle-tested

**For cloud-only / read-only Site Manager access:** `DataKnifeAI/unifi-manager-mcp`
- 11 read-only tools against the Site Manager cloud API
- Zero risk of mutating your local network

**Security posture before deploying any of these:**
1. Use official API key (not full admin credentials) where possible
2. Start in read-only mode; explicitly opt into mutations
3. Never expose the MCP server port outside localhost
4. Review audit logs if using enuno's server
5. Do not feed untrusted documents to Claude while UniFi MCP is active (prompt injection risk)

Confidence: **High** that sirkirby and enuno are functional and actively maintained. **Medium** confidence on feature completeness — community reports via PulseMCP (41K visitors for sirkirby) suggest real-world adoption but no independent benchmark data was found.

---

## Sources

1. [sirkirby/unifi-mcp — GitHub](https://github.com/sirkirby/unifi-mcp)
2. [sirkirby/unifi-network-mcp — GitHub](https://github.com/sirkirby/unifi-network-mcp)
3. [enuno/unifi-mcp-server — GitHub](https://github.com/enuno/unifi-mcp-server)
4. [ry-ops/unifi-mcp-server — GitHub](https://github.com/ry-ops/unifi-mcp-server)
5. [claytono/go-unifi-mcp — GitHub](https://github.com/claytono/go-unifi-mcp)
6. [DataKnifeAI/unifi-manager-mcp — GitHub](https://github.com/DataKnifeAI/unifi-manager-mcp)
7. [DataKnifeAI/unifi-protect-mcp — GitHub](https://github.com/DataKnifeAI/unifi-protect-mcp)
8. [DataKnifeAI/unifi-network-mcp — GitHub](https://github.com/DataKnifeAI/unifi-network-mcp)
9. [mjrestivo16/mcp-unifi — GitHub](https://github.com/mjrestivo16/mcp-unifi)
10. [gilberth/mcp-unifi-network — GitHub](https://github.com/gilberth/mcp-unifi-network)
11. [jmagar/unifi-mcp — GitHub](https://github.com/jmagar/unifi-mcp)
12. [unifimcp.com — sirkirby project site](https://unifimcp.com/)
13. [unifi-network-mcp — PyPI](https://pypi.org/project/unifi-network-mcp/)
14. [unifi-protect-mcp — PyPI](https://pypi.org/project/unifi-protect-mcp/)
15. [unifi-mcp-server — Libraries.io](https://libraries.io/pypi/unifi-mcp-server)
16. [enuno server entry — PulseMCP](https://www.pulsemcp.com/servers/gh-enuno-unifi)
17. [zcking/mcp-server-unifi — Glama.ai](https://glama.ai/mcp/servers/@zcking/mcp-server-unifi)
18. [mcp.so registry — unifi-mcp-server](https://mcp.so/server/unifi-mcp-server/mikecutalo)
19. [jens-maus/node-unifi — GitHub](https://github.com/jens-maus/node-unifi)
20. [Getting Started with Official UniFi API — Ubiquiti Help Center](https://help.ui.com/hc/en-us/articles/30076656117655-Getting-Started-with-the-Official-UniFi-API)
21. [A UniFi MCP Server Using the Official UniFi API — community.ui.com](https://community.ui.com/questions/unifi-mcp-server-v0-1-0-A-UniFi-MCP-Server-Using-the-Official-UniFi-API/7affb8bb-5f60-45fb-8bdd-35d966558ef9)
22. [Talk to and control your UniFi Network controller with AI/LLM and MCP — community.ui.com](https://community.ui.com/questions/Talk-to-and-control-your-UniFi-Network-controller-with-AI-LLM-and-MCP/45f16304-21e7-4240-a771-780c5bfaca17)
23. [Build a MCP Server for AI Access to UniFi Networks — makewithdata.tech](https://www.makewithdata.tech/p/build-a-mcp-server-for-ai-access)
24. [MCP Security Risks — Prompt Security blog](https://prompt.security/blog/top-10-mcp-security-risks)
25. [Model Context Protocol prompt injection — Simon Willison](https://simonwillison.net/2025/Apr/9/mcp-prompt-injection/)
26. [UniFi Network Manager Claude Code Skill — mcpmarket.com](https://mcpmarket.com/tools/skills/unifi-network-manager)
