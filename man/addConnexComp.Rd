% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_pep_prot_cc.R
\name{addConnexComp}
\alias{addConnexComp}
\title{Add the list of connex components to an assay in the object of classe Feeatures.}
\usage{
addConnexComp(obj, i)
}
\arguments{
\item{obj}{An object of class 'QFeatures'}

\item{i}{The indice of the dataset (class 'SumarizedExperiment') in the list of 'obj' on which to apply the aggregation.}
}
\value{
An object of class 'QFeatures'
}
\description{
xxxxx
}
\examples{
utils::data(Exp1_R25_pept, package='DAPARdata2')
obj <- Exp1_R25_pept[1:1000,]
obj <- addListAdjacencyMatrices(obj, 2)
obj <- addConnexComp(obj, 2)

}
\author{
Samuel Wieczorek
}
