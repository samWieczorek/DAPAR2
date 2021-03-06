% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/import_2_qfeatures.R
\name{convertMSnset2QFeatures}
\alias{convertMSnset2QFeatures}
\title{Creates an object of class \code{QFeatures} from an object of class \code{MSnSet}}
\usage{
convertMSnset2QFeatures(
  obj,
  analysis,
  parentProtId,
  keyId,
  pipelineType = NULL,
  processes = NULL
)
}
\arguments{
\item{obj}{xxx.}

\item{analysis}{xxx}

\item{parentProtId}{For peptide entities, a string which is the name of a column in rowData. It contains the id of parent
proteins and is used to generate adjacency matrix and process to aggregation.}

\item{keyId}{The indice of the column containing the ID of entities 
(peptides or proteins)}

\item{pipelineType}{xxxx}

\item{processes}{xxxx}
}
\value{
An instance of class \code{QFeatures}.
}
\description{
xxxx
}
\examples{
library(QFeatures)
library(MSnbase)
utils::data(Exp1_R25_pept, package='DAPARdata')
obj <- Exp1_R25_pept
parentId <- 'Protein_group_IDs'
keyid <- 'Sequence'
ft <- convertMSnset2QFeatures(obj, 'conv',parentId, keyid )

}
\author{
Samuel Wieczorek
}
