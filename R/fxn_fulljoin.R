#' `fxn_fullJoin.R` - Download, transform, and join legacy and API data
#' 
#' @param station - AZMet station selection by user
#' @param year - Year selection by user
#' @return `fullJoin` - Downloaded, transformed, and joined legacy and API data


fxn_fullJoin <- function(legacyData, apiData) {
  
  fullJoin <- dplyr::full_join(
    x = legacyData,
    y = apiData,
    by = "date_datetime"
  )
  
  return(fullJoin)
}
