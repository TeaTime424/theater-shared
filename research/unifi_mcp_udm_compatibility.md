# Verification: UniFi MCP Servers — UDM Compatibility

**Date:** 2026-03-28
**Status:** RESEARCH — Not adopted

---

## Claims Assessed

| # | Claim | Verdict | Confidence | Sources |
|---|-------|---------|------------|---------|
| 1 | sirkirby/unifi-mcp works with UDM / UDM-Pro / UDM-SE | TRUE (with caveats — version matters) | HIGH | [1][2][3] |
| 2 | enuno/unifi-mcp-server works with UDM / UDM-Pro | PARTIAL — UDM Pro verified for ZBF; general UDM unclear | MEDIUM | [4][5] |
| 3 | UDM exposes same REST API as Cloud Key / self-hosted controller | FALSE — UDM uses different path prefix (`/proxy/network/`) and port 443 vs 8443 | HIGH | [2][6][7] |
| 4 | API keys are generated via Settings > Admin | PARTIAL — correct path is Settings > Control Plane > Integrations | HIGH | [8] |
| 5 | Both servers connect via local IP | TRUE for local gateway mode; cloud options exist but are limited | HIGH | [1][4][9] |
| 6 | sirkirby requires Python 3.13+ | TRUE | HIGH | [1][10] |
| 7 | enuno requires Python 3.10+ | TRUE | HIGH | [4] |
| 8 | Windows dependency issues exist | POSSIBLE — Python 3.13 + uvx on Windows has known path issues in broader MCP ecosystem | MEDIUM | [11] |

---

## Detailed Evidence

### Claim 1: sirkirby/unifi-mcp + UDM

**Was broken, now fixed.** GitHub Issue #19 (now closed) confirmed that connecting to UniFi OS devices (UDM-Pro, UXG-Pro) failed with `404 Not Found` even with correct credentials. Root cause: the MCP was calling `/api/...` directly instead of `/proxy/network/api/...` — the path required on all UniFi OS consoles.

