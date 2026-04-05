# POR Core Extract — Task 9

Sources read: CLAUDE.md (Option D section), Garage_Conversion_Option1.md, 01_Project_Overview_and_Room.md, 02_Front_Stage_System.md, 03_Subwoofer_System.md, 05_Speaker_System.md
Note: Files 01_Room_and_Layout.md / 02_Speakers.md / 03_Subwoofers.md / 04_Amplification.md do not exist. Mapped to actual POR files above.

---

## 1. Room Dimensions & Partition Layout

### POR Rev 5.2 (01_Project_Overview_and_Room.md) — SUPERSEDED
| Parameter | Value |
|-----------|-------|
| Width | 16 ft |
| Depth | 26 ft |
| Height | 10 ft |
| Volume | 4,160 cu ft |
| Config | 9.4.6 Dolby Atmos |
| SPL target | THX Reference 115 dB |

### Garage_Conversion_Option1.md — E-W layout (v1–v3.3) — SUPERSEDED by Option D
| Zone | Dimensions | Notes |
|------|-----------|-------|
| Theater | 25' W × 14' D × 10' H | 3,500 cu ft, screen on west wall |
| Equipment closet | 4' × 6' | NE corner |
| Vestibule | 4' × 8' | Light-lock entry |
| Gym | 26' W × 8' D | South half |

