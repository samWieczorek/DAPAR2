#' This method shows density plots which represents the repartition of
#' Partial Observed Values for each replicate in the dataset.
#' The colors correspond to the different conditions (Condition in colData of
#' the object of class \code{QFeatures}).
#' The x-axis represent the mean of intensity for one condition and one
#' entity in the dataset (i. e. a protein) 
#' whereas the y-axis count the number of observed values for this entity
#' and the considered condition.
#' 
#' @title Distribution of Observed values with respect to intensity values
#' 
#' @param obj A matrix that contains quantitative data.
#' 
#' @param i A vector of the conditions (one condition per sample).
#' 
#' @param title The title of the plot
#' 
#' @param palette The different colors for conditions
#' 
#' @return Density plots
#' 
#' @author Samuel Wieczorek, Enora Fremy
#' 
#' @examples
#' library(QFeatures)
#' utils::data(Exp1_R25_pept, package='DAPARdata2')
#' hc_mvTypePlot2(Exp1_R25_pept, 2, title="POV distribution")
#' 
#' pal <- ExtendPalette(length(unique(conds)), 'Dark2')
#' hc_mvTypePlot2(Exp1_R25_pept, 2, title="POV distribution", palette=pal)
#' 
#' @export
#' 
#' @import highcharter
#' 
hc_mvTypePlot2 <- function(obj, 
                           i, 
                           title=NULL, 
                           palette = NULL){
  
  if(missing(obj))
    stop("'obj' is required.")
  if(missing(i))
    stop("'i' is required.")
  if (is.numeric(i)) i <- names(obj)[[i]]
  
  if(is.null(obj))
    stop("'obj' is NULL.")
  
  qData <- assay(obj, i)
  conds <- colData(obj)$Condition
  
  
  
  
  if (is.null(conds)){return(NULL)}
  
  myColors <- NULL
  if (is.null(palette)){
    warning("Color palette set to default.")
    palette <- ExtendPalette(length(unique(conds)))
  } else {
    if (length(palette) != length(unique(conds))){
      warning("The color palette has not the same dimension as the number of samples")
      palette <- ExtendPalette(length(unique(conds)))
    }
  }
  
  conditions <- conds
  mTemp <- nbNA <- nbValues <- matrix(rep(0,nrow(qData)*length(unique(conditions))), 
                                      nrow=nrow(qData),
                                      dimnames=list(NULL,unique(conditions))
                                      )
  dataCond <- data.frame()
  ymax <- 0
  series <- list()
  myColors <- NULL
  j <- 1
  
  for (iCond in unique(conditions)){
    if (length(which(conditions==iCond)) == 1){
      
      mTemp[,iCond] <- qData[,which(conditions==iCond)]
      nbNA[,iCond] <- as.integer(is.OfType(qData[,which(conditions==iCond)]))
      nbValues[,iCond] <- length(which(conditions==iCond)) - nbNA[,iCond]
    } else {
      mTemp[,iCond] <- apply(qData[,which(conditions==iCond)], 1, mean, na.rm=TRUE)
      nbNA[,iCond] <- apply(qData[,which(conditions==iCond)],1,function(x) length(which(is.na(x) == TRUE)))
      nbValues[,iCond] <- length(which(conditions==iCond)) - nbNA[,iCond]
    }
    
    
    for (i in 1:length(which(conditions==iCond))){
      data <- mTemp[which(nbValues[, iCond] == i), iCond]
      tmp <- NULL    
      if (length(data) >= 2)
      {
        tmp <- density(mTemp[which(nbValues[,iCond]==i),iCond])
        tmp$y <- tmp$y + i
        if (max(tmp$y) > ymax) { ymax <- max(tmp$y)}
      }
      series[[j]] <- tmp
      myColors <- c(myColors, palette[which(unique(conditions)==iCond)])
      j <- j+1
    }
    
  }
  
  
  hc <-  highchart() %>%
    hc_title(text = title) %>%
    dapar_hc_chart(chartType = "spline", zoomType="xy") %>%
    
    hc_legend(align = "left", verticalAlign = "top",
              layout = "vertical") %>%
    hc_xAxis(title = list(text = "Mean of intensities")) %>%
    hc_yAxis(title = list(text = "Number of quantity values per condition"),
             #categories = c(-1:3)
             #min = 1, 
             # max = ymax,
             tickInterval= 0.5
    ) %>%
    # hc_colors(palette) %>%
    hc_tooltip(headerFormat= '',
               pointFormat = "<b> {series.name} </b>: {point.y} ",
               valueDecimals = 2) %>%
    dapar_hc_ExportMenu(filename = "POV_distribution") %>%
    hc_plotOptions(
      series=list(
        showInLegend = TRUE,
        animation=list(
          duration = 100
        ),
        connectNulls= TRUE,
        marker=list(
          enabled = FALSE)
        
      )
    )
  
  for (i in 1:length(series)){
    hc <- hc_add_series(hc,
                        data = list_parse(data.frame(cbind(x = series[[i]]$x, 
                                                           y = series[[i]]$y))), 
                        showInLegend=FALSE,
                        color = myColors[i],
                        name=conds[i])
  }
  
  # add three empty series for the legend entries. Change color and marker symbol
  for (c in 1:length(unique(conds))){
    hc <-  hc_add_series(hc,data = data.frame(),
                         name = unique(conds)[c],
                         color = palette[c],
                         marker = list(symbol = "circle"),
                         type = "line")
  }
  
  return(hc)
}


