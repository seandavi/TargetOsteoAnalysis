# TargetOsteoAnalysis

This package contains functionality to access the open, public
genomics and clinical data from the [TARGET Osteosarcoma] project.

[TARGET Osteosarcoma]: https://ocg.cancer.gov/programs/target/projects/osteosarcoma

## Installation

Installation from github:

```{r}
install.packages('BiocManager')
BiocManager::install("seandavi/TargetOsteoAnalysis")
```

# TARGET Osteosarcoma

The TARGET Osteosarcoma project elucidates comprehensive molecular
characterization to determine the genetic changes that drive the
initiation and progression of high-risk or hard-to-treat childhood
cancers. Osteosarcoma (OS) is the most common type of bone cancer in children
and adolescents. It is most frequently diagnosed in adolescent
patients experiencing periods of rapid growth. As with other childhood
cancers being studied by TARGET, improvements in survival outcomes for
OS have plateaued despite attempts in refining the standard treatment
protocol. Additionally, patients endure rigorous therapy regimens
regardless of whether the disease is localized or metastatic. Thus,
targeted therapies have the potential to enhance the survival and
quality-of-life of patients with this disease. To learn more about
Osteosarcoma and current treatment strategies, visit the NCI
osteosarcoma website.

# Datasets included

- Clinical
- Methylation (450k Illumina Arrays)
- Gene Expression (Affymetrix HuEx arrays)
- miRNA Expression (TaqMan multiplex assay)
- Purity and ploidy estimates from HTS data
- Copy Number 
  - Affymetrix SNP6 arrays
  - GISTIC summary
  - Purity-corrected copy number
- DNA quality control metrics

Extra data included include:

- Sleeping beauty osteosarcoma screening data
- COSMIC consensus gene list
