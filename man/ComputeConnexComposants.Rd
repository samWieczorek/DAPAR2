% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_pep_prot_cc.R
\name{ComputeConnexComposants}
\alias{ComputeConnexComposants}
\title{Computes the connex components of a graph, represented by an adjacency matrix.}
\usage{
ComputeConnexComposants(X.list = NULL)
}
\arguments{
\item{X.list}{A list of adjacency matrices as provided by the function BuildListAdjacencyMatrices.}
}
\value{
A list of items containing the connex components derived from the matrices given in arguments
}
\description{
This function computes the connex components of a graph, represented by an adjacency matrix.
}
\examples{
utils::data(Exp1_R25_pept, package='DAPARdata2')
obj <- Exp1_R25_pept[1:1000,]
obj <- addListAdjacencyMatrices(obj, 2)
X.all <- GetAdjMat(obj[[2]], 'all')
X.onlyShared <- GetAdjMat(obj[[2]], 'onlyShared')
X.onlySpec <- GetAdjMat(obj[[2]], 'onlySpec')
X.list <- list(all=GetAdjMat(obj[[2]], 'all'), 
onlySHared = GetAdjMat(obj[[2]], 'onlyShared'), 
onlySpec = GetAdjMat(obj[[2]], 'onlyShared'))
cc <- ComputeConnexComposants(X.list)

}
\author{
Samuel Wieczorek
}
