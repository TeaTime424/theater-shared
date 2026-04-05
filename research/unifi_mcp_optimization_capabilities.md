# UniFi MCP — AI Network Optimization Capabilities

**Status:** RESEARCH — Not adopted
**Date:** 2026-03-28
**Scope:** UniFi Dream Machine / UDM Pro; UniFi Network Controller API; MCP server implementations

---

## Executive Summary

The UniFi API is broadly capable across traffic analytics, WiFi config, security audit, QoS, device inventory, and VLAN management. Multiple production-ready MCP server implementations exist today (91–130 tools) that expose these capabilities to Claude via natural language. The API covers almost every optimization use case described, with one significant exception: per-radio channel/power **writes** use a reverse-engineered path (`radio_table` PUT on device object) that is not part of the official documented API. Channel AI optimization is a built-in UniFi feature that runs autonomously — it cannot be triggered via the external API. Everything else is actionable.

---

## Key Findings

### 1. Traffic Analysis

| Capability | API Available | Endpoint / Method |
|---|---|---|
| Per-client bandwidth (upload/download) | Yes | `GET stat/sta` — returns `tx_bytes`, `rx_bytes` per client |
| DPI per-client (application breakdown) | Yes | `POST stat/stadpi` with `type="by_app"` or `"by_cat"`, optional MAC filter |
| DPI site-wide aggregate | Yes | `POST stat/sitedpi` with same type params |
| Top talkers / bandwidth hogs | Yes (derived) | Sort `stat/sta` results by `tx_bytes + rx_bytes` |
| Historical traffic — 5-minute intervals | Yes | `POST stat/report/5minutes.{type}` |
| Historical traffic — hourly | Yes | `POST stat/report/hourly.{type}` (`stat_hourly_site`) |
| Historical traffic — daily | Yes | `POST stat/report/daily.{type}` (`stat_daily_site`) |
| ISP uplink utilization over time | Yes | WAN stats available; UGatewayStats project confirms 5-min/hourly/daily/monthly |

**DPI detail:** UniFi categorizes traffic into ~2,213 named applications across categories (streaming media, P2P, file transfer, instant messaging, gaming, etc.). Category ID is encoded in `(cat_id << 16) + app_id`. Requires a UniFi **gateway** (UDM/UDM Pro) — pure AP/switch deployments get interface-level stats only.

**Retention:** Data retention periods are configurable in the controller settings. Default retention varies by tier (hourly: weeks, daily: months).

---

### 2. WiFi Optimization

| Capability | API Available | Notes |
|---|---|---|
| Read channel per AP/radio | Yes | Via `stat/device` — `radio_table` field on each AP object |
| Read transmit power per AP/radio | Yes | `radio_table` field |
| Write channel selection | Yes (unofficial) | PUT `rest/device/{_id}` with `radio_table` array update (reverse-engineered, not in official docs) |
| Write transmit power | Yes (unofficial) | Same — `radio_table.$[r].tx_power` field |
| Band steering (read/write) | Yes (unofficial) | WLAN config via `rest/wlanconf` |
| Minimum RSSI threshold | Yes (unofficial) | Per-WLAN setting in `rest/wlanconf` |
| WLAN config (SSID, security, VLAN) | Yes (official) | `GET/PUT rest/wlanconf` — full read/write |
| Client signal strength / RSSI | Yes | `stat/sta` — `rssi`, `signal`, `noise` fields per connected client |
| Client connection quality | Yes | `stat/sta` — `tx_rate`, `rx_rate`, `satisfaction` score |
| Channel AI trigger via API | **No** | Channel AI is a built-in autonomous UniFi feature; cannot be triggered externally |
| Channel AI read recommendations | Partial | The recommendation is visible in UI but no documented API endpoint to read it |

**Channel AI note:** UniFi Network 9.5 introduced Channel AI (RRM-based ML channel planning). It runs autonomously on a schedule or can be triggered manually in the UI. It is **not externally triggerable via API**. However, the underlying data it uses (neighbor reports, interference scores) is readable, and channel/power **writes** are possible through the device object's `radio_table` field — just not via an officially blessed endpoint.

---

### 3. Security Audit