**Fix shipped in v0.1.4** (PR #22). The fix adds automatic detection of UniFi OS and uses the correct proxy path. A manual override env var is also available.

Verified minimum versions for the fix to work:
- **unifi-mcp:** v0.1.4+
- **UniFi OS:** 4.18.0+ (tested on UDM-Pro SE per Issue #19)
- **UniFi Network app:** 9.4.19+

The primary auth method is **username/password** (`UNIFI_HOST`, `UNIFI_USERNAME`, `UNIFI_PASSWORD`). API key support (`UNIFI_API_KEY`) exists but is marked **experimental and read-only** with only a subset of the 130+ tools active.

### Claim 2: enuno/unifi-mcp-server + UDM

The project explicitly targets "UniFi Network 9.0+ users." The TODO.md confirms ZBF tools have been **verified working on UDM Pro**. The project's codebase includes explicit handling for the local gateway API path prefix (`/proxy/network/`) — this was a known problem they built around.

However, only 2 of 15 Zone-Based Firewall (ZBF) endpoints were found to actually exist in UniFi API v10.0.156 — the rest are not exposed via the API at all and must be configured via the web UI. Mutating ZBF operations (create/update/delete) are untested as of the last TODO update.

Auth is **API key only** (`UNIFI_API_KEY`), sourced from Settings > Control Plane > Integrations. This is cleaner than username/password for production use.

### Claim 3: UDM API vs Cloud Key / self-hosted controller

This is the most critical difference and the root cause of most MCP failures on UDM:

| Attribute | Legacy (CK Gen1, self-hosted) | UniFi OS (UDM, CK Gen2+) |
|-----------|------------------------------|--------------------------|
| Port | 8443 | 443 |
| Auth endpoint | `/api/login` | `/api/auth/login` |
| API path prefix | `/api/...` | `/proxy/network/api/...` |
| API key support | No | Yes |
| `is_udm_pro` flag | False | True |

Any library or MCP server written for the legacy controller will fail on UDM unless it explicitly handles the `/proxy/network/` prefix. Both sirkirby (fixed in v0.1.4) and enuno (built-in from the start using the official API) handle this correctly in current versions.

### Claim 4: API Key Generation Location

Ubiquiti's official path is: **Settings > Control Plane > Integrations** (not Settings > Admin > API Keys as sometimes cited in older guides). The key inherits permissions from the creating admin account. API keys are available **only on UniFi OS consoles** — not on legacy software controllers or CK Gen1. No specific minimum UniFi OS firmware version is documented by Ubiquiti, but empirically UniFi OS 3.x+ supports this (shipped ~2023).

### Claim 5: Local vs Cloud connection

**sirkirby:** Defaults to local IP via `UNIFI_HOST`. Also offers a Cloudflare Worker relay for cloud access without exposing local ports. This is optional; local-only works fine.

**enuno:** Three modes documented:
- **Local Gateway API** (recommended) — direct HTTPS to your gateway IP. Full read/write access.
- **Cloud Early Access API** — aggregate statistics only, no device/client access, no config changes.
- **Cloud V1 API** — same limitation as above.

For any serious management use, local IP is the only viable option for both servers.

### Claims 6 & 7: Python versions

- **sirkirby/unifi-mcp:** Requires Python **>=3.13**. This is a hard requirement — the package will refuse to install on 3.12.
- **enuno/unifi-mcp-server:** Requires Python **>=3.10**. More permissive; works on 3.10, 3.11, 3.12, 3.13.

### Claim 8: Windows dependency issues

No Windows-specific issues are documented in either repo's GitHub issues. However, the broader MCP ecosystem on Windows has known friction points:

1. **Python 3.13 on Windows:** sirkirby requires 3.13 which is very recent. Some MCP wrapper tooling (uvx) has documented path issues on Windows — use full path to `uvx.exe` if needed, or prefer `pip install` + direct invocation.
2. **SSL certificates:** Both servers default to `UNIFI_VERIFY_SSL=false` which sidesteps the self-signed cert problem common on local UDM installs.
3. **No native Windows install docs** found in either repo.

---

## Key Decision Factors

**Which server to use:**

| Factor | sirkirby | enuno |
|--------|----------|-------|
| Stars | ~223 | ~86 |
| Auth | username/password (API key experimental) | API key (cleaner) |
| Python | 3.13+ (restrictive) | 3.10+ (permissive) |
| UDM fix | Required v0.1.4+ upgrade | Built-in from start |
| Tool count | 130+ (Network alone) | Smaller set, focused |
| Maturity | Stable (Network); Beta (Protect, Access) | ~95% Phase 1 complete |
| Windows docs | None | None |
| Uses official API | No (aiounifi library) | Yes (official UniFi API) |

**enuno** uses the **official Ubiquiti API** — more stable against firmware updates. **sirkirby** uses the `aiounifi` community library, which is battle-tested (used by Home Assistant) but unofficial and can lag behind firmware changes.

---

## Follow-up Tasks Created

None — this is a standalone verification. If proceeding to install, recommend testing enuno first (Python 3.10+ permissive, API key auth, official API, UDM Pro verified).

---

## Bidirectional Search

- **Searched FOR:**
  - "sirkirby unifi-mcp GitHub UDM Dream Machine setup works"
  - "enuno unifi-mcp-server GitHub PyPI UDM Dream Machine"
  - "UniFi Dream Machine REST API local access API key UniFi OS"
  - "unifimcp.com sirkirby UniFi OS version required minimum UDM documentation"

- **Searched AGAINST:**
  - "unifi-mcp UDM dream machine not working issue error 2025 2026"
  - "unifi-mcp-server enuno UDM issue GitHub problems authentication"
  - "UniFi API UDM different from Cloud Key controller legacy vs UniFi OS API path proxy"
  - "unifi-mcp Windows Python dependency issue pip install error"
  - "unifi mcp UDM dream machine not working" (explicit adversarial query)

- **Contradicting evidence found:** YES
  - **Critical:** sirkirby v0.1.4 was the fix version — older releases do NOT work on UDM (GitHub Issue #19, now resolved)
  - **Critical:** UDM API is NOT the same as legacy controller — different port (443 vs 8443), different auth endpoint, and requires `/proxy/network/` path prefix
  - **Partial:** enuno's ZBF tools — only 2 of 15 endpoints actually exist in the UniFi API; the rest are UI-only
  - **Caution:** Python 3.13 requirement (sirkirby) has known friction with uvx on Windows
  - **Caution:** sirkirby API key support is read-only and experimental — username/password required for full functionality

---

## Sources

1. [GitHub - sirkirby/unifi-mcp (redirects to unifi-network-mcp)](https://github.com/sirkirby/unifi-network-mcp)
2. [UniFi OS Server compatibility Issue #19 — sirkirby/unifi-mcp](https://github.com/sirkirby/unifi-mcp/issues/19)
3. [sirkirby/unifi-network-mcp on DeepWiki](https://deepwiki.com/sirkirby/unifi-network-mcp)
4. [GitHub - enuno/unifi-mcp-server](https://github.com/enuno/unifi-mcp-server)
5. [enuno/unifi-mcp-server TODO.md](https://github.com/enuno/unifi-mcp-server/blob/main/TODO.md)
6. [Ubiquiti Community Wiki — UniFi Controller API](https://ubntwiki.com/products/software/unifi-controller/api)
7. [How to Access UniFi API on UDM Pro — Ubiquiti Community](https://community.ui.com/questions/How-to-Access-to-UniFi-API-on-UniFi-Dream-Machine-Pro/9334211d-945e-44cd-9407-a5b21dbef15b)
8. [Getting Started with the Official UniFi API — Ubiquiti Help Center](https://help.ui.com/hc/en-us/articles/30076656117655-Getting-Started-with-the-Official-UniFi-API)
9. [UniFi MCP Server by enuno — PulseMCP](https://www.pulsemcp.com/servers/gh-enuno-unifi)
10. [unifi-network-mcp on PyPI](https://pypi.org/project/unifi-network-mcp/)
11. [Windows Local Development Setup Issue - uvx Configuration Error (MCP ecosystem)](https://github.com/oraios/serena/discussions/373)
