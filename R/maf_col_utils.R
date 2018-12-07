#' Split a polyphen column into text and number
#'
#' This takes a column that has entries like
#' "Probably damaging(0.999)" and returns a data
#' frame with two columns containing the text
#' description and the number.
#'
#' @importFrom stringr str_match
#' @importFrom tibble as_tibble
#'
#' @examples
#' testing = c("probably_damaging(0.999)")
#' extract_polyphen(testing)
#'
#' @export
extract_polyphen <- function(pphen) {
  tmp = str_match(pphen, "(.*)\\((.*)\\)")
  tmp = as_tibble(tmp[,2:3])
  colnames(tmp) = c('polyphen_prediction', 'polyphen_value')
  tmp
}

#' Split a SIFT column into text and number
#'
#' This takes a column that has entries like
#' "deleterious(0.03)" and returns a data
#' frame with two columns containing the text
#' description and the number.
#'
#' @importFrom stringr str_match
#' @importFrom tibble as_tibble
#'
#' @examples
#' testing = c("deleterious(0.03)")
#' extract_sift(testing)
#'
#' @export
extract_sift <- function(sift) {
  tmp = str_match(sift, "(.*)\\((.*)\\)")
  tmp = as_tibble(tmp[,2:3])
  colnames(tmp) = c('sift_prediction', 'sift_value')
  tmp
}
