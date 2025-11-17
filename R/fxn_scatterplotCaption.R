#' `fxn_scatterplotCaption.R` - Build caption for scatterplot
#' 
#' @param legacyData - Output from `fxn_legacyData.R`
#' @param legacyVar - Legacy variable selection by user
#' @param apiData - Output from `fxn_apiData.R`
#' @param apiVar - API variable selection by user
#' @param fullJoin - Output from `fxn_fullJoin.R`
#' @return `scatterplotCaption` - Caption for scatterplot


fxn_scatterplotCaption <- function(legacyData, legacyVar, apiData, apiVar, fullJoin) {
  
  # Inputs -----
  
  dataDifferences <- fullJoin %>% 
    dplyr::mutate(differences = .[legacyVar] - .[apiVar])
  
  dataDifferencesNonZero <- dataDifferences %>% 
    dplyr::summarise(n = sum(differences != 0))
  
  apiVarNAs <- apiData %>% 
    dplyr::select(dplyr::all_of(apiVar)) %>% 
    dplyr::summarise(total = sum(is.na(.)))
  
  legacyVarNAs <- legacyData %>% 
    dplyr::select(dplyr::all_of(legacyVar)) %>% 
    dplyr::summarise(total = sum(is.na(.)))
  
  
  # Outputs -----
  
  scatterplotCaption <- 
    htmltools::p(
      htmltools::HTML(
        paste0(
          "Maximum difference: <strong>", max(dataDifferences$differences, na.rm = TRUE), "</strong><br>",
          "Minimum difference: <strong>", min(dataDifferences$differences, na.rm = TRUE), "</strong><br>",
          "Non-zero-difference count: <strong>", dataDifferencesNonZero, "</strong><br>",
          
          "Legacy NAs: <strong>", legacyVarNAs$total, "</strong> ", legacyVar, "<br>",
          "API NAs: <strong>", apiVarNAs$total, "</strong> ", apiVar
        )
      ), 
      
      class = "scatterplot-caption"
    )
  
  return(scatterplotCaption)
}
