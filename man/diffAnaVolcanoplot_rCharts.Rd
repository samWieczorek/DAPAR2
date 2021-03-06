% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plots_volcano.R
\name{diffAnaVolcanoplot_rCharts}
\alias{diffAnaVolcanoplot_rCharts}
\title{Volcanoplot of the differential analysis}
\usage{
diffAnaVolcanoplot_rCharts(
  df,
  threshold_pVal = 1e-60,
  threshold_logFC = 0,
  conditions = NULL,
  clickFunction = NULL,
  palette = NULL,
  swap = FALSE
)
}
\arguments{
\item{df}{A dataframe which contains the following slots :
x : a vector of the log(fold change) values of the differential analysis,
y : a vector of the p-value values returned by the differential analysis.
index : a vector of the rownames of the data.
This dataframe must has been built with the option stringsAsFactors set 
to FALSE. There may be additional slots which will be used to show 
informations in the tooltip. The name of these slots must begin with the 
prefix "tooltip_". It will be automatically removed in the plot.}

\item{threshold_pVal}{A floating number which represents the p-value that
separates differential and non-differential data.}

\item{threshold_logFC}{A floating number which represents the log of the
Fold Change that separates differential and non-differential data.}

\item{conditions}{A list of the names of condition 1 and 2 used for the
differential analysis.}

\item{clickFunction}{A string that contains a JavaScript function used to 
show info from slots in df. The variable this.index refers to the slot 
named index and allows to retrieve the right row to show in the tooltip.}

\item{palette}{xxx}

\item{swap}{A boolean that indicates if the conditions have been swaped}
}
\value{
An interactive volcanoplot
}
\description{
Plots an interactive volcanoplot after the differential analysis.
Typically, the log of Fold Change is represented on the X-axis and the
log10 of the p-value is drawn on the Y-axis. When the \code{threshold_pVal}
and the \code{threshold_logFC} are set, two lines are drawn respectively on
the y-axis and the X-axis to visually distinguish between differential and
non differential data. With the use of the package Highcharter, a 
customizable tooltip appears when the user put the mouse's pointer over 
a point of the scatter plot.
}
\examples{
\donttest{
library(QFeatures)
utils::data(Exp1_R25_pept, package='DAPARdata2')
obj <- QFeatures::filterNA(Exp1_R25_pept,i='original') # remove all rows with NAs
qData <- assay(obj[['original']])
pData <- as.data.frame(colData(obj))
data <- limma.complete.test(qData,pData)
df <- data.frame(x=data[,1], y = -log10(data[,2]),index = as.character(rownames(qData)))
colnames(df) <- c("x", "y", "index")
tooltipSlot <- c("Sequence", "Score")
df <- cbind(df,rowData(obj[['original']])[tooltipSlot])
colnames(df) <- gsub(".", "_", colnames(df), fixed=TRUE)
if (ncol(df) > 3){
    colnames(df)[4:ncol(df)] <- 
    paste("tooltip_", colnames(df)[4:ncol(df)], sep="")}
hc_clickFunction <- JS("function(event) {
Shiny.onInputChange('eventPointClicked', [this.index]+'_'+ [this.series.name]);}")
cond <- unique(colData(obj)[['Condition']])
diffAnaVolcanoplot_rCharts(df, 2.5, 1, cond, hc_clickFunction) 
}

}
\author{
Samuel Wieczorek, Enora Fremy
}
