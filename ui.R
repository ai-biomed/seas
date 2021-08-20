# Dashboard UI
source('userInterface/uploadUI.R')
source('userInterface/introductionUI.R')
source('userInterface/selectionUI.R')
source('userInterface/configUI.R')
source('userInterface/resultUI.R')
source('userInterface/faqUI.R')
source('userInterface/contactUI.R')
source('userInterface/dataExploreUI.R')

sidebar <- dashboardSidebar(
  skin = "light",
  sidebarMenu(id = "tabs",
    menuItem("Introduction", tabName = "introduction", 
             icon = icon("arrow-right")),
    bs4SidebarHeader("Input"),
      menuItem("Data Input", tabName = "upload",
              icon = icon("upload")),
    bs4SidebarHeader("Clinotype Relation"),
    menuItem("Clinotype Relation", tabName = "dataExplore",
             icon = icon("project-diagram")),
    bs4SidebarHeader("Select Cohort"),
      menuItem("Cohort Selection", tabName = "select", 
              icon = icon("object-group")),
    bs4SidebarHeader("Analysis and Results"),
      menuItem("Enrichment Analysis", tabName = "analyze", 
              icon = icon("chart-bar")),
      menuItem("Result", tabName = "result", 
              icon = icon("download")),
    bs4SidebarHeader("Help"),
     menuItem("FAQs", icon = icon("question-circle"), tabName = "faq"),
    menuItem("About Us", tabName = "contact", icon = icon("users"))
  )
)

body <- dashboardBody(
  tabItems(
    introductionTab,
    uploadTab,
    dataExploreUI,
    selectionTab,
    configTab,
    resultTab,
    faqTab,
    contactTab
    ),

  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "css/style.css")
  )
)





title <- dashboardBrand(
  title = "SEAS",
  color = "primary",
  href = "https://aimed-uab.github.io/SEAS/",
  opacity = 1
)



dashboardPage(
  freshTheme = create_theme(
     bs4dash_vars(
       navbar_light_color = "#040404"
     ),
    bs4dash_layout(
      main_bg = "#fffffc" 
    ),
    bs4dash_sidebar_light(
      bg = "#FFF",
      color = "#040404",
      hover_color = "#0C4767",
    ),
     bs4dash_status(
       primary = "#4281A4", danger = "#BF616A", success = '#2a9d8f', warning = '#F7B538', info = "#fffffc"
     ),
#    success = '#57A773'
#    2a9d8f
     bs4dash_color(
       blue = '#4281A4', 
       lime = '#EBEBEB',
       white = '#fffffc'
    )
  ),
  dashboardHeader(
    fixed = TRUE,
    border = TRUE,
    status = 'info',
    sidebarIcon = shiny::icon("water"),
    title = title,
     div(style = "margin-left:auto;margin-right:auto; text-align:center; color:black",HTML('<strong>Statistical Enrichment Analysis of Samples (SEAS): a general-purpose tool to annotate metadata neighborhoods of biological samples.</strong>'))
  ),
  sidebar,
 body,
#controlbar = dashboardControlbar(),
footer = dashboardFooter(
  left = a(
    href = "https://github.com/SamuelBharti",
    target = "_blank", "SEAS: 2021 || @SamuelBharti   "
  ),
#  right = "SEAS: 2021"
  right = a(
    href = "https://aimed-lab.org/",
    target = "_blank", HTML("<img height=25 src='images/aimed.png'/>")
  )
),
fullscreen = TRUE, dark = NULL
)