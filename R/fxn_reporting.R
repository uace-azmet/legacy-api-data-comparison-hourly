#' `fxn_reporting.R` - Build information text for reporting tab
#' 
#' @param azmetStation - AZMet station selection by user
#' @param inData - Output from `fxn_fullJoin.R`
#' @return `reporting` - Text for latest update information


fxn_reporting <- function(azmetStation, inData) {
  reporting <- 
    htmltools::p(
      htmltools::HTML(
        paste0(
          "<strong>Number of Days Reporting</strong><br>",
          "Legacy: <br>",
          "API: <br>",
          "<br>",
          "<strong>Number of Hours Reporting</strong><br>",
          "Legacy: <br>",
          "API: <br>",
          "<br>",
          "<strong>Number of Missing Values</strong><sup>1,2</sup><br>",
          "Legacy: <br>",
          "API: <br>",
          "<br>"
        )
      ),
      
      class = "reporting"
    )
  
  return(reporting)
}
