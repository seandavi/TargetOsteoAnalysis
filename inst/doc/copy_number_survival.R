## ----results='hide', echo=FALSE------------------------------------------
library(knitr)
opts_chunk$set(cache=TRUE, message=FALSE, warning=FALSE)

## ----eval=FALSE----------------------------------------------------------
#  source("https://bioconductor.org/biocLite.R")
#  biocLite('seandavi/TargetOsteoAnalysis')

## ------------------------------------------------------------------------
library(TargetOsteoAnalysis)

## ------------------------------------------------------------------------
cn_se = target_gistic_se()
cn_se

## ------------------------------------------------------------------------
library(survival)
library(SummarizedExperiment)
os_obj = Surv(time = colData(cn_se)$`Time to First Event in Days`, 
              event = colData(cn_se)$`Vital Status`=='Dead')
rfs_obj = Surv(time = colData(cn_se)$`Time to First Event in Days`, 
               event = !is.na(colData(cn_se)$`Time to first relapse in days`))

## ------------------------------------------------------------------------
library(survival)
metastatic = !is.na(colData(cn_se)$`Metastasis site`)
cn = assay(cn_se, 'cn')[rowData(cn_se)$`Gene Symbol`=='MYC',]
res = coxph(os_obj ~ cn*metastatic)
res

