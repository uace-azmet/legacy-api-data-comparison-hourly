sidebarScatterplot <- bslib::sidebar(
  width = 300,
  position = "left",
  open = list(desktop = "open", mobile = "always-above"),
  id = "sidebarScatterplot",
  title = NULL,
  bg = "#FFFFFF",
  fg = "#191919",
  class = NULL,
  max_height_mobile = NULL,
  gap = NULL,
  padding = NULL,
  
  bslib::accordion(
    id = "pageAccordion",
    #open = "DATE SELECTION",
    #multiple = TRUE,
    class = NULL,
    width = "auto",
    height = "auto",
    
    # Visible elements
    
    htmltools::p(
      bsicons::bs_icon("sliders"), 
      htmltools::HTML("&nbsp;"), 
      "DATA DISPLAY",
      htmltools::HTML("&nbsp;&nbsp;&nbsp;&nbsp;"),
      bslib::tooltip(
        bsicons::bs_icon("info-circle"),
        "Once data are retrieved, select legacy and API variables to display in the graph.",
        id = "infoDataOptions",
        placement = "right"
      ),
      
      class = "data-display-title"
    ),
    
    shiny::selectInput(
      inputId = "legacyVars", 
      label = "Legacy Variable", 
      choices = c(
        "obs_hrly_precip_total",
        "obs_hrly_relative_humidity",
        "obs_hrly_sol_rad_total",
        "obs_hrly_temp_air",
        "obs_hrly_temp_soil_10cm",
        "obs_hrly_temp_soil_50cm",
        "obs_hrly_actual_vp",
        "obs_hrly_vpd",
        "obs_hrly_wind_spd",
        "obs_hrly_wind_spd_max",
        "obs_hrly_wind_vector_dir",
        "obs_hrly_wind_vector_dir_stand_dev",
        "obs_hrly_wind_vector_magnitude"
      )
    ),
    
    shiny::selectInput(
      inputId = "apiVars", 
      label = "API Variable", 
      choices = c(
        "precip_total", 
        "relative_humidity", 
        "sol_rad_total", 
        "temp_airC", 
        "temp_soil_10cmC", 
        "temp_soil_50cmC", 
        "vp_actual", 
        "vp_deficit", 
        "wind_spd_mps", 
        "wind_spd_max_mps", 
        "wind_vector_dir", 
        "wind_vector_dir_stand_dev", 
        "wind_vector_magnitude"
      )
    )
  )
) # bslib::sidebar()
