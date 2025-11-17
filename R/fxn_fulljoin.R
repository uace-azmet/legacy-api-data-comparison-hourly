#' `fxn_fullJoin.R` - Download, transform, and join legacy and API data
#' 
#' @param legacyData - Output from `fxn_legacyData.R`
#' @param apiData - Output from `fxn_apiData.R`
#' @return `fullJoin` - Downloaded, transformed, and joined legacy and API data


fxn_fullJoin <- function(legacyData, apiData) {
  
  fullJoin <- dplyr::full_join(
    x = legacyData,
    y = apiData,
    by = "date_datetime"
  )
  
  return(fullJoin)
}
