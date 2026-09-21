# PolSejAn

**PolSejAn** is a MATLAB App Designer application for time–frequency and polarimetric analysis of three-component seismic signals. It processes East–West (EW), North–South (NS), and vertical (VZ) components and visualizes their time-domain, frequency-domain, and time–frequency characteristics using Stokes parameters.

## Features

- Loading three seismic components from ASCII (`.asc`) files
- Configurable sampling rate, sensor response, and integer decimation factor
- Fourth-order Butterworth band-pass filtering
- Time-domain and frequency-domain visualization
- Horizontal-component transformation based on the back azimuth
- Rayleigh- and Love-wave analysis modes
- Gaussian-window short-time Fourier transform (STFT)
- Automatic window optimization using Rényi entropy
- Time–frequency Stokes parameter calculation: `S0`, `S1`, `S2`, and `S3`
- Configurable colormap, interpolation method, and saturation level
- Time–frequency region-of-interest selection
- CSV export of results and processing metadata
- Standalone deployment using MATLAB Compiler

## Signal model

The application accepts three signal components:

- `EW` — East–West horizontal component
- `NS` — North–South horizontal component
- `VZ` — vertical component

The horizontal components are transformed according to the selected wave type and back azimuth. The resulting radial or transverse component is analyzed jointly with the vertical component.

For the selected Gaussian-window STFTs, the application calculates:

~~~text
S0 = |S_VZ|² + |S_rad|²
S1 = |S_VZ|² - |S_rad|²
S2 = 2 Re{S_VZ conj(S_rad)}
S3 = 2 Im{S_VZ conj(S_rad)}
~~~

The displayed `S1`, `S2`, and `S3` parameters are normalized by `S0`.

## Requirements

- MATLAB with App Designer support
- Signal Processing Toolbox
- MATLAB Compiler, only for building a standalone application

The application directly uses the following Signal Processing Toolbox functions:

~~~text
butter
db
decimate
filtfilt
mag2db
zp2sos
~~~

## Repository structure

~~~text
PolSejAn/
├── main.mlapp
├── colormap_MM.mat
├── GAB/
│   └── Gab_STFT.m
└── UTILS/
    ├── Init_Env.m
    └── Renyi_Entropy.m
~~~

The `GAB` and `UTILS` directories may contain additional dependencies required by these functions.

## Running the application in MATLAB

1. Clone or download the repository.
2. Open MATLAB and set the repository directory as the current folder.
3. Add the project directories to the MATLAB path:

   ~~~matlab
   addpath(genpath(pwd));
   ~~~

4. Open `main.mlapp` in App Designer and click **Run**, or start it from the command window:

   ~~~matlab
   app = main;
   ~~~

## Input data

The application loads three separate `.asc` files in the following order:

1. EW component
2. NS component
3. VZ component

The files must:

- contain numeric samples readable by MATLAB's `readtable` function;
- contain signals of equal length;
- represent components recorded using the same sampling rate and time interval.

The sampling rate, decimation factor, sensor response, filter band, back azimuth, wave type, and STFT window parameters can be configured in the graphical interface.

## Typical workflow

1. Set the original sampling rate and sensor-response coefficient.
2. Click **Load signals** and select the EW, NS, and VZ files.
3. Select the decimation factor and band-pass filter limits.
4. Enter the back azimuth and select the Rayleigh or Love wave mode.
5. Set the Gaussian-window time spread or enable automatic optimization.
6. Click **Run analysis**.
7. Adjust the visualization and region-of-interest settings.
8. Export the Stokes parameter maps and metadata to CSV files.

## Automatic window optimization

When **Optimize window** is enabled, the application selects the Gaussian-window time spread by minimizing the Rényi entropy of the `S0` time–frequency distribution. The window is recalculated when relevant processing parameters change, including the sampling rate, decimation factor, filter band, back azimuth, or wave type.

## Building a standalone application

Use MATLAB Application Compiler to package `main.mlapp`. Include the following resources under **Files required for your application to run**:

~~~text
colormap_MM.mat
GAB/
UTILS/
~~~

The generated application requires the MATLAB Runtime corresponding to the MATLAB release used for compilation. Input `.asc` files are selected at runtime and should not be included in the installer.

## Output

The application exports the selected time–frequency region of each Stokes parameter to a separate CSV file. Exported files include processing metadata such as:

- sampling rate;
- decimation factor;
- back azimuth;
- selected wave mode;
- window time spread;
- lower and upper filter frequencies.

## Main external functions

- `Gab_STFT.m` — Gaussian-window STFT calculation
- `Renyi_Entropy.m` — Rényi entropy calculation used for window optimization
- `Init_Env.m` — graphical environment initialization

## Author

Karol Abratkiewicz  
Warsaw University of Technology  
Institute of Electronic Systems, Radar Research Group

## License

No license has been specified yet. Add an appropriate `LICENSE` file before distributing the software or accepting external contributions.
