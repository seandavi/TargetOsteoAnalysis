% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_stjude_snvs.R
\name{get_stjude_snvs}
\alias{get_stjude_snvs}
\title{get St. Jude SNVs}
\usage{
get_stjude_snvs()
}
\value{
a tibble of results
}
\description{
This function downloads and reads in the "validated SNVs" from the paper "Recurrent Somatic Structural Variations Contribute to Tumorigenesis in Pediatric Osteosarcoma." Cell Reports, April 10, 2014.
The paper describes 20 WGS samples and 14 validation osteosarcoma samples analyzed at St Jude.
}
\examples{
snvs = get_stjude_snvs()
head(snvs)
colnames(snvs)
head(sort(table(snvs$gene), decreasing=TRUE),20)

}
\references{
Chen, Xiang, Armita Bahrami, Alberto Pappo, John Easton, James Dalton, Erin Hedlund, David Ellison, et al. 2014. “Recurrent Somatic Structural Variations Contribute to Tumorigenesis in Pediatric Osteosarcoma.” Cell Reports, April 10, 2014. \url{https://doi.org/10.1016/j.celrep.2014.03.003}. Specifically,
the data are derived from \url{https://www.cell.com/cms/10.1016/j.celrep.2014.03.003/attachment/281e4b0f-814f-45a0-ae9c-c6fdb812cb8b/mmc4.xlsx}
}
