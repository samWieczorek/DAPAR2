% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{getListNbValuesInLines}
\alias{getListNbValuesInLines}
\title{Returns the possible number of values in lines in the data}
\usage{
getListNbValuesInLines(obj, i, type = "WholeMatrix")
}
\arguments{
\item{obj}{An object of class \code{QFeatures}}

\item{i}{The indice of the dataset (SummarizedExperiment) in the object}

\item{type}{WholeMatrix, AllCond or AtLeastOneCond}
}
\value{
An integer
}
\description{
Returns the possible number of values in lines in the data
}
\examples{
utils::data(Exp1_R25_pept, package='DAPARdata2')
getListNbValuesInLines(Exp1_R25_pept, 1)

}
\author{
Samuel Wieczorek, Enora Fremy
}
