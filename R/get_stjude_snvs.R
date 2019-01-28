#' get St. Jude SNVs
#'
#' This function downloads and reads in the "validated SNVs" from the paper "Recurrent Somatic Structural Variations Contribute to Tumorigenesis in Pediatric Osteosarcoma." Cell Reports, April 10, 2014.
#' The paper describes 20 WGS samples and 14 validation osteosarcoma samples analyzed at St Jude.
#'
#' @importFrom readxl read_excel
#'
#' @references
#' Chen, Xiang, Armita Bahrami, Alberto Pappo, John Easton, James Dalton, Erin Hedlund, David Ellison, et al. 2014. “Recurrent Somatic Structural Variations Contribute to Tumorigenesis in Pediatric Osteosarcoma.” Cell Reports, April 10, 2014. https://doi.org/10.1016/j.celrep.2014.03.003.
#'
#' @return a tibble of results
#'
#' @examples
#' snvs = get_stjude_snvs()
#' head(snvs)
#' colnames(snvs)
#' head(sort(table(snvs$gene), decreasing=TRUE),20)
#'
#' @export
get_stjude_snvs = function() {
  xlsfile = file.path(tempdir(), 'mmc4.xlsx')
  download.file('https://www.cell.com/cms/10.1016/j.celrep.2014.03.003/attachment/281e4b0f-814f-45a0-ae9c-c6fdb812cb8b/mmc4.xlsx',
                destfile = xlsfile)
  readxl::read_excel(xlsfile, skip=2, sheet=3) #validated snvs sheet
}
