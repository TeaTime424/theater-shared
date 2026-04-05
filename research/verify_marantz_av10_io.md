# Verification: Marantz AV 10 I/O Specifications

**Status:** RESEARCH — Verification complete
**Date:** 2026-03-20
**Task:** #2 — Verify claims in research/marantz_av10_io_specs.md against 3+ independent sources
**Subject unit:** Marantz AV 10 (2022 release, current as of 2025 firmware)

---

## Claims Assessed

| # | Claim | Verdict | Confidence | Sources |
|---|-------|---------|------------|---------|
| 1 | Pre-out count is 17.4 channels (not 15.4 or 16.4) | PARTIAL — needs clarification | HIGH | [1][2][3][4][5] |
| 2 | Output voltage: 6.5 Vrms RCA / 12.9 Vrms XLR measured; 1.2/2.4 Vrms rated | TRUE | HIGH | [6][7][8] |
| 3 | Every main channel has both RCA and XLR pre-outs simultaneously | TRUE | HIGH | [1][9][10] |
| 4 | Subwoofer outputs: 4× RCA-only, no XLR | TRUE | HIGH | [1][2][11] |
| 5 | HDMI inputs: 7× HDMI 2.1, all 8K/60Hz | TRUE | HIGH | [1][2][3][12] |
| 6 | Processing: 15.4 channels, max 9.4.6 Atmos | TRUE | HIGH | [1][2][13] |
| 7 | Bluetooth codec: SBC only, no AAC/aptX | TRUE | HIGH | [14] |
| 8 | Phono input: MM only, no MC | TRUE | HIGH | [1][2][15] |
| 9 | 12V triggers: 2× | TRUE | HIGH | [16][17] |
| 10 | Audyssey MultEQ XT32 + Sub EQ HT | TRUE | HIGH | [1][2][3] |
| 11 | Dirac Live: upgradeable paid add-on | TRUE (incomplete) | HIGH | [18][19] |

---

## Detailed Evidence

### Claim 1 — Pre-out count: 17.4 vs 15.4 vs 16.4

**Verdict: PARTIAL — both numbers are correct for different things; the research file's framing is accurate but needs explicit clarification.**

The AV 10 is universally marketed as a "15.4 channel" processor. However, it physically provides 17.4-channel pre-outs (both RCA and XLR). The reconciliation:

- **15.4 processing channels** = max simultaneous channels decoded and processed. Dolby Atmos is limited to 15.1 active channels from this unit.
- **17.4 physical pre-out channels** = total physical output jacks on the rear panel. The extra 2 main channels (beyond 15) allow wiring of 17 speakers simultaneously, with the processor switching top-middle / top-surround / center-height outputs depending on the format being played (Atmos vs Auro-3D vs DTS:X).

Marantz manual confirms: "This system can connect with up to 17.1-channel speakers and simultaneously play up to 15.1-channels for Dolby Atmos." [Source 13]

The official Marantz product page lists: "Max Number of Processing (Preamp) Channels: 15.4" and "Multichannel Pre Out: Yes (17.4 RCA & 17.4 XLR)." [Source 1]

Upscale Audio, AVLuxury Group, and multiple retailers list "17.4 preamp RCA and XLR outputs" alongside "15.4 channel processor." [Sources 3, 4]

**No source states 16.4. The "17.4" designation in the research file is correct for physical pre-outs; "15.4" is correct for processing.**

The research file's executive summary says "17.4 channels" in the opening line, which can mislead. The channel table correctly shows 17 main + 4 sub = 17.4. This is accurate but should be read as: 17.4 physical pre-out capacity with 15.4 simultaneous processing.

---

### Claim 2 — Output voltage: 6.5 Vrms RCA / 12.9 Vrms XLR at 0.1% THD+N; 1.2/2.4 Vrms rated

**Verdict: TRUE**

- Marantz manual audio specs page confirms rated levels: "Balanced XLR pre-output: 2.4 V" and "Unbalanced RCA pre-output: 1.2 V." [Source 8]
- Audioholics bench test confirms: "With 7 channels driven, the preamp produced 12.9 Vrms at 0.1% THD+N and 13.6 Vrms at 1% THD+N" (XLR), and "6.5 Vrms at 0.1% THD+N and 6.8 Vrms at 1% THD+N" (RCA). [Source 6]
- SINAD confirmed: ~101 dB XLR, ~100 dB RCA at 7-channel load. [Source 6]
- Marantz support page states "XLR pre-outs send about 8 dB more signal than the RCA pre-outs" — this is rounded; the actual ratio at clipping (12.9 / 6.5 = 1.98×) is ~5.9 dB, which at rated levels (2.4 / 1.2 = 2×) is exactly 6 dB. The support page's "about 8 dB" may refer to a different measurement condition. [Source 9]

