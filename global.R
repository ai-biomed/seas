library(bs4Dash)
library(shiny)
library(shinyWidgets)
library(fresh)
library(plotly)
library(DT)
library(htmltools)
library(markdown)
library(dplyr)
library(Hmisc)
library(tidyverse)
library(knitr)
library(shinybusy)
library(Rtsne)
library(umap)

rmdfiles <- c("userInterface/contact.Rmd","userInterface/documentation.Rmd")
sapply(rmdfiles, knit, quiet = T)

# Demo File paths
embeddingFilePath <- "www/demoData/Embedding.csv"
clinicalFilePath <- "www/demoData/Clinical.csv"
