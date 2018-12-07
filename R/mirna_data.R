
#' Load TARGET miRNA data as SummarizedExperiment
#'
#' @import SummarizedExperiment
#' @importFrom S4Vectors DataFrame
#' @importFrom S4Vectors SimpleList
#' @importFrom readr read_tsv
#'
#' @export
target_mirna_se = function() {
  genedat = "ftp://caftpd.nci.nih.gov/pub/OCG-DCC/TARGET/OS/miRNA_pcr/L2/TARGET_OS_miRNA_level2_dCt.txt"

  dat = readr::read_tsv(genedat)

  # Make the assay matrix
  assay_mat = as.matrix(dat[,-1])
  colnames(assay_mat) = target_usi_to_samplename(colnames(assay_mat))
  rownames(assay_mat) = make.unique(dat[[1]])

  # clinical/coldata
  cdata = target_load_clinical()
  cdata = as.data.frame(cdata)
  cdata[[1]] = target_usi_to_samplename(cdata[[1]])
  rownames(cdata) = make.unique(cdata[[1]])
  cdata = cdata[colnames(assay_mat),]

  # construct rowdata
  rowdata = DataFrame(mirna = rownames(assay_mat), row.names = rownames(assay_mat))

  return(SummarizedExperiment(assays = list(exprs = assay_mat), rowData = rowdata, colData = cdata))
}
