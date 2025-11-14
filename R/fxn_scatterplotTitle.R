#' `fxn_scatterplotTitle.R` - Build title for scatterplot tab
#' 
#' @param azmetStation - AZMet station selection by user
#' @return `scatterplotTitle` - Title for scatterplot based on selected station


fxn_scatterplotTitle <- function(azmetStation) {
  scatterplotTitle <- 
    htmltools::p(
      htmltools::HTML(
        paste0(
          bsicons::bs_icon("graph-up"), 
          htmltools::HTML("&nbsp;"),
          htmltools::HTML("&nbsp;"),
          toupper(
            paste0(
              "Hourly Data from the AZMet ", azmetStation, " Station"
            )
          ),
          htmltools::HTML("&nbsp;&nbsp;&nbsp;&nbsp;"),
          bslib::tooltip(
            bsicons::bs_icon("info-circle"),
            "Hover over points for station, date, hour, and variable values.",
            id = "infoScatterplotTitle",
            placement = "right"
          )
        ),
      ),
      
      class = "scatterplot-title"
    )
  
  return(scatterplotTitle)
}
