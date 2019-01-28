#' load Janeway alterations
#'
#' The data from Proceedings of the National Academy of Sciences Dec 2014, 111 (51) E5564-E5573 are available in
#' what looks to be a relatively complete table that includes SNVs, SNPs, as well as copy number variation.
#' This function just loads those data for convenience. It is likely that further filtering is going to be
#' required before use.
#'
#' @importFrom readxl read_excel
#'
#' @references
#'   Data from \url{https://www.pnas.org/highwire/filestream/618044/field_highwire_adjunct_files/7/pnas.1419260111.sd08.xlsx}.
#'   See Proceedings of the National Academy of Sciences Dec 2014, 111 (51) E5564-E5573; DOI: 10.1073/pnas.1419260111.
#'
#' @return a tibble
#'
#'
#' @examples
#' alts = get_janeway_alterations()
#' head(alts)
#' colnames(snps)
#'
#' @export
get_janeway_alterations = function() {
  xlsfile = file.path(tempdir(), 'janeway_snps.xlsx')
  download.file("https://www.pnas.org/highwire/filestream/618044/field_highwire_adjunct_files/7/pnas.1419260111.sd08.xlsx",
                destfile = xlsfile)
  ret = readxl::read_excel(xlsfile)
  unlink(xlsfile)
  return(ret)
}