#' Plots a heatmap of the quantitative data. Each column represent one of
#' the conditions in the object of class \code{MSnSet} and 
#' the color is proportional to the mean of intensity for each line of
#' the dataset.
#' The lines have been sorted in order to vizualize easily the different
#' number of missing values. A white square is plotted for missing values.
#' 
#' @title Heatmap of missing values
#' 
#' @param obj xxx
#' 
#' @param i xxx
#' 
#' @return A heatmap
#' 
#' @author Samuel Wieczorek, Thomas Burger
#' 
#' @examples
#' library(QFeatures)
#' utils::data(Exp1_R25_pept, package='DAPARdata2')
#' mvImage(Exp1_R25_pept, 2)
#' 
#' @export
#' 
mvImage <- function(obj, i){
  
  if(missing(obj))
    stop("'obj' is required.")
  if(missing(i))
    stop("'i' is required.")
  if (is.numeric(i)) i <- names(obj)[[i]]
  
  if(is.null(obj))
    stop("'obj' is NULL.")
  
  qData <- assay(obj, i)
  conds <- colData(obj)$Condition
  originValues <- metadata(obj)$OriginOfValues
  data <- as.data.frame(rowData(obj[[i]])[,originValues])
  indices_MEC <- which(apply(data=="MEC", 1, sum) >0)
  
  if (length(indices_MEC)==0){
    warning("The dataset contains no Missing value on Entire Condition (MEC). So this plot is not available.")
    return(NULL)
  }else if (length(indices_MEC)==1){
    warning("The dataset contains only one Missing value on Entire Condition (MEC). Currently, Prostar does not handle such dataset to build the plot. 
          As it has no side-effects on the results, you can continue your imputation.")
    return(NULL)
  }
  
  qData <- qData[indices_MEC,]
  
  
  
  
  
  ### build indices of conditions
  indCond <- list()
  ConditionNames <- unique(conds)
  print(ConditionNames)
  
  indCond <- setNames(lapply(ConditionNames, function(x) {grep(x, conds)}), 
                      paste0('cond', 1:length(ConditionNames)))
  print(indCond)
  
  
  nNA1 = apply(as.matrix(qData[,indCond$cond1]), 1, function(x) sum(is.na(x)))
  nNA2 = apply(as.matrix(qData[,indCond$cond2]), 1, function(x) sum(is.na(x)))
  o <- order(((nNA1 +1)^2) / (nNA2 +1))
  exprso <- qData[o,]
  
  for (i in 1:nrow(exprso)){
    k <- order(exprso[i,indCond$cond1])
    exprso[i,rev(indCond$cond1)] <- exprso[i, k]
    .temp <- mean(exprso[i,rev(indCond$cond1)], na.rm = TRUE)
    exprso[i,which(!is.na(exprso[i,indCond$cond1]))] <- .temp
    
    k <- order(exprso[i,indCond$cond2])
    exprso[i,indCond$cond2] <- exprso[i, k+length(indCond$cond1)]
    .temp <- mean(exprso[i,indCond$cond2], na.rm = TRUE)
    exprso[i,length(indCond$cond1) + 
             which(!is.na(exprso[i,indCond$cond2]))] <- .temp
  }
  
  
  heatmap.DAPAR(exprso,
                col = colorRampPalette(c("yellow", "red"))(100),
                key=TRUE,
                srtCol= 0,
                labCol=conds,
                ylab = "Peptides / proteins",
                main = "MEC heatmap"
  )
  
  #heatmap_HC(exprso,col = colfunc(100),labCol=conds)
}

