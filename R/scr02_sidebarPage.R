sidebarPage <- bslib::sidebar(
  width = 300,
  position = "left",
  open = list(desktop = "open", mobile = "always-above"),
  id = "sidebarPage",
  title = NULL,
  bg = "#FFFFFF",
  fg = "#191919",
  class = NULL,
  max_height_mobile = NULL,
  gap = NULL,
  padding = NULL,
  
  bslib::accordion(
    id = "accordionPage",
    #open = "DATE SELECTION",
    #multiple = TRUE,
    class = NULL,
    width = "auto",
    height = "auto",
    
    # Visible elements
    
    htmltools::p(
      bsicons::bs_icon("sliders"), 
      htmltools::HTML("&nbsp;"), 
      "DATA OPTIONS",
      htmltools::HTML("&nbsp;&nbsp;&nbsp;&nbsp;"),
      bslib::tooltip(
        bsicons::bs_icon("info-circle"),
        "Select a year and an AZMet station, then click or tap 'RETRIEVE HOURLY DATA'.",
        id = "infoDataOptions",
        placement = "right"
      ),
      
      class = "data-options-title"
    ),
    
    shiny::selectInput(
      inputId = "year",
      label = "Year",
      choices = sort(obsYears, decreasing = TRUE),
      selected = obsYearsInitial
    ),
    
    shiny::selectInput(
      inputId = "azmetStation",
      label = "Station",
      choices = sort(station_list$stn)
    ),
    
    shiny::actionButton(
      inputId = "retrieveHourlyData",
      label = "RETRIEVE HOURLY DATA",
      class = "btn btn-block btn-blue"
    )
  )
) # bslib::sidebar()