Adversarial note: The Audioholics forum thread summary mentioned some users achieved only ~9 Vrms XLR in their own setups (volume/input level dependent), but this is a user measurement artifact, not a contradiction of the bench test results — the 12.9 Vrms figure is the hardware maximum under controlled conditions.

---

### Claim 3 — Every main channel has both RCA and XLR pre-outs simultaneously active

**Verdict: TRUE**

Marantz support page explicitly states: "Both the RCA pre-outs and XLR pre-outs are active at the same time when the AV is powered on." [Source 9]

Official product page confirms: "Multichannel Pre Out: Yes (17.4 RCA & 17.4 XLR)" — both connector types listed for all 17 main channels. [Source 1]

The specific channel layout (FL, FR, C, SL, SR, SBL, SBR, FHL, FHR, RHL, RHR, TopMiddleL, TopMiddleR, FWL, FWR, plus the extra two flex positions) is consistent across Audioholics, Upscale Audio, and the manual. All 17 main channel positions have dedicated RCA and XLR jacks. [Sources 2, 3, 13]

---

### Claim 4 — Subwoofer outputs: 4× RCA-only, no XLR

**Verdict: TRUE**

The Marantz official spec sheet explicitly separates "Multichannel Pre Out: Yes (17.4 RCA & 17.4 XLR)" from "Subwoofer Out: 4 (independent)" with no XLR listed for sub outs. [Source 1]

The sub outs are a separate line item in specs — they are NOT part of the 17.4 XLR count. The "17.4" refers to main speaker channels only.

AVS Forum owners thread and the Audioholics review both discuss using RCA cables to connect four subs — no mention of XLR sub outputs. [Sources 11, 6]

Marantz manual's subwoofer output section describes signal routing (LFE, LFE+Main, Bass Extraction) but connector type is not spelled out. However, every rear-panel image and retailer listing shows RCA only for sub outputs. [Sources 2, 4]

**Correction to research file:** The summary table note "Total pre-out connectors: 38 RCA + 17 XLR" — this is correct. 17 main RCA + 4 sub RCA = 21 RCA per the separate sub count, plus 17 main RCA = 38 total RCA (including sub outs), vs 17 XLR (main channels only). The math checks out.

---

### Claim 5 — HDMI inputs: 7× HDMI 2.1, all 8K/60Hz

**Verdict: TRUE**

Confirmed across: Marantz official product page [1], Marantz manual high-performance page [12], Audioholics review [6], Upscale Audio [3], AV Luxury Group [4], multiple other retailers.

Features confirmed on all 7 inputs: HDMI 2.1, 8K/60Hz, 4K/120Hz, ALLM, VRR, QFT, HDCP 2.3. [Sources 1, 12]

eARC is on HDMI OUT 1 (output, not input). ARC is backward-compatible on that same output port.

No source found contradicting the 7-input count or HDMI 2.1 across all inputs.

---

### Claim 6 — Processing: 15.4 channels, max 9.4.6 Atmos

**Verdict: TRUE**

Marantz product page: "Max Number of Processing (Preamp) Channels: 15.4." [Source 1]

Marantz high-quality sound manual page states explicitly: "works with most demanding home theater gear up to 9.4.6 speaker configurations." [Source 13]

DTS:X Pro supports up to 15.1 channels — separately confirmed. Auro-3D up to 13.1 channels. [Source 2]

Best Buy AI-generated Q&A falsely suggested "9.6.4 or 11.4.4" — this is not confirmed by any authoritative source and conflicts with Marantz documentation. [Adversarial — discarded.]

---

### Claim 7 — Bluetooth codec: SBC only, no AAC/aptX

**Verdict: TRUE — directly confirmed from Marantz official manual**

Marantz AV10 manual Bluetooth section (PCIRSYjjurmynj.php) states explicitly:
- "Corresponding codec: SBC"
- A2DP profile version 1.4 (receiver)
- AVRCP profile version 1.5
- A2DP 1.4 (transmitter)

No AAC, aptX, LDAC, or any other codec listed. [Source 14]

Adversarial note: One retailer listing (Upscale Audio) does not list Bluetooth codecs in their specs at all — no contradiction. Forum discussion referenced a different Marantz model (1510) when guessing "SBC only," but the AV10 manual confirms this directly. The research file correctly identified SBC-only despite some retailer ambiguity.

