% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/aggregation.R
\name{GetAdjMat}
\alias{GetAdjMat}
\title{Get an adjacency matrix from a QFeatures object}
\usage{
GetAdjMat(obj, type = "all")
}
\arguments{
\item{obj}{An object of class 'SummarizedExperiment'}

\item{type}{The type of matrix. Available values are 'all', 'onlySepc' and 'onlyShared'. Default value is 'all'.}
}
\value{
An adjacency matrix
}
\description{
Get an adjacency matrix from a QFeatures object
}
\examples{
utils::data(Exp1_R25_pept, package='DAPARdata2')
obj <- Exp1_R25_pept[1:1000,]
obj <- addListAdjacencyMatrices(obj, 2)
X <- GetAdjMat(obj[[2]], 'all')
}
\author{
Samuel Wieczorek
}
