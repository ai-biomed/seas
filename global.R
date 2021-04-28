library(bs4Dash)
library(shiny)
#library(shinydashboard)
library(ggplot2)
library(Cairo) 
library(hrbrthemes)
#library(dashboardthemes)
#library(shiny.semantic)
#library(semantic.dashboard)
library(plotly)
library(DT)

library(scatterD3)

mtcars

source("enrichByHyp.R",local = TRUE)$value
source("enrichByRes.R",local = TRUE)$value
source("selectByCluster.R",local = TRUE)$value