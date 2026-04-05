# V3 Nearfield Scripts

Python scripts for calculations and diagram generation.

## Requirements

```bash
pip install numpy matplotlib
```

## Scripts

| Script | Purpose | Output |
|--------|---------|--------|
| `config.py` | Shared configuration values | (imported by others) |
| `biquad_calculator.py` | Generate miniDSP coefficients | Console output |
| `generate_frequency_response.py` | DSP/acoustic response curves | `diagrams/frequency_response.png` |
| `generate_spl_power.py` | SPL vs power analysis | `diagrams/spl_power_analysis.png` |
| `generate_all.py` | Run all diagram generators | All PNGs |

## Usage

```bash
# From NearFieldV3 directory:
cd scripts

# Generate biquad coefficients
python biquad_calculator.py

# Generate all diagrams
python generate_all.py

# Or individually:
python generate_frequency_response.py
python generate_spl_power.py
```

## Configuration

Edit `config.py` to change cabinet parameters. Key values:

| Parameter | Value | Description |
|-----------|-------|-------------|
| `FC` | 38 Hz | Cabinet resonant frequency |
| `QTC` | 0.88 | Cabinet Q |
| `FP` | 10 Hz | Target extension frequency |
| `BOOST_10HZ` | 19.5 dB | Required DSP boost |

## Output

Diagrams are saved to `../diagrams/` folder.
