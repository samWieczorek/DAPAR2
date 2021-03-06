% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plots_heatmap.R
\name{heatmapD}
\alias{heatmapD}
\title{This function is a wrapper to 'heatmap.2' that displays
a numeric matrix}
\usage{
heatmapD(
  qData,
  conds,
  distance = "euclidean",
  cluster = "complete",
  dendro = FALSE
)
}
\arguments{
\item{qData}{A dataframe of numeric values}

\item{conds}{A vector of the conditions (one condition per sample).}

\item{distance}{The distance used by the clustering algorithm to compute
the dendrogram. See \code{help(heatmap.2)}}

\item{cluster}{the clustering algorithm used to build the dendrogram.
See \code{help(heatmap.2)}}

\item{dendro}{A boolean to indicate if the dendrogram has to be displayed}
}
\value{
A heatmap
}
\description{
Heatmap of the quantitative proteomic data of a \code{data.frame} object
}
\examples{
\dontrun{
library(QFeatures)
utils::data(Exp1_R25_prot, package='DAPARdata2')
ft <- Exp1_R25_prot
conds <- colData(Exp1_R25_prot)[['Condition']]
qData <- assay(ft[[2]])[1:100,]
heatmapD(qData, conds, dendro=T)
}

}
\author{
Samuel Wieczorek
}
