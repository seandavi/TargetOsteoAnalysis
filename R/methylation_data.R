
#' Load TARGET methylation data as SummarizedExperiment
#'
#' @import SummarizedExperiment
#' @importFrom S4Vectors DataFrame
#' @importFrom S4Vectors SimpleList
#' @importFrom readr read_tsv
#' @import BiocFileCache
#'
#' @export
target_methylation_se = function() {
  url = "ftp://caftpd.nci.nih.gov/pub/OCG-DCC/TARGET/OS/methylation_array/L2/TARGET_OS_meth_level2.txt"

  bfc = BiocFileCache()
  q = bfcquery(bfc, "ftp://caftpd.nci.nih.gov/pub/OCG-DCC/TARGET/OS/methylation_array/L2/TARGET_OS_meth_level2.txt")
  if(nrow(q)!=1) {
    rid = bfcadd(bfc,"TARGET_OS_meth_level2.txt",
                 "ftp://caftpd.nci.nih.gov/pub/OCG-DCC/TARGET/OS/methylation_array/L2/TARGET_OS_meth_level2.txt")
  } else {
    rid = q$rid[1]
  }
  genedat = bfcpath(bfc,rid)[1]

  message("Dataset is large. This process to take a few minutes.")

  dat = readr::read_tsv(genedat)

  # Make the assay matrix
  assay_mat = as.matrix(dat[,-1])
  colnames(assay_mat) = target_usi_to_samplename(colnames(assay_mat), long=TRUE)
  rownames(assay_mat) = make.unique(dat[[1]])

  # clinical/coldata
  cdata = target_load_clinical()
  cdata = as.data.frame(cdata)
  cdata[[1]] = target_usi_to_samplename(cdata[[1]])
  rownames(cdata) = make.unique(cdata[[1]])
  cdata = cdata[colnames(assay_mat),]

  # construct rowdata
  rowdata = DataFrame(reporter_id = rownames(assay_mat), row.names = rownames(assay_mat))

  return(SummarizedExperiment(assays = list(exprs = assay_mat), rowData = rowdata, colData = cdata))
}
