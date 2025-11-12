#' `fxn_figure.R` - Build scatterplot of legacy versus API values
#' 
#' @param inData - Output from `fxn_fullJoin.R`
#' @param legacyVar - Legacy variable selection by user
#' @param apiVar - API variable selection by user
#' @return `figure` - Plotly rendered scatterplot

# https://plotly-r.com/ 
# https://plotly.com/r/reference/ 
# https://plotly.github.io/schema-viewer/
# https://github.com/plotly/plotly.js/blob/c1ef6911da054f3b16a7abe8fb2d56019988ba14/src/components/fx/hover.js#L1596
# https://www.color-hex.com/color-palette/1041718


fxn_figure <- function(inData, legacyVar, apiVar) {
  
  inData <- inData |>
    dplyr::mutate(date_datetime = lubridate::ymd_hms(date_datetime))
  
  figureFontFamily <- "proxima-nova, calibri, -apple-system, BlinkMacSystemFont, \"Segoe UI\", Roboto, \"Helvetica Neue\", Arial, \"Noto Sans\", sans-serif, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\", \"Noto Color Emoji\""
  
  max <- max(inData[[legacyVar]], inData[[apiVar]]) + (0.03 * max(inData[[legacyVar]], inData[[apiVar]]))
  min <- min(inData[[legacyVar]], inData[[apiVar]]) - (0.03 * min(inData[[legacyVar]], inData[[apiVar]]))

  figure <-
    plotly::plot_ly(
      data = inData,
      x = ~.data[[legacyVar]],
      y = ~.data[[apiVar]],
      type = "scatter",
      mode = "markers",
      marker = list(color = "rgba(25, 25, 25, 0.51)", size = 9),
      hoverinfo = "text",
      text = ~paste0(
        "<br><b>AZMet Station:</b> ", meta_station_name,
        "<br><b>Date:</b> ", gsub(" 0", " ", format(date_datetime, "%b %d, %Y")),
        "<br><b>Hour:</b> ", format(date_datetime, "%H:%M"),
        "<br><b>Legacy Value:</b> ", .data[[legacyVar]],
        "<br><b>API Value:</b> ", .data[[apiVar]]
      ),
      showlegend = FALSE
    ) %>% 
    
    plotly::config(
      displaylogo = FALSE,
      displayModeBar = TRUE,
      modeBarButtonsToRemove = c(
        "autoScale2d",
        "hoverClosestCartesian", 
        "hoverCompareCartesian", 
        "lasso2d",
        "select"
      ),
      scrollZoom = FALSE,
      toImageButtonOptions = list(
        format = "png", # Either png, svg, jpeg, or webp
        filename = "AZMet-legacy-api-data-comparison",
        height = 400,
        width = 700,
        scale = 5
      )
    ) %>%
    
    plotly::layout(
      font = list(
        color = "#191919",
        family = figureFontFamily,
        size = 13
      ),
      hoverlabel = list(
        bordercolor = "rgba(0, 0, 0, 0)",
        font = list(
          color = "#FFFFFF",
          family = figureFontFamily,
          size = 14
        )
      ),
      margin = list(
        l = 0,
        r = 50, # For space between plot and modebar
        b = 0, # For space between x-axis title and caption or figure help text
        t = 0,
        pad = 3 # For space between gridlines and yaxis labels
      ),
      modebar = list(
        bgcolor = "#FFFFFF",
        orientation = "v"
      ),
      shapes = list(
        list( # 1:1 line
          type = "line",
          layer = "below",
          x0 = min,
          x1 = max,
          xref = "x",
          y0 = min,
          y1 = max,
          yref = "y",
          line = list(
            color = "#8b0015",
            width = 1.0
          )
        )
      ),
      xaxis = list(
        fixedrange = FALSE,
        title = list(
          font = list(size = 14),
          standoff = 25,
          text = legacyVar
        ),
        zeroline = FALSE
      ),
      yaxis = list(
        fixedrange = FALSE,
        gridcolor = "#c9c9c9",
        title = list(
          font = list(size = 14),
          standoff = 25,
          text = apiVar
        ),
        zeroline = FALSE
      )
    )

  return(figure)
}