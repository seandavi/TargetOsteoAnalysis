
#' Load TARGET huex data as SummarizedExperiment
#'
#' @import SummarizedExperiment
#' @importFrom S4Vectors DataFrame
#' @importFrom S4Vectors SimpleList
#' @importFrom stringr str_split
#' @importFrom readr read_tsv
#'
#' @examples
#'
#' res = target_huex_se()
#'
#' res
#'
#' head(colData(res))
#' assay(res,'exprs')[1:5,1:5]
#' head(rowData(res))
#'
#' @export
target_huex_se = function() {
  genedat = "ftp://caftpd.nci.nih.gov/pub/OCG-DCC/TARGET/OS/gene_expression_array/L3/gene_core_rma_summary_annot.txt"
  sdrf    = "ftp://caftpd.nci.nih.gov/pub/OCG-DCC/TARGET/OS/gene_expression_array/METADATA/TARGET_OS_GeneExpressionArray_20160812.sdrf.txt"

  dat = readr::read_tsv(genedat)
  dat2 = suppressWarnings(readr::read_tsv(sdrf))
  sample_map = as.vector(target_usi_to_samplename(dat2[[1]]))
  names(sample_map) = dat2$`Array Data File`

  # Make the assay matrix
  assay_mat = as.matrix(dat[,-c(1:2)])
  rownames(assay_mat) = dat[[1]]
  colnames(assay_mat) = unname(sample_map[match(colnames(assay_mat),names(sample_map))])


  # split transcripts, symbols, and pick most common symbol
  genes = str_split(dat[[2]],' // ')
  tx_list = lapply(genes,function(g) {
    if(length(g)<2) return(NA)
    return(g[seq(1,length(g),2)])
  })
  symbol_list = lapply(genes,function(g) {
    if(length(g)<2) return(NA)
    return(unique(g[seq(2,length(g),2)]))
  })
  symbol = unlist(lapply(genes,function(g) {
    if(length(g)<2) return(NA)
    tb = sort(table(g[seq(2,length(g),2)]),decreasing = TRUE)
    return(unlist(names(tb)[1]))
  }))

  # clinical/coldata
  cdata = target_load_clinical()
  cdata = as.data.frame(cdata)
  cdata[[1]] = target_usi_to_samplename(cdata[[1]])
  rownames(cdata) = make.unique(cdata[[1]])
  cdata = cdata[colnames(assay_mat),]

  # construct rowdata
  rowdata = DataFrame(symbol = symbol, tx_list = SimpleList(tx_list),
                      symbol_list = SimpleList(symbol_list),
                      row.names = dat[[1]])

  return(SummarizedExperiment(assays = list(exprs = assay_mat), rowData = rowdata, colData = cdata))
}
