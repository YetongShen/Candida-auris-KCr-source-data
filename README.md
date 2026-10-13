# Source data for lysine crotonylation and antifungal responses in Candida auris

This repository contains source data, processed analysis tables, and available
analysis and plotting scripts supporting Figures 1 and 2 of the manuscript.

## Repository contents

- `Fig 1/`: PTM occurrence analysis, PTM fluctuation and transition data,
  sodium crotonate susceptibility data, and larval fungal-burden data.
- `Fig 2/`: crotonylation-associated protein and site lists, enrichment
  analysis, metabolic-pathway data, mitochondrial images, flow-cytometry
  files, and antifungal susceptibility data.
- `PROCESSING.md`: panel-specific data sources and processing descriptions.

## File formats

- `.csv`, `.tsv`, and `.txt`: analysis inputs, annotations, and processed tables.
- `.xlsx`: quantitative source-data tables and proteomics reports.
- `.R` and `.Rmd`: available R analysis and reporting scripts.
- `.prism` and `.pzfx`: native GraphPad Prism data and analysis projects.
- `.fcs`: flow-cytometry acquisition files.
- `.tif`: microscopy images or figure outputs, as identified by their location.
- `.pdf`, `.jpg`, and `.ai`: graphical outputs and figure-editing files.

## Sample identifiers

Some historical filenames and scripts retain earlier strain identifiers:

| Historical identifier | Manuscript identifier |
|---|---|
| 1176 / F1176 / CZ1176 | SCZA9005 |
| 2852 / F2852 / CZ2852 | SCZA9007 |
| 1175 / CZ1175 | SCZA9004 |
| 1195 / CZ1195 | SCZA9006 |
| 2853 / CZ2853 | SCZA9008 |
| 2854 / CZ2854 | SCZA9009 |

In historical sample labels, the terminal `C` denotes the untreated condition
and the terminal `F` denotes fluconazole treatment. The leading `F` in labels
such as `F1176C` is part of the historical identifier.

Comparison labels and transition directions should be interpreted using the
corresponding script. Renaming a strain does not change the comparison
direction.

## PTM abbreviations

Ac: lysine acetylation; Cr: lysine crotonylation;
Ma: lysine malonylation; Sc: lysine succinylation;
Ub: lysine ubiquitylation.

## Related resources

Raw mass-spectrometry data:
https://www.ebi.ac.uk/pride/archive/projects/PXD050641

PTMDynamicAnalysis:
https://github.com/ShabbyAllan/PTMDynamicAnalysis

Large files are distributed through the Releases section of this repository.


## Reuse and reproduction

The deposited scripts document the available analyses. Historical absolute
paths must be adapted before execution. Numerical suffixes such as `_1`,
`_2`, and `_3` identify source-data entries; their experimental meaning must
be established from the sample metadata rather than inferred from filenames.

The repository does not yet provide a verified, fully automated workflow
for reproducing every manuscript panel. Software versions and analysis
settings should be recorded when the workflows are rerun.

## Download source data

Source data and analysis files for Figures 1 and 2 are available in [Release v1.0.0](https://github.com/YetongShen/Candida-auris-KCr-source-data/releases/tag/v1.0.0).

- **Fig.1.rar**: Source data and analysis files for Figure 1.
- **Fig.2.rar**: Source data and analysis files for Figure 2.

Download the archives from the **Assets** section and extract them before use.
