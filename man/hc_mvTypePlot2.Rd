% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plots_mv_for_impute.R
\name{hc_mvTypePlot2}
\alias{hc_mvTypePlot2}
\title{Distribution of Observed values with respect to intensity values}
\usage{
hc_mvTypePlot2(obj, i, title = NULL, palette = NULL)
}
\arguments{
\item{obj}{A matrix that contains quantitative data.}

\item{i}{A vector of the conditions (one condition per sample).}

\item{title}{The title of the plot}

\item{palette}{The different colors for conditions}
}
\value{
Density plots
}
\description{
This method shows density plots which represents the repartition of
Partial Observed Values for each replicate in the dataset.
The colors correspond to the different conditions (Condition in colData of
the object of class \code{QFeatures}).
The x-axis represent the mean of intensity for one condition and one
entity in the dataset (i. e. a protein) 
whereas the y-axis count the number of observed values for this entity
and the considered condition.
}
\examples{
library(QFeatures)
utils::data(Exp1_R25_pept, package='DAPARdata2')
hc_mvTypePlot2(Exp1_R25_pept, 2, title="POV distribution")

pal <- ExtendPalette(length(unique(conds)), 'Dark2')
hc_mvTypePlot2(Exp1_R25_pept, 2, title="POV distribution", palette=pal)

}
\author{
Samuel Wieczorek, Enora Fremy
}
