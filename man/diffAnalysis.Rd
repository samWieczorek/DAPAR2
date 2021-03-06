% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DiffAnalysis.R
\name{diffAnalysis}
\alias{diffAnalysis}
\title{Returns a \code{QFeatures} object with the results of
the differential analysis performed with 'limma package'.}
\usage{
diffAnalysis(obj, comp, th_pval = 0, th_logFC = 0)
}
\arguments{
\item{obj}{An object of class \code{SUmmarizeExperiment}.}

\item{comp}{The name of the comparison (given by the t-tests) on whihc to apply thresholds}

\item{th_pval}{xxx}

\item{th_logFC}{xxx}
}
\value{
An object of class \code{SummarizedExperiment}
}
\description{
This method returns a class \code{QFeatures} object with the results
of differential analysis
}
\examples{
library(QFeatures)
utils::data(Exp1_R25_pept, package='DAPARdata2')
obj <- Exp1_R25_pept[1:1000]
obj <- addAssay(obj, QFeatures::filterNA(obj[[2]],  pNA = 0), name='filtered')
obj <- addAssay(obj, t_test_sam(obj[[3]], colData(obj), FUN = 'compute.t.test'), name='t-test')
comp <- '25fmol_vs_10fmol'
da.se <- diffAnalysis(obj[['t-test']], comp, th_pval=0, th_logFC=0)

}
\author{
Samuel Wieczorek
}
