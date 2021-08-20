resultTab <- tabItem(
  tabName = 'result',
  fluidRow(class = "introduction",
           style = "display:flex;height:20px;text-align:center;
                flex-direction: column; justify-content: center;",
           column(2,
                  div(style = "display:inline-block; float:left", 
                      actionButton('resultbck', label = 'Back', status = "success"))),
           column(8,
                  HTML("<h5>Enriched Clinotypes.</h5> <em>Click on a row in the table to display visualization.</em>")
                  ),
           column(2)
           ),
  hr(),
  fluidRow(
    column(7,
           dataTableOutput("table5")),

    column(5,
           plotlyOutput("pieplotOut")
    )),
  HTML("<hr>"),
    fluidRow(
            style ="margin-top: 2vh;",
            column(2,
                   uiOutput("contColResUI")),
            column(10,
                   plotlyOutput('violinPlotRes', height = "65vh"))
    )
)