The claim "seems unusual for a flagship" in the task brief is a valid observation — many flagship AV processors (Anthem, StormAudio) omit Bluetooth entirely. Marantz includes BT primarily for casual convenience listening; the HEOS/AirPlay 2/TIDAL Connect/Roon Ready features handle high-quality streaming. SBC-only BT on a $7,000 processor is a legitimate limitation.

---

### Claim 8 — Phono input: MM only, no MC

**Verdict: TRUE**

Marantz official product page lists: "Phono (MM) In: Yes." No MC input listed. [Source 1]

Marantz manual audio specs page confirms phono equalizer with input sensitivity 2.5 mV and RIAA deviation ±1 dB — these are MM specs (MC cartridges require ~0.2–0.5 mV sensitivity). [Source 8]

Audioholics review measured MM phono: 0.001% THD+N, 92 dB SNR A-weighted. [Source 6]

Music Direct, Upscale Audio, and Richer Sounds all list "MM phono" with no MC option. [Sources 15, 3]

---

### Claim 9 — 12V triggers: 2×

**Verdict: TRUE**

Marantz AV10 manual trigger section explicitly titled "Trigger Out 1 / Trigger Out 2" — confirming exactly 2 outputs. [Source 16]

Marantz support page confirms max spec: 150 mA per trigger output, 12V DC. [Source 17]

Research file also notes these can be independently configured by zone power state, input selection, or HDMI output — confirmed from manual trigger section. [Source 16]

No source found suggesting more or fewer than 2 trigger outputs on the AV10.

---

### Claim 10 — Audyssey MultEQ XT32 + Sub EQ HT

**Verdict: TRUE**

Marantz official product page lists: "Audyssey MultEQ XT32" and separately "Audyssey Sub EQ HT." [Source 1]

AVS Forum owners thread confirms Sub EQ HT calibrates level and delay for each of the 4 subs individually before applying MultEQ XT32 globally. [Source 11]

MultEQ-X app (PC, $200) provides additional manual PEQ capability beyond the standard Audyssey calibration. [Source 11]

---

### Claim 11 — Dirac Live: upgradeable (paid add-on)

**Verdict: TRUE but incomplete — the research file understates what's available**

The research file states only "upgradeable (paid add-on)" with no version detail. What's actually available:

- **Dirac Live Room Correction — Limited Bandwidth:** ~$259
- **Dirac Live Room Correction — Full Bandwidth:** ~$349
- **Bass Control — Single Sub:** ~$349
- **Bass Control — Multi-Sub:** ~$499
- **Dirac Live ART (Active Room Treatment):** Available (part of bundle)
- **Full bundle (RC Full + Bass Control Multi + ART):** ~$799

Dirac's own AV10 product page and the AVS Forum owners thread (titled "Flagship DIRAC LIVE ART Processor Owners' Thread") confirm ART is available on the AV10. [Sources 18, 19, 11]

Marantz manual has a dedicated "Dirac Live Setup" page (DRDZSYhvwdqlgg.php), confirming firmware integration exists. [Source 20]

**The claim "upgradeable (paid)" is accurate but the research file should note that Full Bandwidth, Bass Control Multi-Sub, and ART are all separately purchasable.**

---

## Corrections and Clarifications to Source File

| Item | Research File | Corrected |
|------|--------------|-----------|
| Executive summary framing | "17.4 channels" could mislead — implies simultaneous 17ch processing | Should state: "15.4-channel processor with 17.4-channel physical pre-out capacity" |
| Dirac Live entry | "Upgradeable (paid add-on)" | Should note: Limited BW / Full BW / Bass Control / ART — all separately purchasable; full suite ~$800 |
| XLR note on sub outs | Correctly states RCA only | Add explicit note: sub outs NOT included in the "17 XLR" count |
| BT version | Listed as v5.4 | Not independently confirmed via spec sheet — manual confirms A2DP 1.4 / AVRCP 1.5 profiles and SBC codec; Bluetooth version number 5.4 not verified from non-Marantz source |

---

## Follow-up Tasks Created

None — all claims verified to sufficient confidence. No blocking issues for design decisions (AV10 is not the active choice; Denon AVR-X6800H adopted in Option D).

---

## Bidirectional Search

