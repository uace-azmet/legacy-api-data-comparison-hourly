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
    }
  )
  
  
  # Reactives -----
  
  apiData <- shiny::eventReactive(legacyData(), {
    idRetrievingHourlyData <- shiny::showNotification(
      ui = "Retrieving hourly API data . . .",
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

    fxn_apiData(
      station = input$azmetStation,
      year = input$year
    )
  })
  
  legacyData <- shiny::eventReactive(input$retrieveHourlyData, {
    idRetrievingHourlyData <- shiny::showNotification(
      ui = "Retrieving hourly Legacy data . . .",
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

    fxn_legacyData(
      station = input$azmetStation,
      year = input$year
    )
  })
  
  fullJoin <- shiny::eventReactive(apiData(), {
    idRetrievingHourlyData <- shiny::showNotification(
      ui = "Joining hourly Legacy and API data . . .",
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
      legacyData = legacyData(),
      apiData = apiData()
    )
  })
  
  reporting <- shiny::eventReactive(input$retrieveHourlyData, {
    fxn_reporting(
      year = input$year,
      legacyData = legacyData(),
      apiData = apiData()
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
    reporting()
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
    # shiny::req(fullJoin())
    fxn_scatterplotCaption(
      legacyData = legacyData(),
      legacyVar = input$legacyVars,
      apiData = apiData(),
      apiVar = input$apiVars,
      fullJoin = fullJoin()
    )
  })

  output$scatterplotTitle <- shiny::renderUI({
    scatterplotTitle()
  })
}


# Run --------------------


shiny::shinyApp(ui = ui, server = server)
