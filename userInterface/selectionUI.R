selectionTab <- tabItem(tabName = "select",
   fluidRow(
      column(2,
             div(style = "display:inline-block; float:left", 
                 actionButton('selectedbck', label = 'Back', status = "success"))),
      column(8,
             div(style = "text-align:center", 
                 HTML("<h5>Select Cohort for Enrichment Analysis using one of the three methods.</h5>"))
      ),
    
     column(2,
            div(style = "display:inline-block; float:right", 
                actionButton('selected', label = 'Proceed', status = "success")))
   ),
   hr(),
   fluidRow(
      column(width = 3,
             selectInput("selectSetMode", label = "Subset Select Mode",
                         choices = c('Select Patient Neighborhood',
                                     'Select group from Plot',
                                     'Enter custom set list'),
                         multiple = FALSE)   
      ),
      column(width = 3,
             uiOutput('colorModePlot')
      ) 
   ),
   conditionalPanel(condition = "input.selectSetMode == 'Select group from Plot'",
                    fluidRow(
                      class = 'mainSections',
                      column(12, plotlyOutput('sampleSelectPlot0', height = '80vh'))
                      )

   ),
   conditionalPanel(condition = "input.selectSetMode == 'Select Patient Neighborhood'",
                    fluidRow(
                      column(10, plotlyOutput('sampleSelectPlot1', height = '800px')),
                      column(2,
                             sliderInput(inputId= 'clusterRadius', label = 'Select Cluster Radius: ', 
                                         min = 0, max = 10, value = 0, step = 1),
                             uiOutput('sampleSelectName')))),
   conditionalPanel(condition = "input.selectSetMode == 'Enter custom set list'",
                    fluidRow(
                      column(width = 9, plotlyOutput('sampleSelectPlot2', height = '600px')),
                      column(width = 3, uiOutput('sampleSelectList'))
                    )),
  
   fluidRow(
      column(12, dataTableOutput('tableSelectOut'))
   )
)