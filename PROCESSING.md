# Data sources and processing descriptions

This document describes the source files and processing steps represented
in the deposited Figure 1 and Figure 2 directories. It documents the
available files and scripts; it is not a record of a newly executed analysis.

## Figure 1A: PTM occurrence across functional categories

Source directory: `Fig 1/Fig_1a/`.

1. The site-selection script reads the quantitative PTM tables and extracts
   protein accessions, lysine positions, and sample-specific measurements.
2. Sites without quantitative measurements in all three source columns of
   a condition are excluded for that condition.
3. Condition-specific and PTM-specific protein/site lists are exported to
   `Single_sites/`.
4. `Fig_1a.Rmd` obtains distinct protein accessions from these lists and maps
   them to KEGG annotations using `KOannotation.tsv` and `KEGG_level.csv`.
5. Category frequencies are normalized using the category counts in the
   reference annotation table and plotted by PTM and condition.

The current implementation counts annotation records after mapping.
Protein-to-pathway mappings may be multiple. The counting unit should be
checked against the manuscript definition of PTM occurrence frequency
before the analysis is described as a fraction of unique proteins.

## Figure 1B: PTMDynamicAnalysis workflow

This panel is a schematic of the PTM-transition analysis rather than an
independent experimental dataset.

The workflow matches lysine sites between compared conditions, represents
their detected PTM states, and infers directional changes. Input and output
scores summarize these changes. The fluctuation coefficient is defined as
the sum of input scores divided by the sum of output scores in the specified
comparison direction.

These are inferred changes between detected PTM states, not direct
measurements of chemical conversion at individual molecules.

## Figure 1C: Site-level PTM fluctuation data

Source file: `Fig 1/Fig 1C.xlsx`.

The workbook contains input and output tables for Ac, Cr, Ma, Sc, and Ub.
The site identifier, score, and comparison label are retained in the
corresponding worksheets.

Input and output datasets should be interpreted separately. These
site-level tables differ from the aggregate summary tables used for
Figure 1D.

## Figure 1D: Aggregate PTM fluctuation coefficients

Source file: `Fig 1/Fig 1D.xlsx`.
Related directory: `Fig 1/Fig_1d/`.

1. The deposited script combines the input and output summary files from
   directories `1`, `2`, and `3`.
2. Values are arranged by PTM, comparison, and source-data entry.
3. Summary proportions are multiplied by 100 when exported.
4. Fluctuation coefficients are obtained from the corresponding input and
   output values in the same comparison direction.

The folders numbered `1`, `2`, and `3` retain the source labels. Their
biological or technical replicate status must be documented separately.

## Figure 1E: KCr input and output routes

Source directory: `Fig 1/Fig_1e/`.

1. Detailed transition tables are read for each comparison and source entry.
2. Input routes ending in `TOCr` and output routes starting with `CrTO`
   are extracted separately.
3. The deposited proportions are multiplied by 100 to obtain percentages.
4. The results are saved as `inputRates.csv` and `outputRates.csv`.
5. The current workflow contains a manual step that adds average labels,
   producing `inputRates_Avg.csv` and `outputRates_Avg.csv`.
6. The plotting code displays mean percentages with standard-error bars
   across the supplied entries.

The average-label calculation should be documented or incorporated into
the script before the workflow is described as fully automated.

## Figure 1F: Sodium crotonate and fluconazole susceptibility

Source directory: `Fig 1/Fig_1f/`.

The Excel and Prism files contain the susceptibility source data and native
plotting project. MIC-related results should be traced to the growth curves
and the fitted model in the Prism project.

The final documentation should specify the growth-data normalization,
Gompertz model settings, and the interpretation of individual data points.

## Figure 1G: Larval fungal burden

Source file: `Fig 1/Fig 1G.prism`.

The native Prism project contains the source values used for the larval
fungal-burden panel. Each plotted value should be linked to its experimental
unit and treatment group.

Any dilution correction, CFU calculation, or transformation preceding the
Prism table should be documented from the experimental record.

## Figure 2A: Protein and site overlap

Source directory: `Fig 2/Fig_2a/`.

1. Condition-specific PTM states are matched using protein accession and
   lysine position.
2. The transition tables record inferred changes between the compared
   conditions, including transitions involving the `NA` state.
3. `Fig_2a.Rmd` selects entries with `ID == "NATOCr"` from the untreated
   and fluconazole-treated between-strain comparisons.
4. Unique site identifiers are exported to `F2C_sites.csv` and
   `F2F_sites.csv`.
5. Protein identifiers are extracted from the site identifiers and
   deduplicated, producing `F2C_proteins.csv` and `F2F_proteins.csv`.
6. Set intersections and differences provide the Venn-diagram counts.

The deposited lists give:

| Level | Untreated-only | Shared | Treated-only |
|---|---:|---:|---:|
| Protein | 175 | 873 | 508 |
| Site | 633 | 1074 | 1502 |