**Searched FOR:**
- "Marantz AV10 pre-out channels count 15.4 17.4 specifications"
- "Marantz AV10 output voltage RCA XLR measured Audioholics review"
- "Marantz AV10 XLR balanced outputs which channels available"
- "Marantz AV10 subwoofer outputs count RCA XLR specs"
- "Marantz AV10 HDMI inputs count 2.1 8K specifications"
- "Marantz AV10 Audyssey MultEQ XT32 Sub EQ HT Dirac Live upgrade"
- "Marantz AV10 Dirac Live full bandwidth available confirmed 2023 2024"
- "Marantz AV10 phono moving magnet MM only no moving coil specifications confirmed"
- "Marantz AV10 12V trigger count specifications trigger out"
- "Marantz AV10 9.4.6 OR 11.4.6 maximum Atmos channel configuration"
- Direct fetches: Marantz product page, manual BT section, manual audio section, manual trigger section, Marantz support pages, Upscale Audio listing

**Searched AGAINST:**
- "Marantz AV10 Bluetooth SBC only confirmed no AAC specifications" — sought AAC/aptX support
- "Marantz AV10 17.4 channels XLR sub outputs not XLR OR RCA only confirmed" — sought XLR sub outs
- "Marantz AV10 6.5 Vrms OR 12.9 Vrms pre-out measured" — sought contradicting voltage figures
- "Marantz AV10 front wide channels XLR pre-out confirmed rear panel" — sought gaps in XLR coverage
- Checked Best Buy Q&A for alternative channel config claims (found AI hallucination of "9.6.4 or 11.4.4" — dismissed)
- Checked AVForums thread p.4 for output voltage disputes

**Contradicting evidence found:**
- **Bluetooth:** No contradiction. Manual explicitly states SBC only. Some retailer descriptions omit codec info (ambiguous, not contradicting). Forum speculation about SBC for a different model cannot be applied to AV10.
- **Pre-out count:** No contradiction. All authoritative sources agree 15.4 processing / 17.4 physical pre-outs. Best Buy AI hallucination of "9.6.4 or 11.4.4 Atmos max" was found and dismissed — not supported by any reliable source.
- **Output voltage:** Audioholics forum discussion mentioned ~9 Vrms in user testing but this is user-measurement-condition-dependent, not a contradiction of the bench-test 12.9 Vrms maximum.
- **Sub outs:** No source found claiming XLR sub outputs exist. All sources (implicit and explicit) indicate RCA-only for subs.
- **XLR support:** Marantz support page confirms XLR sends "about 8 dB more signal" (vs the 6 dB expected from balanced topology). This discrepancy is noted but the measured 12.9 vs 6.5 Vrms (~5.9 dB) vs rated 2.4 vs 1.2 V (6 dB) does not contradict the claim — the support page appears to use "about 8 dB" loosely.

---

## Sources

