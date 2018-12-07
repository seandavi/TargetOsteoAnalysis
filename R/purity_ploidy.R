#' Load Purity and Ploidy estimates
#'
#' Results from PureCN run on discovery and
#' validation sets.
#'
#' @import dplyr
#' @import magrittr
#' @importFrom readr read_tsv
#'
#' @return A \code{data.frame} with columns Source,
#'     Purity, Ploidy, and dataset
#'
#' @examples
#' pure = target_purity()
#' head(pure)
#' library(magrittr)
#' library(dplyr)
#' pure %>%
#'   group_by(dataset) %>%
#'   summarise(medploidy = median(Ploidy, na.rm=TRUE),
#'             medpurity = median(Purity, na.rm=TRUE),
#'             lowpurity = quantile(Purity, 0.1, na.rm=TRUE))
#'
#' @export
target_purity <- function() {
  d_fname = file.path(system.file('extdata', package='TargetOsteoAnalysis'), "OS_dis_pureCN_all.txt.gz")
  dis = suppressMessages(read_tsv(d_fname, na = c('?'))) %>%
    select(Sampleid, Purity, Ploidy) %>%
    rename(Source = Sampleid) %>%
    mutate(Source = sub('_.*','', Source)) %>%
    mutate(dataset = "Discovery")
  v_fname = file.path(system.file('extdata', package='TargetOsteoAnalysis'), "OS_Val_Roche_Purecn.txt.gz")
  val = suppressMessages(read_tsv(v_fname, na = c('?'))) %>%
    select(Source, Purity, Ploidy) %>%
    mutate(dataset = "Validation")
  return(bind_rows(dis, val))
}
