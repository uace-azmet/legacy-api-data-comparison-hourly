#' `fxn_reporting.R` - Build information text for reporting tab
#' 
#' @param year - Year selection by user
#' @param legacyData - Output from `fxn_legacyData.R`
#' @param apiData - Output from `fxn_apiData.R`
#' @return `reporting` - Text for latest update information


fxn_reporting <- function(year, legacyData, apiData) {
  
  # Inputs -----
  
  if (lubridate::leap_year(as.integer(year)) == TRUE) {
    expectedDays <- 366
  } else {
    expectedDays <- 365
  }
  
  expectedHours <- expectedDays * 24
  
  apiNAs <- apiData %>% 
    dplyr::select(
      "precip_total", 
      "relative_humidity", 
      "sol_rad_total", 
      "temp_airC", 
      "temp_soil_10cmC", 
      "temp_soil_50cmC", 
      "vp_actual", 
      "vp_deficit", 
      "wind_spd_max_mps", 
      "wind_spd_mps", 
      "wind_vector_dir", 
      "wind_vector_dir_stand_dev", 
      "wind_vector_magnitude"
    ) %>% 
    dplyr::summarise(total = sum(is.na(.)))
  
  legacyNAs <- legacyData %>% 
    dplyr::select(
      "obs_hrly_temp_air",
      "obs_hrly_relative_humidity",
      "obs_hrly_vpd",
      "obs_hrly_sol_rad_total",
      "obs_hrly_precip_total",
      "obs_hrly_temp_soil_10cm",
      "obs_hrly_temp_soil_50cm",
      "obs_hrly_wind_spd",
      "obs_hrly_wind_vector_magnitude",
      "obs_hrly_wind_vector_dir",
      "obs_hrly_wind_vector_dir_stand_dev",
      "obs_hrly_wind_spd_max",
      "obs_hrly_actual_vp"
    ) %>% 
    dplyr::summarise(total = sum(is.na(.)))
  
  
  # Outputs -----
  
  reporting <- 
    htmltools::p(
      htmltools::HTML(
        paste0(
          "<u>NUMBER OF DAYS REPORTING</u><br>",
          "Legacy: <strong>", length(unique(legacyData$obs_doy)), "</strong> of <strong>", expectedDays, "</strong> days expected<br>",
          "API: <strong>", length(unique(apiData$date_doy)), "</strong> of <strong>", expectedDays, "</strong> days expected<br>",
          "<br>",
          "<u>NUMBER OF HOURS REPORTING</u><br>",
          "Legacy: <strong>", nrow(legacyData), "</strong> of <strong>", expectedHours, "</strong> hours expected<br>",
          "API: <strong>", nrow(apiData), "</strong> of <strong>", expectedHours, "</strong> hours expected<br>",
          "<br>",
          "<u>NUMBER OF MISSING VALUES</u><sup>1,2</sup><br>",
          "Legacy: <strong>", legacyNAs$total, "</strong> values<br>",
          "API: <strong>", apiNAs$total, "</strong> values<br>",
          "<br>"
        )
      ),
      
      class = "reporting"
    )
  
  return(reporting)
}
