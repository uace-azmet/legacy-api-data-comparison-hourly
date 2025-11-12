# Shiny app to compare Legacy and API values by year and station


# UI -----


ui <- htmltools::htmlTemplate(
  
  filename = "azmet-shiny-template.html",
  
  pageFluid = bslib::page_fluid(
    title = NULL,
    theme = theme, # `scr##_theme.R`
    
    bslib::layout_sidebar(
      sidebar = sidebar, # `scr##_sidebar.R`

      shiny::htmlOutput(outputId = "figureTitle"),
      # shiny::htmlOutput(outputId = "figureSummary"),
      plotly::plotlyOutput(outputId = "figure"),
      shiny::htmlOutput(outputId = "figureCaption")
    ) |>
      htmltools::tagAppendAttributes(
        #https://getbootstrap.com/docs/5.0/utilities/api/
        class = "border-0 rounded-0 shadow-none"
      ),
    
    # shiny::htmlOutput(outputId = "pageBottomText")
  )
)


# Server -----


server <- function(input, output, session) {
  
  fullJoin <- shiny::eventReactive(input$azmetStation, {
    fxn_fullJoin(
      station = input$azmetStation,
      year = input$year
    )
  })
  
  output$figure <- plotly::renderPlotly({
    fxn_figure(
      inData = fullJoin(),
      legacyVar = input$legacyVars,
      apiVar = input$apiVars
    )
  })
  
  output$figureCaption <- shiny::renderUI({
    fxn_figureCaption()
  })
  
  output$figureTitle <- shiny::renderUI({
    fxn_figureTitle(azmetStation = input$azmetStation)
  })
}


# Run --------------------


shiny::shinyApp(ui = ui, server = server)
