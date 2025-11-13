# Shiny app to compare Legacy and API values by year and station


# UI -----


ui <- htmltools::htmlTemplate(
  
  filename = "azmet-shiny-template.html",
  
  pageDataComparisonHourly = bslib::page(
    title = NULL,
    theme = theme, # `scr##_theme.R`
    
    bslib::layout_sidebar(
      sidebar = sidebarPage, # `scr##_sidebarPage.R`
      navsetCardTab
    ),
    
    # shiny::htmlOutput(outputId = "pageBottomText")
  )
)


# Server -----


server <- function(input, output, session) {
  
  
  # Reactives -----
  
  fullJoin <- shiny::eventReactive(input$retrieveHourlyData, {
    idRetrievingHourlyData <- shiny::showNotification(
      ui = "Retrieving hourly data . . .",
      action = NULL,
      duration = NULL,
      closeButton = FALSE,
      id = "idRetrievingHourlyData",
      type = "message"
    )
    
    on.exit(
      shiny::removeNotification(id = idRetrievingHourlyData), 
      add = TRUE
    )
    
    fxn_fullJoin(
      station = input$azmetStation,
      year = input$year
    )
  })
  
  # scatterplot <- shiny::eventReactive(input$retrieveHourlyData, {
  #   fxn_scatterplot(
  #     inData = fullJoin(),
  #     legacyVar = input$legacyVars,
  #     apiVar = input$apiVars
  #   )
  # })
  
  # scatterplotCaption <- shiny::eventReactive(input$retrieveHourlyData, {
  #   fxn_scatterplotCaption()
  # })
  
  scatterplotTitle <- shiny::eventReactive(input$retrieveHourlyData, {
    fxn_scatterplotTitle(azmetStation = input$azmetStation)
  })
  
  
  # Outputs -----
  
  output$scatterplot <- plotly::renderPlotly({
    fxn_scatterplot(
      inData = fullJoin(),
      legacyVar = input$legacyVars,
      apiVar = input$apiVars
    )
  })
  
  output$scatterplotCaption <- shiny::renderUI({
    shiny::req(fullJoin())
    fxn_scatterplotCaption()
  })
  
  output$scatterplotTitle <- shiny::renderUI({
    scatterplotTitle()
  })
}


# Run --------------------


shiny::shinyApp(ui = ui, server = server)
