#' `fxn_fullJoin.R` - Download, transform, and join legacy and API data
#' 
#' @param station - AZMet station selection by user
#' @param year - Year selection by user
#' @return `fullJoin` - Downloaded, transformed, and joined legacy and API data


fxn_fullJoin <- function(station, year) {
  
  stationInfo <- station_list %>% 
    dplyr::filter(stn == station)
  
  legacy <- azmet_hourly_data_download( # from `uace-azmet/legacy-data-migration`
    station_list,
    station,
    years = year
  )
  
  legacy <- legacy$obs_hrly %>% 
    dplyr::select(
      "station_id",
      "station_number",
      "obs_datetime",
      "obs_year",
      "obs_doy",
      "obs_hour",
      "obs_seconds",
      "obs_version",
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
    dplyr::mutate(
      obs_hrly_precip_total = as.numeric(obs_hrly_precip_total),
      obs_hrly_relative_humidity = as.numeric(obs_hrly_relative_humidity),
      obs_hrly_sol_rad_total = as.numeric(obs_hrly_sol_rad_total),
      obs_hrly_temp_air = as.numeric(obs_hrly_temp_air),
      obs_hrly_temp_soil_10cm = as.numeric(obs_hrly_temp_soil_10cm),
      obs_hrly_temp_soil_50cm = as.numeric(obs_hrly_temp_soil_50cm),
      obs_hrly_actual_vp = as.numeric(obs_hrly_actual_vp),
      obs_hrly_vpd = as.numeric(obs_hrly_vpd),
      obs_hrly_wind_spd = as.numeric(obs_hrly_wind_spd),
      obs_hrly_wind_spd_max = as.numeric(obs_hrly_wind_spd_max),
      obs_hrly_wind_vector_dir = as.numeric(obs_hrly_wind_vector_dir),
      obs_hrly_wind_vector_dir_stand_dev = as.numeric(obs_hrly_wind_vector_dir_stand_dev),
      obs_hrly_wind_vector_magnitude = as.numeric(obs_hrly_wind_vector_magnitude),
      date_datetime = obs_datetime
    )
  
  if (nchar(stationInfo$stn_no) == 1) {
    station_id <- paste0("az0", stationInfo$stn_no)
  } else { # nchar (stationInfo$stn_no) > 1
    station_id <- paste0("az", stationInfo$stn_no)
  }
  
  api <- azmetr::az_hourly(
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
  
  fullJoin <- dplyr::full_join(
    x = legacy,
    y = api,
    by = "date_datetime"
  )
  
  return(fullJoin)
}