In these transition tables, `NA` represents the absence of a detected PTM
state in the input dataset. It should not be interpreted as direct proof
that the lysine residue was chemically unmodified.

The plotted sets are generated by the specified `NATOCr` selection, rather
than by an unrestricted list of all crotonylated proteins.

## Figure 2B: Functional enrichment

Source directory: `Fig 2/Fig_2b/`.

1. The untreated-only and treated-only protein lists contain 175 and
   508 unique protein identifiers, respectively.
2. GO and KEGG annotation tables are supplied with the analysis.
3. `Fig2b.Rmd` performs enrichment using `clusterProfiler::enricher`.
4. GO analysis explicitly uses Benjamini–Hochberg adjustment.
5. The script sets the p-value and q-value cutoffs to 1 and exports the
   resulting enrichment tables.
6. The available plotting code uses raw p-values for plot colouring.

Any significance threshold or selection of pathways for the final
manuscript panel should be stated separately. A cutoff of 1 in this script
does not itself define statistically significant enrichment.

## Figure 2C: Glycolysis and TCA pathway integration

Source directory: `Fig 2/Fig_2c/`.

`Glucose.xlsx` and `TCA.xlsx` provide the deposited pathway tables.
The `.ai` and `.pdf` files provide the editable diagram and graphical output.

This panel combines quantitative tables with a manually assembled pathway
diagram. The final documentation should identify the normalization and
colour mapping used to transfer table values into the diagram.

## Figure 2D: Metabolic-protein KCr heatmap

Source directory: `Fig 2/Fig_2d/`.

1. `Fig2d.Rmd` reads the quantitative PTM and protein workbooks.
2. Proteins are selected and ordered using `G+TCA.xlsx`.
3. Entries without quantitative values across the selected sample columns
   are removed.
4. For each site and condition, the mean is calculated from the available
   values in the three source columns.
5. Site-level means are combined by protein. In the current implementation,
   remaining missing site means are replaced by zero at this aggregation
   step.
6. Protein-level values are reordered and displayed using `pheatmap`
   with row scaling.
7. Both clustered and unclustered heatmap outputs are generated.

The current code averages over the retained site rows. It does not contain
a denominator representing all potentially modifiable lysine residues.
This difference from the current manuscript caption must be resolved.

## Figure 2E: Mitochondrial morphology

Source directory: `Fig 2/Fig_2e/`.

The TIFF files provide the deposited microscopy images for the four strain
and treatment groups. `Fig 2E.pzfx` provides the native quantitative project.

Mitochondrial individuals and networks were quantified using the Mitochondrial Network Analysis (MiNA) toolset. Statistical analysis was performed using ordinary one-way ANOVA followed by Tukey’s multiple-comparisons test.

## Figure 2F: Mitochondrial ROS

Source directory: `Fig 2/Fig_2f/`.

The FCS files provide flow-cytometry acquisition data, and the Prism project
provides the quantitative plotting file.

Reanalysis requires the fluorescence channel, gating strategy, excluded
events, reported fluorescence statistic, and any normalization to be
documented.

## Figures 2G and 2H: NAC treatment and mitochondrial ROS

Source files:
- `Fig 2/Fig 2g/`: flow-cytometry acquisition files.
- `Fig 2/Fig 2H.prism`: quantitative plotting project.

The FCS files support the fluorescence-distribution panel, while the Prism
project contains the quantitative values used for the corresponding
summary panel.

Control samples, gating, fluorescence statistics, and dose labels should
be documented consistently.

## Figures 2I and 2J: Sodium crotonate and mitochondrial ROS

Source files:
- `Fig 2/Fig 2I/`: flow-cytometry acquisition files.
- `Fig 2/Fig 2J.prism`: quantitative plotting project.

The acquisition files and quantitative project support the corresponding
distribution and summary panels. Historical filenames containing `NACR`
refer to the sodium-crotonate experiment in this directory.

## Figure 2K: NAC and fluconazole susceptibility

Source directory: `Fig 2/Fig_2k/`.

The spreadsheets contain the deposited growth measurements, including
time-specific tables. Prism files contain the native analysis and plotting
projects.

The processing record should specify how baseline and endpoint readings
were used, how growth was normalized, and how MIC values were obtained from
the fitted growth curves.

## Figure 2L: Susceptibility across pathogenic fungi

Source file: `Fig 2/Fig 2L.prism`.

The native Prism project contains the quantitative data used for comparisons
across the tested fungal strains.

The final documentation should state the treatment concentrations,
measurement units, normalization, replicate structure, and statistical
comparisons.

## Reproduction status

The deposited scripts retain historical absolute paths and some fixed-length
sample-name parsing. These must be updated consistently with the deposited
filenames before execution.

The analyses have not been rerun as part of preparing this description.
Software versions, complete sample metadata, manual processing steps, and
panel-specific analysis settings remain necessary for a verified
reproduction workflow.
