#' `fxn_apiData.R` - Download and transform api data
#' 
#' @param station - AZMet station selection by user
#' @param year - Year selection by user
#' @return `apiData` - Downloaded and transformed api data


fxn_apiData <- function(station, year) {
  
  stationInfo <- station_list %>% 
    dplyr::filter(stn == station)
  
  if (nchar(stationInfo$stn_no) == 1) {
    station_id <- paste0("az0", stationInfo$stn_no)
  } else { # nchar (stationInfo$stn_no) > 1
    station_id <- paste0("az", stationInfo$stn_no)
  }
  
  apiData <- azmetr::az_hourly(
    station_id = station_id,
    start_date_time = paste(year, "-01-01 00"),
    end_date_time = paste(year, "-12-31 24")
  ) %>% 
    dplyr::select(
      "date_datetime", 
      "date_doy",
      "date_hour",
      "date_year", 
      "meta_needs_review", 
      "meta_station_id", 
      "meta_station_name", 
      "meta_version",
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
    dplyr::mutate(date_datetime = as.character(date_datetime))
  
  return(apiData)
}
