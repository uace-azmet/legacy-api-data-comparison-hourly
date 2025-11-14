#' `fxn_reportingCaption.R` - Build caption for reporting tab
#' 
#' @return `reportingCaption` - Caption for reporting tab


fxn_reportingCaption <- function() {
  reportingCaption <- 
    htmltools::p(
      htmltools::HTML(
        "<sup>1</sup> For all 'editable' variables<br>",
        "<sup>2</sup> See 'Scatterplot' tab for missing-value counts of individual 'editable' variables"
      ), 
      
      class = "reporting-caption"
    )
  
  return(reportingCaption)
}