| Capability | API Available | Endpoint / Notes |
|---|---|---|
| Read firewall rules (user-defined) | Yes | `GET rest/firewallrule` |
| Read firewall groups | Yes | `GET rest/firewallgroup` |
| Create/modify/delete firewall rules | Yes | `POST/PUT/DELETE rest/firewallrule` |
| Enable/disable firewall rules | Yes | `PUT rest/firewallrule/{_id}` with `enabled: true/false` |
| Read port forwarding rules | Yes | `GET rest/portforward` |
| IDS/IPS alerts / events | Yes | `GET stat/alarm` (3000 result limit); also WebSocket event stream |
| IDS/IPS enable/disable via API | [UNVERIFIED] | Setting is in controller config; programmatic toggle not confirmed in docs |
| Threat management settings | Partial | Basic IDS/IPS config readable; advanced Suricata ruleset management is UI-only |
| Open ports audit | Derived | Combine `rest/portforward` + firewall rule read |
| DNS filtering config | Partial | DNS filter settings visible in network config; direct API write path not documented |
| Real-time threat event stream | Yes | WebSocket-based event listener (`unifi-events` Node.js module) |

**Security audit tooling note:** The `sirkirby/unifi-mcp` server (130 tools, Network server) includes an automated firewall audit against 16 security benchmarks across 4 categories (Ingress Control, Egress Control, Rule Hygiene, Topology), producing a 0–100 score with per-finding remediation guidance. This is the most directly useful AI-driven security capability available today.

---

### 4. QoS / Traffic Shaping

| Capability | API Available | Notes |
|---|---|---|
| Read QoS rules | Yes | `qos_rule` objects via REST |
| Create/modify QoS rules | Yes | POST/PUT on `qos_rule` endpoint |
| Per-client bandwidth limits | Yes | Client-level via `upd/user/{id}` + speed limit fields |
| Per-WLAN bandwidth limits | Yes | `rest/wlanconf` — `ratectrl_enabled`, `rate_limit_*` fields |
| DSCP tagging rules | Yes | Part of QoS/policy engine |
| Traffic policy (unified QoS+routing+security) | Yes | `oon_policy` objects — newer UniFi firmware |
| Per-port QoS on switches | Yes | Switch port config via device REST endpoint |

**Practical limit:** Traffic shaping is applied at the gateway level for WAN-bound traffic. Inter-VLAN QoS is also supported but less commonly automated.

---

### 5. Device Inventory

| Capability | API Available | Endpoint |
|---|---|---|
| Full device list (APs, switches, gateways) | Yes | `GET stat/device-basic` (lightweight) or `GET stat/device` (full) |
| Model, firmware version | Yes | `stat/device` fields: `model`, `version` |
| Uptime | Yes | `uptime` field |
| CPU / memory utilization | Yes | `sys_stats` object per device |
| Connection type (wired/uplink) | Yes | `uplink` object |
| PoE port status per switch | Yes | `port_table` on switch device objects |
| Pending firmware upgrades | Yes | `list_pending_devices` tool; firmware upgrade command available |
| Adopt/restart/locate device | Yes | `cmd/devmgr` commands |

---

### 6. VLAN Segmentation

| Capability | API Available | Endpoint |
|---|---|---|
| Read VLAN config | Yes | `GET rest/networkconf` — all networks/VLANs |
| Create VLAN | Yes | `POST rest/networkconf` |
| Modify VLAN (subnet, DHCP, name) | Yes | `PUT rest/networkconf/{_id}` |
| Delete VLAN | Yes | `DELETE rest/networkconf/{_id}` |
| Inter-VLAN routing rules | Yes | Firewall rules control inter-VLAN; readable via `rest/firewallrule` |
| VLAN assignment per SSID | Yes | `rest/wlanconf` — `networkconf_id` field |
| VLAN assignment per switch port | Yes | Switch port config in device object |

---

## MCP Server Implementations Available Today

Three production-ready MCP servers exist. All are open source (MIT), self-hosted, Docker-ready.

