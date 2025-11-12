fxn_scatterplot <- function(inData, legacyVar, apiVar) {
  ggplot2::ggplot(
    data = inData,
    mapping = aes(
      x = .data[[legacyVar]],
      y = .data[[apiVar]]
    )
  ) +
    geom_abline(intercept = 0, slope = 1, color = "red") +
    geom_point() +
    labs(x = legacyVar, y = apiVar) +
    theme_minimal()
}
#   inData <- inData |>
#     dplyr::mutate(date_datetime = lubridate::ymd_hms(date_datetime))
#   
#   scatterplot <- 
#     plotly::plot_ly(
#       data = inData,
#       x = ~.data[[input$legacyVars]],
#       y = ~.data[[input$apiVars]],
#       type = "scatter",
#       mode = "markers",
#       marker = list(
#         color = "#191919",
#         size = 3
#       ),
#       hoverinfo = "text",
#       text = ~paste0(
#         "<br><b>AZMet Station:</b> ", meta_station_name,
#         # "<br><b>Variable:</b> ", input$apiVars,
#         "<br><b>Date:</b> ", gsub(" 0", " ", format(date_datetime, "%b %d, %Y")),
#         "<br><b>Time:</b> ", format(date_datetime, "%H:%M:%S")
#         "<br>Legacy Value:</b> ", .data[[input$legacyVars]],
#         "<br>API Value:</b> ", .data[[input$apiVars]]
#       ),
#       showlegend = FALSE
#     )
#     
#   return(scatterplot)
# }