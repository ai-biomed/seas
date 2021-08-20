dataExploreUI <- tabItem(tabName = "dataExplore",
     class = " main", 
    fluidRow(
      column(2,
             div(style = "display:inline-block; float:left", 
                 actionButton('exploredbck', label = 'Back', status = "success"))),
      column(8,
             div(style = "text-align:center", 
                 HTML("<h5>Explore Clinotype Relations using grouped box plot and scatter plot with linear modelling.</h5>"))
      ),
    column(2,
            div(style = "display:inline-block; float:right", 
                actionButton('explored', label = 'Proceed', status = "success")))
            ),
    hr(),
    fluidRow(
      add_busy_bar(),
      class = "",
      style = "margin-bottom: 5vh;",
             column(3,
                    uiOutput('optplot1tab2')
               ),
             column(9,
              plotlyOutput("plot2de")
               )),  
    fluidRow(
      class = "",
      style = "margin-top: 5vh;",
          column(3,
                 uiOutput('optplot2tab2')
               ),
          column(9,
              plotlyOutput("lmplot", height = "85vh")
             ))
  )
