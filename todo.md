# DSP Bench Test — TODO

## Forum Research Summary (2026-03-20)

**B0CJBV1KMP findings:**
- Undervolted supply rails (SGM8904 gets 3.18V vs 5V spec) — limits output swing, worsens THD
- PT2259 volume ICs in signal path between DAC and RCA out — can only attenuate, not bypass without PCB mod
- Power-on pop (no mute circuit) — manage with power sequencing
- Community consensus: adequate for sub duty at $37
- Use clean 5V supply, NOT USB power

**Ebtech LLS-8: REJECTED** — $300-350 (not $200), zero headroom for 1200AS2, transformer saturation risk below 20 Hz

**898B findings:**
- Zero independent reviews or measurements anywhere online
- Only ~5 units sold on eBay over years of listing
- Gain ambiguous: page says "-10 to +4" (~12 dB), earlier claim of "~14 dB" not found on current page
- Company legit (founded 1988, 100% eBay feedback) but tiny/unresponsive
- $389 is steep for unproven product; DIY THAT1646/DRV134 is $50-80 alternative

---

## Equipment Needed
- ADAU1701 preamp unit (Amazon B0CJBV1KMP, owned)
- ICP5 programmer (owned)
- MOTU M2 (owned)
- REW 5.40 (installed)
- Multimeter (owned)
- RCA cables (2×)
- SigmaStudio 4.7 (installed)
- Clean 5V power supply (NOT USB — use linear or quality SMPS)

## Pre-Test Setup
- [ ] Flash flat passthrough program via SigmaStudio (Input 0 → DAC0, Input 1 → DAC1, no filters, no gain)
- [ ] Connect loopback: MOTU M2 line out → unit RCA in → DSP passthrough → unit RCA out → MOTU M2 line in
- [ ] Power from clean 5V supply (not PC USB — noise concern from forum reports)

## Test 1: Output Voltage
- [ ] Feed 1 kHz sine from REW generator through loopback
- [ ] Measure RCA output with multimeter (AC volts on center pin + shield)
- [ ] Confirm ~0.9 Vrms (ADAU1701 internal DAC spec)
- [ ] NOTE: PT2259 in signal path — ensure volume pot is at max (0 dB attenuation)
- [ ] Cross-check: read dBFS in REW, subtract from +18 dBu (MOTU M2 clip level = 6.15 Vrms)
- [ ] If output << 0.9 Vrms: undervolted rails may be limiting swing (see forum research)

## Test 2: Noise Floor
- [ ] Disconnect input (leave RCA in open or shorted)
- [ ] Measure RCA output into MOTU M2
- [ ] Record noise floor in dBFS
- [ ] Pass: < -90 dBFS broadband; note sub-band (5-200 Hz) separately
- [ ] If fail: try with ICP5 disconnected (known noise injection source)

## Test 3: THD
- [ ] Feed sine through loopback at 20 Hz, 50 Hz, 80 Hz
- [ ] Measure THD in REW for each frequency
- [ ] Pass: < -80 dB (0.01%)
- [ ] NOTE: Forum report of 0.115% THD on similar board with undervolted rails — if THD is high, voltage regulator bypass mod may fix it

## Test 4: Frequency Response
- [ ] Run REW sweep through loopback (5 Hz to 200 Hz)
- [ ] Check flatness
- [ ] Pass: ±0.5 dB from 5 Hz to 200 Hz

## Test 5: Thermal Stability (NEW — from forum research)
- [ ] Run continuous 50 Hz sine at -6 dBFS for 60 minutes
- [ ] Re-measure THD and output voltage after thermal soak
- [ ] Pass: no degradation >1 dB or THD increase >10×
- [ ] NOTE: diyAudio report of ADAU1701 distortion after 30 min (missing DC bias resistor on coupling cap) — watch for this

