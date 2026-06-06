# Lab II: Instrumentation and Imaging

This repository contains cleaned coursework from an undergraduate Bio and Brain Engineering laboratory course block. It is organized as a readable lab portfolio rather than a production software package.

The work covers biomedical instrumentation, analog circuits, data acquisition, LabVIEW, biomedical imaging, optical microscopy, nanoparticle characterization, fluorescence/Raman sensing, and microfluidic analysis. Public files keep useful code, small non-sensitive measurements, selected result figures, and a README summary for every week. Submitted reports, personal waveform outputs, raw media, copied course materials, and oversized files are intentionally excluded.

Each week uses the same public-facing convention:

- `README.md` explains the lab focus, included artifacts, excluded artifacts, and rerun notes.
- `code/` is included only when reusable scripts, LabVIEW files, or notebooks are safe to publish.
- `data/` is included only for small non-sensitive measurement files.
- `results/` is included only for non-identifying figures, tables, or screenshots.
- `report/` is intentionally not published because original reports can contain names, student IDs, partner information, private measurements, and copied course text.

## Repository Structure

| Folder | Contents |
| --- | --- |
| `week-01-electrical-test-measurements/` | Oscilloscope, function-generator, power-supply, multimeter, triggering, and waveform-capture basics. Only a public-safe summary is included. |
| `week-02-operational-amplifier-circuits/` | CSV oscilloscope measurements and selected result figure for LM741 op-amp experiments, including amplifier, detector, adder/subtractor, and instrumentation-amplifier behavior. |
| `week-03-bioamplifier-filter-design/` | MATLAB calculations for active low-pass filter behavior and Bode-style analysis. |
| `week-04-daq-labview-programming/` | MATLAB RC/FIR design work, LabVIEW screenshots, and small `.lvm` exports from NI USB-6009 data-acquisition exercises. |
| `week-05-cardiovascular-monitoring/` | MATLAB FIR filter design and LabVIEW VI for PPG monitoring. Personal ECG/PPG waveform outputs are excluded. |
| `week-06-biomedical-imaging-acquisition/` | MATLAB CT projection/back-projection, MRI k-space filtering, multi-coil imaging, downsampling, and SENSE reconstruction results. |
| `week-07-optical-microscopy-holography/` | MATLAB off-axis holography reconstruction with sample data and intensity/phase/Fourier-domain figures. |
| `week-08-gold-nanoparticle-characterization/` | Small DLS, absorbance, and photothermal-effect measurement files for gold nanosphere/nanorod characterization. |
| `week-09-fluorescence-raman-sensing/` | MATLAB SERS and fluorescence analysis, baseline correction, Raman peak tracking, unknown-sample estimation, and result figures. |
| `week-10-microfluidic-particle-separation/` | Microfluidic particle-focusing and separation summary. Raw microscopy stacks and bundled ImageJ files are excluded. |

```text
bio-brain-engineering-lab-ii-instrumentation-imaging/
|-- README.md
|-- week-01-electrical-test-measurements/
|   `-- README.md
|-- week-02-operational-amplifier-circuits/
|   |-- data/
|   `-- results/
|-- week-03-bioamplifier-filter-design/
|   `-- code/
|       `-- low_pass_filter_bode_analysis.m
|-- week-04-daq-labview-programming/
|   |-- code/
|   |-- data/
|   `-- results/
|-- week-05-cardiovascular-monitoring/
|   |-- code/
|   `-- results/
|-- week-06-biomedical-imaging-acquisition/
|   |-- code/
|   `-- results/
|-- week-07-optical-microscopy-holography/
|   |-- code/
|   |-- data/
|   `-- results/
|-- week-08-gold-nanoparticle-characterization/
|   `-- data/
|-- week-09-fluorescence-raman-sensing/
|   |-- code/
|   |-- data/
|   `-- results/
`-- week-10-microfluidic-particle-separation/
    `-- README.md
```

## Topics Covered

- Electrical test equipment and waveform measurement
- Operational amplifier circuits and instrumentation-amplifier behavior
- Bio-amplifier filter design and transfer-function analysis
- Data acquisition with LabVIEW and NI USB-6009 exports
- ECG/PPG monitoring concepts and digital FIR filter design
- CT projection/back-projection and MRI k-space analysis
- SENSE reconstruction for accelerated multi-coil MRI
- Off-axis holography and Fourier-domain optical reconstruction
- Gold nanoparticle absorbance, DLS, and photothermal characterization
- Fluorescence and Raman spectroscopy analysis
- Microfluidic particle focusing and separation concepts

## Included Artifacts

- MATLAB scripts for filter design, DAQ analysis, imaging reconstruction, holography, Raman analysis, and fluorescence comparison
- A LabVIEW VI for PPG monitoring where it is useful as an assignment artifact
- Small `.csv`, `.txt`, `.lvm`, `.xlsx`, and `.mat` measurement files that do not expose personal information
- Selected result figures showing circuit, DAQ, filter, imaging, holography, fluorescence, and spectroscopy outputs
- README summaries for weeks where the original files should not be public

## Privacy and Course-Policy Notes

This public version intentionally excludes submitted reports, names, student IDs, partner identifiers, personal ECG/PPG waveform outputs, raw circuit-photo dumps, raw microscopy stacks, course handouts/manuals, lecture or experiment videos, bundled applications, and large duplicated archives.

Some scripts may refer to local course datasets or hardware-specific acquisition files that are not included here. Those files are omitted because they are private, oversized, or not clearly redistributable.

## Tools and Languages Used

- MATLAB
- LabVIEW
- NI USB-6009 data-acquisition workflow
- Oscilloscope and circuit measurement exports
- Spreadsheet-style measurement analysis
- Image processing and Fourier-domain reconstruction workflows

## What I Practiced

- Building and measuring analog biomedical instrumentation circuits
- Exporting and analyzing data-acquisition waveforms
- Designing digital filters for physiological monitoring tasks
- Implementing CT/MRI reconstruction concepts in MATLAB
- Reconstructing off-axis holography intensity and phase images
- Comparing nanoparticle and spectroscopy measurements from lab data
- Cleaning coursework artifacts into a public-safe technical portfolio

## Limitations

- This is a cleaned coursework archive, not a hardware-control or imaging software package.
- Personal waveform outputs, submitted reports, raw media, and course-provided materials are not included.
- Some MATLAB scripts may need local datasets or course files that are intentionally omitted.
- Result figures are included only when they are non-identifying and useful for browsing the work.

## Repository Status

This repository is prepared for public GitHub presentation as undergraduate lab coursework. The goal is to make the work easy to browse while keeping the original assignments recognizable and publication-safe.