### Option D (CLAUDE.md + Garage_Conversion_Option1.md v3.4+) — ACTIVE
| Parameter | Value |
|-----------|-------|
| Building | 29' × 23' × 10' detached garage |
| Partition orientation | N-S at ~12' from west wall |
| Theater (east side) | 17' W × 23' D × 10' H = 3,910 cu ft |
| Gym (west side) | 12' W × 23' D |
| Equipment closet | 4' × 4' NE corner of gym |
| Screen wall | North wall (17' wide) |
| Screen | 170" 16:9 AT |
| HVAC | MrCool DIY 12K on partition wall |
| Seating (Row 1 MLP) | 17' from screen (approx) |

---

## 2. Speaker Models, Sensitivity, Impedance

Source: 05_Speaker_System.md (Rev 7.0) + Garage_Conversion_Option1.md + CLAUDE.md

| Channel | Model | Qty | Sensitivity | Impedance | Min Z |
|---------|-------|-----|-------------|-----------|-------|
| L, C, R | DIYSG Titan-815LX | 3 | 99 dB/2.83V/1m | 6Ω nominal | 4.2Ω @ 110Hz |
| SL, SR, SBL, SBR (surrounds) | DIYSG Volt-10 V2 | 4 | 95 dB/2.83V/1m | 8Ω | — |
| Atmos (TFL/TFR/TRL/TRR or 6ch) | DIYSG Volt-10 V2 | 6 | 95 dB/2.83V/1m | 8Ω | — |
| FWL, FWR (front wide) | DIYSG Volt-10 V2 | 2 (Option D only, 9.4.4) | 95 dB/2.83V/1m | 8Ω | — |

**Note:** Volt-10 sensitivity was previously documented as 98 dB in v5.0 — WRONG. Correct spec is 95 dB per DIYSG official. Flagged in both 05_Speaker_System.md and Garage_Conversion_Option1.md.

---

## 3. Sub Driver Specs — Dayton UMII18-22

Source: 03_Subwoofer_System.md

| Parameter | Value as stated | Flag |
|-----------|----------------|------|
| Fs | 22 Hz | OK |
| Qts | 0.53 | OK (NOT 0.36) |
| Qes | 0.67 | OK |
| Qms | 2.53 | OK |
| Vas | 248.2 L (8.77 ft³) | OK (NOT 15.5L) |
| Xmax | 28 mm (Klippel verified @ 70% BL) | OK |
| Sd | 1,184 cm² (183.5 sq in) | OK |
| Re | 4.2Ω (VCs in series) | OK |
| Mms | 420g | OK |
| BL | 19.2 T·m | OK |
| Sensitivity | 90.7 dB/2.83V/1m | OK |
| VC config | Dual 2Ω | Only 2Ω and 8Ω series practical |
| RMS Power | 1,200W AES 426B | OK |
| Peak Power | 2,400W | OK |
| Unit cost | $349.98 | — |

**Vas=15.5 or Qts=0.36 NOT FOUND in any source doc.** These values do not appear in the POR. If seen elsewhere, flag as incorrect.

---

## 4. Sub Cabinet Dimensions — Conflicts Noted

### POR Rev 5.9 (03_Subwoofer_System.md) — Triangular floor-to-ceiling columns
| Cabinet | Internal Dimensions | Drivers | Notes |
|---------|-------------------|---------|-------|
| Bottom (front corners) | 24" × 24" × 48" | 2× UMII18-22 | Drivers at 11" and 32" AFF |
| Top (front corners) | 24" × 24" × 48" | None — volume only | — |
| Bottom (rear corners) | 24" × 24" × 48" | 1× UMII18-22 at top | Penetrates 24" platform |
| Top (rear corners) | 24" × 24" × 48" | 1× UMII18-22 at bottom | — |
| Combined per corner | 96" total height | 2× drivers | ~10.25 cu ft/driver, Fc ~30Hz, Qtc ~0.72 |

### Garage_Conversion_Option1.md Option D — Stacked rectangular (v3.4+) — ACTIVE
| Position | Cabinet Dimensions (as stated) | Drivers | Notes |
|----------|-------------------------------|---------|-------|
| All 4 corners | **~20"W × 20"D × 72"H** sealed | 2× UMII18-22 stacked | ~8.5 cu ft/driver, 8Ω series |

### CLAUDE.md Option D section — CONFLICT
| Source | Cabinet Dimensions |
|--------|--------------------|
| CLAUDE.md (ACTIVE section) | **24"×24"×72"** |
| Garage_Conversion_Option1.md (Option D sub table) | **~20"W × 20"D × 72"H** |

**CONFLICT: 20" vs 24" cross-section.** Both documents describe the same Option D design. CLAUDE.md says 24"×24"×72"; Garage_Conversion_Option1.md says ~20"W×20"D×72"H. Height consistent at 72" (6 ft). Cross-section is unresolved — needs authoritative source.

---

## 5. Amplifier Specs per Channel

### Speaker Amplification — Option D (Garage_Conversion_Option1.md)

| Amp | Channels | Power | Load | Notes |
|-----|---------|-------|------|-------|
| ATI AT525NC (5ch NCore) | L, C, R, FWL, FWR | ~300W/ch @ 6Ω (LCR); 200W @ 8Ω (FW) | 6Ω / 8Ω | Already owned |
| Denon AVR-X6800H internal (11ch) | SL, SR, SBL, SBR, TFL, TFR, TRL, TRR (8 of 11) | 140W × 11 rated @ 8Ω (2ch driven); ~100-140W all-ch | 8Ω | |

**Note:** 05_Speaker_System.md (Rev 7.0) describes AVR-A1H (150W×15 internal, all 13 channels). This is the POR Rev 7.0 reference config, not Option D. Option D uses X6800H + ATI AT525NC.

### Subwoofer Amplification — Option D

| Unit | Assignment | Load | Power/Ch |
|------|-----------|------|----------|
| ICEpower 1200AS2 #1 | Corner subs FL + FR | 8Ω | ~620W |
| ICEpower 1200AS2 #2 | Corner subs RL + RR | 8Ω | ~620W |
| ICEpower 1200AS2 #3 | Tactile bass shakers | varies | ~620W |
| ICEpower 1200AS2 #4 | Spare (nearfield if added) | — | — |
| ICEpower 1200AS2 #5 | Spare | — | — |

**ICEpower 1200AS2:** 240V native, fanless, no infrasonic derating (unlike NX6000D which derated to ~600W @ 15Hz).

### POR Rev 5.9 Amplification — SUPERSEDED
6× Behringer NX6000D @ ~850W/ch @ 8Ω stereo. Replaced by ICEpower platform in Rev 6.0 / Option D.

---

## 6. SPL Targets

| Target | Value | Applies To |
|--------|-------|-----------|
| POR Rev 5.2 | THX Reference 115 dB at MLP | Original reference design |
| POR Rev 7.0 / Option D | **-10 dB Reference = 95 dB at MLP** | Active target |
| Sub array @ 20Hz @ MLP | ~113 dB | 8× corner drivers + room gain |
| Sub array @ 20Hz (POR Rev 5.9 reference) | ~113-115 dB | 16× drivers full config |
| Nearfield @ 15Hz @ 15" (deferred) | ~115+ dB | Add post-build if needed |
| LCR headroom vs 95 dB target (Option D) | +9 to +13 dB | ATI NCore into Titan-815LX |
| Surrounds/Atmos headroom vs 95 dB target | +13 to +15 dB | X6800H internal into Volt-10 |
| Corner loading gain | +11 dB boundary + ~+6 dB acoustic summing | 4-corner array |
