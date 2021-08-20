configTab <- tabItem(tabName = "analyze",
        fluidRow(
          column(2,
                        div(style = "display:inline-block; float:left", 
                            actionButton('analyzedbck', label = 'Back', status = "success"))),
          column(8,
                 div(style = "text-align:center", 
                     HTML("<h5>Enrichment Test on All or Selected Clinotypes in Cohort</h5>"))
          ),
                # column(width = 2,
                # textOutput('qsln')),
                # column(width = 2,
                #        textOutput('pplen')),
                # column(width = 2,
                #        HTML('Cohort Group: 1')),
          column(2,
                 div(style = "display:inline-block; float:right", 
                     actionButton('analyzed', label = 'Proceed', status = "success")))
        ),
        hr(),
        fluidRow(
        column(2,
              
        textOutput('qslen'),
        textOutput('pplen'),
        hr(),
          fluidRow(column(12,
            selectInput("selectTestMode", label = "Select enrichment test Mode",
                          choices = c('Single attribute',
                                      'Multiple attributes',
                                      'All attributes'),
                          selected = 'All attributes',
                          multiple = TRUE))),
            fluidRow(column(width = 12,
              sliderInput(inputId= 'threshslider', label = 'P-Value Threshold: ', 
                          min = 0, max = 1, value = 0.05, step = 0.05))),
            fluidRow(column(12,
                sliderInput(inputId= 'threshslider2', label = 'Adjusted P-Value Threshold: ', 
                                        min = 0, max = 1, value = 0.05, step = 0.05))),
            fluidRow(column(width = 12,
              div(style = "display:inline-block; margin-top:30px", 
                  actionButton("hyptest", label = "Test", status= 'primary'))))
               ),
          column(width=10,
                 dataTableOutput("table4"),
                 conditionalPanel("$('#table4').hasClass('recalculating')", 
                                  tags$div('Loading ... ')
                 )
          ))
)
