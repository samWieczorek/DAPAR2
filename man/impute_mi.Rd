% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/missingValuesImputation_PeptideLevel.R
\name{impute_mi}
\alias{impute_mi}
\title{Missing values imputation using the LSimpute algorithm.}
\usage{
impute_mi(x, sampleTab, lapala = TRUE, progress.bar = TRUE, ...)
}
\arguments{
\item{x}{xxxxx}

\item{sampleTab}{xxxx}

\item{lapala}{xxxxxxxxxxx}

\item{progress.bar}{Same as the function \code{mi.mix} in the package \code{imp4p}}

\item{...}{xxxxxxxx}
}
\value{
The \code{assay(obj)} matrix with imputed values instead of missing values.
}
\description{
Missing values imputation using the LSimpute algorithm.
}
\examples{
library(QFeatures)
utils::data(Exp1_R25_pept, package='DAPARdata2')
obj <- Exp1_R25_pept[1:1000,]
x <- assay(obj[[2]])
sampleTab <- colData(obj)
dat <- impute_mi(x, sampleTab)

}
\author{
Samuel Wieczorek
}
