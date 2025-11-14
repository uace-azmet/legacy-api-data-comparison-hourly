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
    )#,
    
    # shiny::htmlOutput(outputId = "pageBottomText")
  )
)


# Server -----


server <- function(input, output, session) {
  # shinyjs::useShinyjs(html = TRUE)
  # shinyjs::hideElement("navsetCardTab")
  
  
  # Observables -----
  
  shiny::observeEvent(fullJoin(), {
    # shinyjs::showElement("navsetCardTab")
    
    # shiny::updateSelectInput(
    #   inputId = "azmetStation",
    #   label = "Station",
    #   sort(station_list$stn)#,
    #   #selected = sort(station_list$stn)[1]
    # )
  })
  
  
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
  
  reportingTitle <- shiny::eventReactive(input$retrieveHourlyData, {
    fxn_reportingTitle(azmetStation = input$azmetStation)
  })
  
  scatterplotTitle <- shiny::eventReactive(input$retrieveHourlyData, {
    fxn_scatterplotTitle(azmetStation = input$azmetStation)
  })
  
  
  # Outputs -----
  
  output$reporting <- shiny::renderUI({
    shiny::req(fullJoin())
    fxn_reporting(
      azmetStation = input$azmetStation,
      inData = fullJoin()
    )
  })
  
  output$reportingCaption <- shiny::renderUI({
    shiny::req(fullJoin())
    fxn_reportingCaption()
  })
  
  output$reportingTitle <- shiny::renderUI({
    reportingTitle()
  })
  
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
  
  # output$table <- shiny::renderTable({
  #   fullJoin()
  # })
}


# Run --------------------


shiny::shinyApp(ui = ui, server = server)