| Project | Tools | Auth | Maturity | Key strength |
|---|---|---|---|---|
| **sirkirby/unifi-mcp** (unifimcp.com) | 130 (Network), 34 (Protect), 29 (Access) | API key or user/pass | Stable (Network) | Largest toolset; built-in security audit scoring; preview-before-confirm for all writes |
| **brianbell-x/Unifi-Agent** | 51 MCP + 5 SSH | user/pass | Active | SSH fallback for gaps; direct MongoDB access on UDM-Pro |
| **CamoRageaholic1/unifi-mcp-server** | 46 | user/pass | Production-ready | TypeScript; Docker; comprehensive device/client/WiFi/VLAN/firewall |

**API key limitation:** The official UniFi API key (from Settings > Control Plane > Integrations) is read-only and covers a subset of tools. Username/password auth unlocks full read/write access. [UNVERIFIED — may vary by firmware version]

**List pagination gap:** Most list endpoints return a maximum of 25 items (first page only, no offset/limit params in the Unifi-Agent implementation). Large networks may require SSH + MongoDB for complete enumeration.

---

## Most Common AI-Assisted Optimizations (Community Evidence)

Based on real forum discussions, blog posts, and automation projects:

1. **Bandwidth hog identification** — most requested; fully automatable via `stat/sta` sort
2. **Firewall rule audit** — identify duplicate/shadowed/overly-permissive rules; the sirkirby MCP has a dedicated 16-benchmark scorer
3. **Stale device cleanup** — find clients not seen in N days, block or remove
4. **VLAN security review** — audit which SSIDs are on which VLANs, verify IoT isolation
5. **Client roaming issues** — identify clients with poor RSSI stuck on wrong AP or band
6. **IDS/IPS alert triage** — pull `stat/alarm` events, correlate with client identity
7. **Scheduled firewall rule toggling** — e.g., block IoT outbound midnight–6am (fully automatable)
8. **Firmware audit** — list devices on old firmware, trigger upgrades
9. **Guest voucher management** — bulk create/expire (fully automatable)
10. **QoS policy review** — verify streaming/gaming traffic is prioritized

---

## What Cannot Be Done via API

| Gap | Workaround |
|---|---|
| Trigger Channel AI optimization | Manual UI only; can manually write channel via `radio_table` PUT |
| Read Channel AI recommendations | No documented endpoint |
| Full Suricata IDS ruleset management | SSH to UDM-Pro directly |
| DNS filtering rule creation | UI-only in most firmware versions |
| IDS/IPS enable/disable toggle | [UNVERIFIED] |
| Pagination beyond first 25 devices/clients | SSH + MongoDB on UDM-Pro |
| UniFi Talk, Connect features | Separate application APIs |

---

## Comparison Table (MCP Servers)

| Feature | sirkirby/unifi-mcp | brianbell-x/Unifi-Agent | CamoRageaholic1 |
|---|---|---|---|
| Tool count | 130 Network | 51 + 5 SSH | 46 |
| Security audit scorer | Yes (16 benchmarks) | No | No |
| SSH fallback | No | Yes | No |
| MongoDB access | No | Yes (via SSH) | No |
| Protect/Access servers | Yes (beta) | No | No |
| Preview-before-confirm | Yes | Not mentioned | Not mentioned |
| Language | Unknown | Python | TypeScript |
| Docker support | Yes | Unclear | Yes |

---

## Bidirectional Search

- **Searched FOR:** "unifi API traffic stats", "unifi API DPI data", "unifi MCP server Claude", "unifi network optimization automation", "unifi API client statistics", "unifi API firewall endpoints", "unifi API VLAN configuration", "unifi API radio_table channel power write", "sirkirby unifi-mcp tools list", "unifi-agent MCP tools"
- **Searched AGAINST:** "unifi API limitations what cannot be done", "unifi API IDS limitations", "unifi channel AI API trigger", "unifi API read-only restrictions", "unifi MCP security risks"
- **Contradicting evidence found:** Yes — partial. Channel AI cannot be triggered via API (confirmed). Official API key auth is read-only / limited subset (confirmed). `radio_table` channel/power writes work but are reverse-engineered, not officially documented (confirmed gap). IDS/IPS programmatic enable/disable not confirmed. List pagination is capped at 25 items in some implementations.

---

## Recommendations

