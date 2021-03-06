
#' This method plots a bar plot which represents the distribution of the 
#' number of missing values (NA) per lines (ie proteins).
#' 
#' @title Bar plot of missing values per lines using highcharter
#' 
#' @param qData A matrix that contains the data to plot.
#' 
#' @param samplesData A dataframe which contains informations about 
#' the replicates.
#' 
#' @param indLegend The indice of the column names in \code{colData()}
#' 
#' @return A bar plot
#' 
#' @author Samuel Wieczorek, Enora Fremy
#' 
#' @examples
#' library(QFeatures)
#' utils::data(Exp1_R25_pept, package='DAPARdata2')
#' qData <- assay(Exp1_R25_pept[[2]])
#' samplesData <- colData(Exp1_R25_pept)
#' mvPerLinesHisto_HC(qData, samplesData)
#' 
#' @export 
#' 
#' @import highcharter
#' 
mvPerLinesHisto_HC <- function(qData, samplesData, indLegend="auto"){
  
  samplesData <- as.matrix(samplesData)
  
  if (identical(indLegend,"auto")) { indLegend <- c(2:length(colnames(samplesData)))}
  
  for (j in 1:length(colnames(qData))){
    noms <- NULL
    for (i in 1:length(indLegend)){
      noms <- paste(noms, samplesData[j,indLegend[i]], sep=" ")
    }
    colnames(qData)[j] <- noms
  }
  
  coeffMax <- .1
  
  NbNAPerCol <- colSums(is.na(qData))
  NbNAPerRow <- rowSums(is.na(qData))
  
  nb.col <- dim(qData)[2] 
  nb.na <- NbNAPerRow
  temp <- table(NbNAPerRow)
  nb.na2barplot <- c(temp, rep(0,1+ncol(qData)-length(temp)))
  
  if (sum(NbNAPerRow) == 0){
    nb.na2barplot <- rep(0,1+ncol(qData))
  }
  
  df <- data.frame(y=nb.na2barplot[-1])
  myColors = rep("lightgrey",nrow(df))
  myColors[nrow(df)] <- "red"
  
  
  
  h1 <-  highchart() %>% 
    hc_title(text = "#[lines] with X NA values") %>% 
    hc_add_series(data = df, type="column", colorByPoint = TRUE) %>%
    hc_colors(myColors) %>%
    hc_plotOptions( column = list(stacking = "normal"),
                    animation=list(duration = 100)) %>%
    hc_legend(enabled = FALSE) %>%
    hc_xAxis(categories = row.names(df), title = list(text = "#[NA values] per line")) %>%
    dapar_hc_ExportMenu(filename = "missingValuesPlot1") %>%
    hc_tooltip(enabled = TRUE,
               headerFormat= '',
               pointFormat = "{point.y} ")
  
  return(h1)
  
}