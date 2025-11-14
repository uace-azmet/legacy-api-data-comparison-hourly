#' `fxn_legacyData.R` - Download and transform legacy data
#' 
#' @param station - AZMet station selection by user
#' @param year - Year selection by user
#' @return `legacyData` - Downloaded and transformed legacy data


fxn_legacyData <- function(station, year) {
  
  stationInfo <- station_list %>% 
    dplyr::filter(stn == station)
  
  legacyData <- azmet_hourly_data_download( # from `uace-azmet/legacy-data-migration`
    station_list,
    station,
    years = year
  )
  
  legacyData <- legacyData$obs_hrly %>% 
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
  
  return(legacyData)
}