## Decision Gate 1 (Unit Alone)
- Tests 1-5 pass → order 898B ($389, sonicimagerylabs.com) OR evaluate DIY THAT1646/DRV134 alternative ($50-80)
- Noise or THD fail → fall back to Option A (external PCM5102 + THAT1646 DIY)
- **Decision factor:** 898B is turnkey but unproven ($389); THAT1646 is proven IC but requires PCB build. Weigh based on bench results and available time.

## Test 6: 898B Gain Verification (after 898B arrives)
- [ ] Manufacturer page says "-10 dBV to +4 dBu" = ~12 dB; earlier research cited "~14 dB"
- [ ] Feed known voltage (0.9 Vrms from ADAU1701 unit) into 898B
- [ ] Measure balanced output voltage with multimeter (AC, 1 kHz)
- [ ] If +12 dB: output = ~3.6 Vrms → 616W from ICEpower (good)
- [ ] If +14 dB: output = ~4.5 Vrms → need DSP gain trim of -2 dB to avoid clipping ICEpower
- [ ] Pass: output voltage between 3.0-4.5 Vrms balanced (trimmable in DSP)

## Test 7: System Noise Floor with 898B Gain (after 898B arrives)
- [ ] Connect: ADAU1701 unit (no input, passthrough program) → 898B → MOTU M2 line in
- [ ] Measure noise floor in dBFS — this includes DAC noise amplified by 898B
- [ ] Pass: < -80 dBFS (relaxed from -90 because 898B adds ~12-14 dB gain to DAC noise)
- [ ] NOTE: 898B spec says -101 dBu noise — if real-world is 6-10 dB worse, still below ICEpower 1200AS2 own noise floor

## Decision Gate 2 (Full Chain)
- Tests 6-7 pass → proceed with Option B full build
- Noise fail → fall back to Option A (external PCM5102 + THAT1646 DIY)

## If Pass: Next Steps
- [ ] Order second ADAU1701 unit ($37, Amazon B0CJBV1KMP)
- [ ] Build 4× XLR-to-JST P105 adapter cables
- [ ] Update POR/15 with confirmed board model
- [ ] Verify EEPROM write persistence (ICP5 silent failure risk — keep hex backups)
- [ ] Add power-on mute relay or sequencing to prevent pop

---

## Public Shared-State Repo (for phone/laptop Claude sync)

**Goal:** Create a public GitHub repo containing theater project MD files so Claude
on phone (claude.ai/code cloud) and Claude on laptop can read/write the same state
without the laptop needing to be on.

**What to include:**
- `POR/` — all plan-of-record docs (design specs, budget, build plans, appendices)
- `research/` — research outputs, verification reports, comparisons
- `experiments/` — subwoofer build specs, cut lists, build guides
- `team_test*/` — agent team outputs (design iterations)
- `.claude/commands/` and `.claude/skills/` — skill/agent definitions
- `CLAUDE.md` — project instructions
- `todo.md` — this file

**What to EXCLUDE (keep private in monorepo only):**
- Any file containing street address, phone, email, or full name
- `.claude/settings.local.json` (API keys, MCP config)
- `tools/` (local-only scripts: psmux, dsp, session trace)
- `handoffs/` (may reference local paths, session IDs)
- Python scripts, .env, credentials

**PII scrub required before publishing:**
- "Central NC" appears in ~10 files (HVAC climate refs, permit context). Decide:
  replace with generic "Central NC" or leave as-is (city-level, not identifying).

**Steps:**
- [ ] Create repo `TeaTime424/theater-shared` (public) on GitHub
- [ ] Write a sync script that exports eligible MD files, strips PII patterns
- [ ] Add GitHub Action or local hook to auto-sync on push to monorepo
- [ ] Test: clone from claude.ai/code cloud session, verify read+write+push
- [ ] Add CLAUDE.md to shared repo explaining its purpose and sync relationship
- [ ] Update laptop CLAUDE.md with instructions to push to both repos on commit
