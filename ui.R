# Dashboard UI


sidebar <- dashboardSidebar(
  sidebarMenu(id = "tabs",
    menuItem("Introduction", tabName = "introduction", 
             icon = icon("arrow-right")),
    bs4SidebarHeader("Visual Analysis"),
     menuItem("Upload Data", tabName = "upload", 
              icon = icon("upload")),
     menuItem("Selection", tabName = "select", 
              icon = icon("object-group")),
     menuItem("Analysis", tabName = "analyze", 
              icon = icon("chart-bar")),
     menuItem("Result", tabName = "result", 
              icon = icon("download")),
    bs4SidebarHeader("Methodology"),
     menuItem("Docs", tabName = "docs",  icon = icon("book")),
     menuItem("FAQs", icon = icon("question-circle"), tabName = "faq"),
    menuItem("Contact", tabName = "contact", icon = icon("users")),
    menuItem("GitHub", tabName = "github", icon = icon("github"))
  )
)

body <- dashboardBody(
  tabItems(
    
##########  TAB 1 Start
    tabItem(
      tabName = 'introduction',
      box(
        width = NULL,
        title = "FSEA: Feature Set Enrichment Analysis",
        closable = FALSE,
        collapsible = FALSE,
        height = "500px",
        status = "primary",
        HTML("<p>
           Feature Set Enrichment Analysis [FSEA] is a method to identify classes of features that are over-represented in a small group of patients that shows unexpected result.</p>
           <h4>Objective</h4>
           <p>
           To identify overrepresentation of selected features in patient subset of clinical data against embedded set of patients in clinical data.</p>"),
        img(src = "images/method_FSEA.png", height= "350px")
      )
    ),

##########      TAB 1 End

    
##########      TAB 2 Start
    
    tabItem(tabName = "upload",
            fluidRow(
              column( width = 3,
                fileInput("file1","Upload embedding *",
                          multiple = FALSE, accept = c('.csv')),
                checkboxInput("fheader1", label = "File contains header", value = TRUE),
              ),
              column( width = 3,
                fileInput("file2","Upload feature data set *",
                          multiple = FALSE, accept = c('.csv')),
                checkboxInput("fheader2", label = "File contains header", value = TRUE),
              ),
              column( width = 3,
                      fileInput("file3","Upload attribute data type", 
                                multiple = FALSE, accept = c('.csv')),
                      checkboxInput("fheader3", label = "File contains header", value = TRUE),
              ),
              column( width = 1,
                      div(style = "display:inline-block; margin-top:32px", 
                      actionButton("loadfiles", label = "Load Data", status = "warning"))),
              column( width = 2,
                      div(style = "display:inline-block; float:right", 
                          actionButton('uploaded', label = 'Proceed', status = "success")))
            ),
            
            fluidRow(
              column(width = 12,
                uiOutput("uploadedtables")
              ) )
    ),
##########      TAB 2 End
    
##########      TAB 3 Start

    tabItem(tabName = "select",
      fluidRow(
        column(width = 3,
         selectInput("selectSetMode", label = "Subset Select Mode",
                     choices = c('Select group from Plot',
                                 'Select neighbour from point',
                                 'Enter custom set list'),
                     multiple = FALSE)   
        ),
        column(width = 9,
               div(style = "display:inline-block; float:right", 
                   actionButton('selected', label = 'Proceed', status = "success")))
      ),
      conditionalPanel(condition = "input.selectSetMode == 'Select group from Plot'",
        fluidRow(
            column(8, plotlyOutput('sampleSelectPlot0', height = '500px')),
            column(4, dataTableOutput('tableSelectOut'))
          )
        ),
        conditionalPanel(condition = "input.selectSetMode == 'Select neighbour from point'",
         fluidRow(
           column(9, plotlyOutput('sampleSelectPlot1', height = '800px')),
            column(3,
                   sliderInput(inputId= 'clusterRadius', label = 'Select Cluster Radius: ', 
                               min = 0, max = 10, value = 0, step = 1),
                   uiOutput('sampleSelectName')))),
        conditionalPanel(condition = "input.selectSetMode == 'Enter custom set list'",
        fluidRow(
          column(width = 8, plotlyOutput('sampleSelectPlot2', height = '600px')),
          column(width = 4, uiOutput('sampleSelectList'))
          ))
        ),
##########      TAB 3 End

##########      TAB 4 Start

  tabItem(tabName = "analyze",
      fluidRow(
      column(width = 3,
          selectInput("selectTestMode", label = "Select enrichment test Mode",
                      choices = c('Single attribute',
                                  'Multiple attributes',
                                  'All attributes'),
                      selected = 'All attributes',
                      multiple = FALSE)),
        column(width = 3,
               selectInput("selectCatDataTest", label = "Method for Categorical Data Type",
                           choices = c('Hypergeometric','Multivariate Hypergeometric'),
                           selected = 'Hypergeometric',multiple = FALSE)),
        column(width = 3,
               selectInput("selectDisDataTest", label = "Method for Discrete Data Type",
                           choices = c('KS-test'),selected = 'KS-test', multiple = FALSE)),
        column(width = 2,
               div(style = "display:inline-block; margin-top:30px", 
               actionButton("hyptest", label = "Test", status= 'info'))),
        column(width = 1,
               div(style = "display:inline-block; float:right", 
                   actionButton('analyzed', label = 'Proceed', status = "success")))
      ),
      HTML("<span> Additional Parameters </span> <hr>"),
      fluidRow(
        column(width = 3,
               sliderInput(inputId= 'threshslider', label = 'P-Value Threshold: ', 
                           min = 0, max = 1, value = 0.05, step = 0.05)),
        column(width = 6, uiOutput('additionParamsUI')),
        column(width = 3, 
               conditionalPanel(
                 conditio = "input.selectTestMode == 'Single attribute'",
                 uiOutput('singleAttrValueChoice')
                  )
               )
        # column(width = 3, uiOutput('colOpts2'))

        # column(width = 6,
        #  conditionalPanel(condition = "input.selectTestMode == 'Single attribute'",
        #                   uiOutput("singleAttribute")),
        #  conditionalPanel(condition = "input.selectTestMode == 'Multiple attributes'",
        #                   uiOutput("multipleAttribute")),
        #  conditionalPanel(condition = "input.selectTestMode == 'All attributes'")
        #  )
        ),
      HTML("<hr>"),
      fluidRow(
        column(width=8, 
               dataTableOutput("table4")
               ),
        column(width =4, 
               plotOutput("plot2", height = 200)
        )
        
      )
   ),

##########      TAB 4 End

##########       TAB 5 Start

tabItem(
  tabName = 'result',
  HTML("<span>Result will appear here"),
  # plotlyOutput("p"),
  # tableOutput("table"),
  
#   plotlyOutput('plotlyresult'),
#   # scatterD3Output("scatterPlot", height = "400px"),
# #   verbatimTextOutput("brushplotly")
#   dataTableOutput('table8')
#  tableOutput('table8')
  
  ),

##########       TAB 5 End


##########       TAB 6 Start

tabItem(
  tabName = 'docs',
  HTML("<span>Documentation will appear here")
),

##########       TAB 6 End



##########       TAB 7 Start
tabItem(
  tabName = 'faq',
  boxLayout(
    type = "columns",
    lapply(1:6, function(i) {
      box(
        width = NULL,
        title = paste("Question No.", i),
        closable = FALSE,
        collapsible = TRUE,
        status = "warning",
        solidHeader = FALSE,
        label = boxLabel(
          text = 1,
          status = "danger"
        ),
        height ="220px",
        "Some answer to the question in title"
        )
    })
    )
  ),

##########       TAB 7 End

##########       TAB 8 Start

tabItem(
  tabName = 'contact',
  HTML("<span>Contact will appear here")
),

##########       TAB 8 End

##########       TAB 9 Start

tabItem(
  tabName = 'github',
  HTML("<span>Github links will appear here")
)

##########       TAB 9 End

),

  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "css/style.css")
  )
)

title <- dashboardBrand(
  title = "My dashboard",
  color = "primary",
  href = "https://adminlte.io/themes/v3",
  image = "https://adminlte.io/themes/v3/dist/img/AdminLTELogo.png"
)

dashboardPage(
  dashboardHeader(
    title = "FSEA"
    # title = shinyDashboardLogo(
    #   theme = "grey_dark",
    #   boldText = "FSEA",
    #   mainText = "",
    #   badgeText = "v1.1"
    # )
#    div(style = "text-align:center",HTML('<h5>Feature Set Enrichment Analysis</h5>'))
  ),
  sidebar,
 body,
controlbar = dashboardControlbar(),
footer = dashboardFooter(
  left = a(
    href = "#",
    target = "_blank", "@SamuelBharti"
  ),
  right = "FSEA: 2021"
),
fullscreen = TRUE,
)