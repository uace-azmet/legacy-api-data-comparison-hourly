navsetCardTab <- bslib::navset_card_tab(
  id = "navsetCardTab",
  selected = "reporting",
  title = NULL,
  sidebar = NULL,
  header = NULL,
  footer = NULL,
  height = 700,
  full_screen = TRUE,
  #wrapper = card_body,
  
  bslib::nav_panel(
    title = "Reporting",
    value = "reporting"
  ),
  
  bslib::nav_panel(
    title = "Scatterplot",
    value = "scatterplot",
    
    bslib::layout_sidebar(
      sidebar = sidebarScatterplot, # `scr##_sidebarScatterplot.R`
      
      shiny::htmlOutput(outputId = "scatterplotTitle"),
      # shiny::htmlOutput(outputId = "figureSummary"),
      plotly::plotlyOutput(outputId = "scatterplot"),
      shiny::htmlOutput(outputId = "scatterplotCaption")
    )
  ),
  
  bslib::nav_panel(
    title = "Validation",
    value = "validation"
  )
) |>
  htmltools::tagAppendAttributes(
    #https://getbootstrap.com/docs/5.0/utilities/api/
    class = "border-0 rounded-0 shadow-none"
  )
