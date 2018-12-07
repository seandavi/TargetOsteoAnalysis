#' load COSMIC gene census
#'
#' The COSMIC gene census list is just the genes
#' that the COSMIC project has curated. These are
#' all bona fide cancer genes. The csv file was
#' downloaded offline, since signin is required.
#'
#' @importFrom readr read_csv
#'
#' @references
#' See \url{https://cancer.sanger.ac.uk/census}
#'
#' @examples
#' cosmic_census()
#'
#' @export
cosmic_census <- function() {
  d_fname = file.path(system.file('extdata', package='TargetOsteoAnalysis'), "CosmicCensus.csv.gz")
  read_csv(d_fname)
}