**Immediate value, low risk (read-only analytics):**
- Install `sirkirby/unifi-mcp` Network server
- Run the built-in firewall audit (16-benchmark scorer) — high value, no risk
- Use `stat/sta` to identify bandwidth hogs and poor-RSSI clients
- Pull `stat/stadpi` to categorize traffic by application

**Medium effort, real changes:**
- Schedule firewall rule toggling for IoT isolation (fully supported, use preview-confirm)
- Automated firmware audit + staged upgrades
- VLAN segmentation review and IoT isolation enforcement

**Proceed carefully:**
- Channel/power writes via `radio_table` are functional but not officially documented — test on one AP first, verify it doesn't conflict with Channel AI
- Don't use API key auth for anything requiring writes — switch to user/pass with a dedicated read-write service account

**Confidence:** High that the read capabilities are accurate (multiple independent sources, community tooling, official wiki). Medium confidence on write paths for radio config (reverse-engineered). Low confidence on IDS/IPS programmatic toggle availability.

---

## Sources

1. [UniFi Controller API Community Wiki](https://ubntwiki.com/products/software/unifi-controller/api) — endpoint reference (reverse-engineered, community-maintained)
2. [Getting Started with the Official UniFi API — Ubiquiti Help Center](https://help.ui.com/hc/en-us/articles/30076656117655-Getting-Started-with-the-Official-UniFi-API)
3. [UniFi Gateway — Traffic and Device Identification](https://help.ui.com/hc/en-us/articles/12570783535383-UniFi-Gateway-Traffic-and-Device-Identification)
4. [UniFi Channel AI and Automated WiFi Optimization](https://help.ui.com/hc/en-us/articles/37367741854743-UniFi-Channel-AI-and-Automated-WiFi-Optimization)
5. [UniFi QoS and Traffic Shaping](https://help.ui.com/hc/en-us/articles/204911354-UniFi-QoS-and-Traffic-Shaping)
6. [Traffic & Policy Management in UniFi](https://help.ui.com/hc/en-us/articles/5546542486551-Traffic-Policy-Management-in-UniFi)
7. [UniFi Gateway — IDS/IPS](https://help.ui.com/hc/en-us/articles/360006893234-UniFi-Gateway-Intrusion-Detection-and-Prevention-IDS-IPS)
8. [UniFi Alarm Manager](https://help.ui.com/hc/en-us/articles/27721287753239-UniFi-Alarm-Manager-Customize-Alerts-Integrations-and-Automations-Across-UniFi)
9. [sirkirby/unifi-mcp GitHub](https://github.com/sirkirby/unifi-network-mcp) — 130-tool MCP server
10. [unifimcp.com](https://unifimcp.com/) — product page for sirkirby MCP
11. [brianbell-x/Unifi-Agent GitHub](https://github.com/brianbell-x/Unifi-Agent) — 56-tool MCP + SSH
12. [CamoRageaholic1/unifi-mcp-server GitHub](https://github.com/CamoRageaholic1/unifi-mcp-server) — 46-tool TypeScript MCP
13. [Build a MCP Server for AI Access to UniFi Networks](https://www.makewithdata.tech/p/build-a-mcp-server-for-ai-access)
14. [How to analyze UniFi bottlenecks using DPI and traffic stats — UniHosted](https://www.unihosted.com/blog/how-to-analyze-unifi-network-bottlenecks-using-dpi-and-traffic-stats)
15. [UniFi Client Reporting — UniHosted](https://www.unihosted.com/blog/unifi-client-reporting-how-to-monitor-and-analyze-network-activity)
16. [UGatewayStats — WAN bandwidth reporting tool](https://github.com/stevesinchak/UGatewayStats)
17. [UniFi Alarm API via PowerShell — CyberDrain](https://www.cyberdrain.com/getting-all-alarms-of-all-unifi-sites-with-powershell/)
18. [I don't love UniFi Threat Management — set-inform.com](https://set-inform.com/2020/02/23/i-dont-love-unifi-threat-management-and-neither-should-you/)
19. [Art-of-WiFi UniFi API Browser](https://github.com/Art-of-WiFi/UniFi-API-browser)
20. [unifi-poller Client DPI Grafana Dashboard](https://grafana.com/grafana/dashboards/11310-unifi-poller-client-dpi-prometheus/)
