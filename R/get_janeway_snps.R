#' load Janeway PNAS SNVs
#'
#' @importFrom readxl read_excel
#'
#' @references
#'   Data from \url{https://www.pnas.org/highwire/filestream/618044/field_highwire_adjunct_files/8/pnas.1419260111.sd09.xls}.
#'   See Proceedings of the National Academy of Sciences Dec 2014, 111 (51) E5564-E5573; DOI: 10.1073/pnas.1419260111.
#'
#' @return a tibble with variants and oncotator results
#'
#'
#' @examples
#' snps = get_janeway_snps()
#' head(snps)
#' colnames(snps)
#' head(sort(table(snps$Hugo_Symbol), decreasing=TRUE)),25)
#'
#' @export
get_janeway_snps = function() {
  xlsfile = file.path(tempdir(), 'janeway_snps.xls')
  download.file("https://www.pnas.org/highwire/filestream/618044/field_highwire_adjunct_files/8/pnas.1419260111.sd09.xls",
                destfile = xlsfile)
  ret = readxl::read_excel(xlsfile)[-1,]
  unlink(xlsfile)
  return(ret)
}