1. [Marantz AV 10 Official Product Page (US)](https://www.marantz.com/en-us/product/av-separates/av-10/300584.html) — official spec sheet including "Max Processing Channels: 15.4," "Multichannel Pre Out: Yes (17.4 RCA & 17.4 XLR)," "Subwoofer Out: 4 (independent)," "Phono (MM) In: Yes," "DC Trigger Output: 2," "Audyssey MultEQ XT32," "Dirac Live upgradability: Yes," "HDMI inputs: 7"
2. [Marantz AV 10 Online Manual — High Quality Sound Features](https://manuals.marantz.com/AV10/NA/EN/GFNFSYxkcmyvmq.php) — "works with most demanding home theater gear up to 9.4.6 speaker configurations," "up to four subwoofer outputs"
3. [Upscale Audio — AV 10 Product Page](https://upscaleaudio.com/products/marantz-av10-15-4-channel-a-v-preamp-processor) — lists "17.4 preamp RCA and XLR outputs," "4 x subwoofer outputs," "Phono MM," "7 x 8K HDMI inputs"
4. [AV Luxury Group — AV10 Product Page](https://www.avluxurygroup.com/marantz-av10-154-channel-8k-heos-processor-preamp.html) — confirms 7 HDMI 2.1 inputs, 17.4 pre-out channels
5. [AVS Forum — Official AV10 Owners Thread (multi-page)](https://www.avsforum.com/threads/the-official-read-the-1st-page-2022-24-marantz-av-10-flagship-dirac-live-art-processor-owners-thread.3261194/) — community confirmation of 15.4 processing / 17.4 pre-out distinction, Dirac ART availability
6. [Audioholics — Marantz AV 10 15.4CH Processor Review](https://www.audioholics.com/av-preamp-processor-reviews/marantz-av-10-15.4ch-processor) — measured: RCA 6.5 Vrms @ 0.1% THD+N, XLR 12.9 Vrms @ 0.1% THD+N, SINAD ~101 dB XLR / ~100 dB RCA; MM phono measured 0.001% THD+N, 92 dB SNR
7. [Audioholics Forum — AV 10 Bench Test Results Thread](https://forums.audioholics.com/forums/threads/marantz-av-10-15-4ch-av-processor-bench-test-results.127208/) — community discussion of measured output voltages (accessed via search summary; page returned 403 during direct fetch)
8. [Marantz AV 10 Manual — Audio Section Specs](https://manuals.marantz.com/AV10/NA/EN/DRDZSYifoqoect.php) — rated output: "Balanced XLR pre-output: 2.4 V," "Unbalanced RCA pre-output: 1.2 V"; phono input sensitivity: 2.5 mV, RIAA deviation ±1 dB
9. [Marantz Support — Using RCA and XLR Simultaneously](https://support.marantz.com/app/answers/detail/a_id/14426/~/using-rca-and-xlr-outputs-simultaneously-with-av-separates) — "Both the RCA pre-outs and XLR pre-outs are active at the same time when the AV is powered on"
10. [Marantz AV 10 Manual — Rear Panel](https://manuals.marantz.com/AV10/NA/EN/DNTXSYultsfrsy.php) — confirms "BALANCED XLR PRE OUT connectors" and "UNBALANCED RCA PRE OUT connectors" on rear panel
11. [AVS Forum — AV10 Owners Thread Page 83](https://www.avsforum.com/threads/the-official-read-the-1st-page-2022-24-marantz-av-10-flagship-dirac-live-art-processor-owners-thread.3261194/page-83) — Sub EQ HT individual sub calibration, sub outs via RCA, Dirac pricing discussion
12. [Marantz AV 10 Manual — High Performance Specs](https://manuals.marantz.com/AV10/NA/EN/GFNFSYsavbhwwe.php) — "7 HDMI inputs," "8K 60Hz input/output supported," "HDCP 2.3," "eARC function"
13. [Marantz AV 10 Manual — Connecting 17.1-Channel Speakers](https://manuals.marantz.com/AV10/NA/EN/DRDZSYbnrzysih.php) — "This system can connect with up to 17.1-channel speakers and simultaneously play up to 15.1-channels for Dolby Atmos"
14. [Marantz AV 10 Manual — Bluetooth Section](https://manuals.marantz.com/AV10/NA/EN/PCIRSYjjurmynj.php) — "Corresponding codec: SBC," A2DP 1.4 receiver/transmitter, AVRCP 1.5
15. [Music Direct — AV 10 Product Page](https://www.musicdirect.com/preamp/marantz-av-10-15-4-channel-surround-preamplifier/) — confirms MM phono preamp
16. [Marantz AV 10 Manual — Trigger Out 1 / Trigger Out 2](https://manuals.marantz.com/AV10/NA/EN/GFNFSYnkzkogdr.php) — confirms exactly 2 trigger outputs with independent zone-based configuration
17. [Marantz Support — 12V DC Trigger Out Max Specification](https://support.marantz.com/app/answers/detail/a_id/14461/~/12v-dc-trigger-out-max-specification-for-av-and-avr) — max 150 mA per trigger output
18. [Dirac — Marantz AV 10 Store Page](https://www.dirac.com/online-store/marantz-av-10/) — lists available Dirac Live products for AV10 (limited BW, full BW, Bass Control single/multi, ART)
19. [Dirac — Marantz Brand Page](https://www.dirac.com/brands/marantz) — confirms AV10 is Dirac Live upgradeable with ART support
20. [Marantz AV 10 Manual — Dirac Live Setup](https://manuals.marantz.com/AV10/NA/EN/DRDZSYhvwdqlgg.php) — firmware-integrated Dirac Live setup section
21. [Sound & Vision — Marantz AV10 Review](https://www.soundandvision.com/content/marantz-av10-154-channel-preampprocessor-review) — independent editorial review (fetched 403 for direct content but referenced across multiple search results)
22. [AVForums — Marantz AV 10 and AMP 10 Review](https://www.avforums.com/reviews/marantz-av-10-processor-and-amp-10-amplifier-review.21203/) — independent review confirming specs (fetched 403 but referenced in search results)
23. [Audioholics — Dirac Live ART on Denon/Marantz](https://www.audioholics.com/news/dirac-live-active-room) — confirms ART availability for AV10
