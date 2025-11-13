#' `fxn_scatterplotCaption.R` - Build caption for scatterplot
#' 
#' @return `scatterplotCaption` - Caption for scatterplot


fxn_scatterplotCaption <- function() {
  scatterplotCaption <- 
    htmltools::p(
      htmltools::HTML(
        "<strong>Maximum difference:</strong> value<br><strong>Mean difference:</strong> value"
      ), 
      
      class = "scatterplot-caption"
    )
  
  return(scatterplotCaption)
}
