% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gistic_data.R
\name{target_gistic_se}
\alias{target_gistic_se}
\title{load TARGET GISTIC data as summarized experiment}
\usage{
target_gistic_se()
}
\description{
load TARGET GISTIC data as summarized experiment
}
\examples{
res = target_gistic_se()

res

head(colData(res))
assay(res,'cn')[1:5,1:5]


}
