#' `fxn_reportingTitle.R` - Build title for reporting tab
#' 
#' @param azmetStation - AZMet station selection by user
#' @return `reportingTitle` - Title for reporting tab based on selected station


fxn_reportingTitle <- function(azmetStation) {
  reportingTitle <- 
    htmltools::p(
      htmltools::HTML(
        paste0(
          bsicons::bs_icon("file-text"), 
          htmltools::HTML("&nbsp;"),
          htmltools::HTML("&nbsp;"),
          toupper(
            paste0(
              "Hourly Data from the AZMet ", azmetStation, " Station"
            )
          )#,
          # htmltools::HTML("&nbsp;&nbsp;&nbsp;&nbsp;"),
          # bslib::tooltip(
          #   bsicons::bs_icon("info-circle"),
          #   "Hover over points for station, date, hour, and variable values.",
          #   id = "infoReportingTitle",
          #   placement = "right"
          # )
        )
      ),
      
      class = "reporting-title"
    )
  
  return(reportingTitle)
}
