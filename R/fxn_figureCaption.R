#' `fxn_figureCaption.R` - Build caption for figure
#' 
#' @return `figureCaption` - Caption for figure


fxn_figureCaption <- function() {
  figureCaption <- 
    htmltools::p(
      htmltools::HTML(
        "<strong>Maximum difference:</strong> value<br><strong>Mean difference:</strong> value"
      ), 
      
      class = "figure-caption"
    )
  
  return(figureCaption)
}
