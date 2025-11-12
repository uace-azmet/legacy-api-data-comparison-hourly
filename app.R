# Shiny app to compare Legacy and API values by year and station


# UI -----


ui <- htmltools::htmlTemplate(
  
  filename = "azmet-shiny-template.html",
  
  pageFluid = bslib::page_fluid(
    title = NULL,
    theme = theme, # `scr##_theme.R`
    
    bslib::layout_sidebar(
      sidebar = sidebar, # `scr##_sidebar.R`

      # shiny::htmlOutput(outputId = "figureTitle"),
      # shiny::htmlOutput(outputId = "figureSummary"),
      plotly::plotlyOutput(outputId = "scatterplot")#,
      # shiny::htmlOutput(outputId = "figureCaption")
    ) |>
      htmltools::tagAppendAttributes(
        #https://getbootstrap.com/docs/5.0/utilities/api/
        class = "border-0 rounded-0 shadow-none"
      ),
    
    # shiny::htmlOutput(outputId = "pageBottomText")
  )
)

# ui <- fluidPage(
#   
#   titlePanel(title = "Compare hourly values by station"),
#   
#   sidebarLayout(
#     
#     sidebarPanel(
#       id = "sidebarPanel",
#       width = 4,
#       verticalLayout(
#         
#       )
#     ), # sidebarPanel()
#     
#     mainPanel(
#       id = "mainPanel",
#       width = 8,
#       
#       fluidRow(
#         column(
#           width = 11, 
#           align = "left", 
#           offset = 1, 
#           plotlyOutput(outputId = "scatterplot")
#         )
#       )
#     ) #mainPanel()
#   ) #sidebarLayout()
# ) #fluidpage()


# Server -----


server <- function(input, output, session) {
  
  fullJoinHourly <- eventReactive(input$station, {
    fxn_fullJoinHourly(
      input$year,
      input$station
    )
  })
  
  output$scatterplot <- renderPlotly({
    fxn_scatterplot(
      inData = fullJoinHourly(),
      legacyVar = input$legacyVars,
      apiVar = input$apiVars
    )
  })
}

shinyApp(ui = ui, server = server)
