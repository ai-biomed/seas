function(input,output,session){

                           #User Interface functions.
# Next and previous
  observeEvent(input$uploaded, {
    updateTabItems(session, "tabs", "select")
  }
  )
  observeEvent(input$selected, {
    updateTabItems(session, "tabs", "analyze")
  }
  )
  observeEvent(input$analyzed, {
    updateTabItems(session, "tabs", "result")
  }
  )
  
# loading files
  dfembed <- eventReactive(input$loadfiles,{
    req(input$file1)
    df <- read.csv(input$file1$datapath, header = input$fheader1)
    colnames(df)[1] <- "Sample_ID"
    return(df)
  })
  
  
  dfmain <- eventReactive(input$loadfiles,{
    req(input$file2)
    df <- read.csv(input$file2$datapath, header = input$fheader2)
    colnames(df)[1] <- "Sample_ID"
    rownames(df) <- df[,1]
    return(df)
  })  
  
  dfColDataType <- eventReactive(input$loadfiles,{
    req(input$file3)
    df <- read.csv(input$file3$datapath, header = input$fheader3)
    colnames(df)[1] <- "Sample_ID"
    rownames(df) <- df[,1]
    return(df)
  })  
  
  colChoiceAttrName <- eventReactive(input$loadfiles , {
    dat = dfmain()
    dat <- dat[-1]
    colChoices <- as.vector(colnames(dat))
    return(colChoices)
  })
  
  
# loading tables
  output$tableEmbed <- renderDT({
    datatable(dfembed(),extensions = c('Responsive'), 
              options = list(pageLength = 5,responsive = TRUE)
    )
  })
  output$tableMain <- renderDT({
    datatable(dfmain(),extensions = c('Responsive'), 
              options = list(pageLength = 5,responsive = TRUE)
    )
  })
  output$tableColDataType <- renderDT({
    datatable(dfColDataType(),extensions = c('Responsive'), 
              options = list(pageLength = 5,responsive = TRUE)
    )
  })
  output$uploadedtables <- renderUI({
    req(input$file1,input$file2, input$file3)
         tabsetPanel(
           tabPanel("Embedding",
                    dataTableOutput('tableEmbed')),
           tabPanel("Feature Set",
                    dataTableOutput('tableMain')),
           tabPanel("Attribute Data Type",
                    dataTableOutput('tableColDataType'))
     )
  })
  
#plotting and select in tab "select"
  
######
######  //  Plot Mode: Select Sample IDs by lasso/box.
######
  

samplesSelect <- reactiveVal()

output$sampleSelectPlot0 <- renderPlotly({
  dat <- dfembed()
  cols <- ifelse(dat[,1] %in% samplesSelect(), "red", "black")
  fig  <- plot_ly(data = dat, x = ~x, y = ~y,
                  text = ~paste("Sample ID: ", dat[,1]),
                  source = 'x', customdata = dat[,1],
                  marker = list(color = cols))
  fig <- fig %>% add_markers()
  fig <- fig %>% layout(dragmode = 'lasso') 
  fig <- fig %>% event_register("plotly_selected")
  fig <- fig %>% config(displaylogo = FALSE, collaborate = FALSE)
  fig

})

observeEvent(event_data("plotly_selected", source = 'x'), {
  samples <- event_data("plotly_selected", source = 'x')$customdata
  samples_old_new <- c(samplesSelect(), samples)
  samplesSelect(unique(samples_old_new))
})


# clear the set of cars when a double-click occurs
observeEvent(event_data("plotly_deselect", source = 'x'), {
  samplesSelect(NULL)
})

output$brushplotly <- renderPrint({
  d <- event_data("plotly_selected", source = 'x')
  if (!is.null(d)) d
})

output$tableSelectOut <- renderDT({
  dat1 <- dfmain()
  dat2 <- dfembed()
  dat3 <- filter(dat1, dat1[,1] %in% samplesSelect())
  if (!is.null(dat3)){
    return(
      datatable(
        dat3, extensions = c('Responsive'),
        options = list(pageLength = 5,responsive = TRUE)
      )
    )} else { HTML("Selected Samples will appear here.")}
})

######
######  //  Plot Mode: Select Sample ID and a cluster with radius R.
######
  
  output$sampleSelectName <-  renderUI({

    dat <- dfembed()
    selectInput("colSampleSelectByName", label= "Select a sample",
                choices = dat[,1], multiple = FALSE)
  })
  
  sampleCluster <- reactiveVal()

  output$sampleSelectPlot1 <- renderPlotly({
    embedding <- dfembed()
    center <- input$colSampleSelectByName
    r <- input$clusterRadius

    cx <- embedding[,2][embedding[,1] == center]
    cy <- embedding[,3][embedding[,1] == center]
    
    pno <- c()
    embedding$Type <- "Unselected"
    
    #Select group coming under/on the circular distance from center patient.
    for(i in 1:length(embedding[,1])){
      px <- embedding[i,2]
      py <- embedding[i,3]
      d  <- sqrt(((px-cx)^2) + ((py-cy)^2))  
      if(d<=r){ pno <- append(pno,i)}
    }
    embedding$Type[pno] <- "Selected"
    clusterTemp <- as.character(embedding[,1][embedding$Type == 'Selected'])
    sampleCluster(clusterTemp)
    
    t <- list(family = "sans serif",
               size = 8,color = toRGB("grey50"))
    a <- list(
      x = cx, y = cy,
      text = "Selected Patient of Interest",
      xref = "x", yref = "y",
      showarrow = TRUE, arrowhead = 7,
      ax = 20, ay = -40
    )
    fig <- plot_ly(data = embedding, x = ~x, y = ~y,
                   #text = ~paste("Sample ID: ", embedding[,1]),
                   text = embedding[,1],
    #               marker = list(color = as.factor(embedding$Type)))
                       color = as.factor(embedding$Type))
    fig <- fig %>% add_markers()
    fig <- layout(fig, title = 'Highlighting Patient Group',
                  annotations = a,
                  shapes = list(
                    list(type = 'circle',
                         xref = 'x', x0 = cx+r, x1 = cx-r,
                         yref = 'y', y0 = cy+r, y1 = cy-r,
                         fillcolor = 'rgb(50, 20, 90)', line = list(color = 'rgb(50, 20, 90)'),
                         opacity = 0.15)),
                  xaxis = list(title = "x-axis"),
                  yaxis = list(title = "y-axis"))
    fig
  })
  
######
######  //  Plot Mode: Select Custom Sample ID list.
######
  
  output$sampleSelectList <-  renderUI({
    
    dat <- dfembed()
    selectInput("colSampleSelectByList", label= "Select a sample",
                choices = dat[,1], multiple = TRUE)
  })
  
################

    customListQs <- reactiveVal()  
  
    output$sampleSelectPlot2 <- renderPlotly({
    embedding <- dfembed()
    selectedList <- c()
    selectedList <- input$colSampleSelectByList
    customListQs(selectedList)
    embedding$Type <- "Unselected"
    for(i in 1:length(selectedList)){
      embedding$Type[embedding[,1] == selectedList[i]] <- "Selected"
    }
    cols <- ifelse(embedding[,1] %in% selectedList, "red", "black")
    fig <- plot_ly(data = embedding, x = ~x, y = ~y,
                   #text = ~paste("Sample ID: ", embedding[,1]),
                   text = embedding[,1],
                   marker = list(color = cols))
                   #color = as.factor(embedding$Type))
    fig <- fig %>% add_markers()
    fig
  })
  
    
    
  
  output$additionParamsUI <- renderUI({
    
    colChoices <- colChoiceAttrName()

      if(input$selectTestMode == 'Single attribute'){
          fluidRow(
            column(width = 6,
                   selectInput("colSingleAttribute", label= "Select a column",
                               choices = colChoices, multiple = FALSE)),
            column(width = 6,
                   selectInput("colSingleDataType", label= "Data type",
                               choices = c("Categorical","Binary","Discrete"))))
      }
      else if(input$selectTestMode == 'Multiple attributes'){
        fluidRow(
          column(width = 12,
                 selectInput("colMultiAttribute", label= "Select a column",
                             choices = colChoices, multiple = TRUE))
        )}
  })
  
  
  output$singleAttrValueChoice <- renderUI({
    req(input$loadfiles)
    if(input$colSingleDataType == 'Categorical'){
      dat = dfmain()
      dat <- dat[-1]
      col = input$colSingleAttribute
      ff <- as.list(dat[col])
      ff <- ff[[1]]
      colChoices1 <- unique(ff)
      fluidRow(
        column(width = 12,
               selectInput("colCatCase", label= "Select a case",
                           choices = colChoices1, multiple = FALSE)),
      )
    }
  })
    
  

  
  # Callbacks
  
  
  testreq <- reactive({
    paste(input$hyptest, input$threshslider, 
          input$selectTestMode,input$colSingleDataType,
          input$colCatCase,input$colSingleAttribute,
          input$selectSetMode,input$sampleSelectList)
  })
  
  dfresult <- eventReactive(testreq(),{
    req(input$file1,input$file2)
    
    thresh <-  input$threshslider
    # df <- brushd()
    # qs <- as.character(df[,1])
    if(input$selectSetMode == 'Select group from Plot'){
      print("trying selecting mode 1")
      qs <- samplesSelect()
    }
    else if(input$selectSetMode == 'Select neighbour from point'){
      qs <- sampleCluster()
    }
    else if(input$selectSetMode == 'Enter custom set list'){
      qs <- customListQs()
    }
    else 
    {
      qs <- "Error"
    }
    
    if(input$selectTestMode == 'Single attribute'){
      fTInput <- input$colCatCase
      cols <- input$colSingleAttribute
      if(input$colSingleDataType == 'Discrete'){
        main <- dfmain()
        mainSet <- main[order(main[cols], decreasing = FALSE),]
        main.list <- mainSet$Sample_ID
        selected.set <- df[,1]
        rlCoVector <- as.numeric(mainSet[,cols])
        #v1 <- FSEA.ES1(rlVector, sslVector, weighted.score.type = 0)
        v2 <- FSEA.ES1(main.list, selected.set, weighted.score.type = 1, rlCoVector)
      #  res <- v2
        output$plot2 <- renderPlot({
          N   <- length(v2$RES)
          ind <- 1:N
          tempdftest <- data.frame(x = ind, y = v2$RES)
          ggplot(tempdftest, aes(x,y)) + geom_line(color="#69b3a2", size=1, alpha=0.9, linetype=1) + theme_ipsum()
        })
      }
      
    }
    else if(input$selectTestMode == 'Multiple attributes'){
      cols <- input$colMultiAttribute
      fTInput <- 'TRUE'
    }
    else{
      cols <- colnames(dfmain())
      cols <- cols[-1]
      fTInput <- 'TRUE'
    }
    
    res <- hypgm(background = dfmain(), query = qs, sltdcols = cols, 
                 FT = fTInput, threshold = thresh)
    return(res)

  })
  
  


  
# Result Display Functions
  output$table4 <- renderDT({
    return(
      datatable(dfresult(), extensions = c('Responsive'), 
                options = list(pageLength = 5,responsive = TRUE))
    )
  })
  
  # output$plot2 <- renderPlot({
  #   res <- dfresult()
  #   print(res)
  #   N   <- length(res$RES)
  #   ind <- 1:N
  #   tempdftest <- data.frame(x = ind, y = res$RES)
  #   print(tempdftest)
  #   ggplot(tempdftest, aes(x,y)) + geom_line(color="#69b3a2", size=1, alpha=0.9, linetype=1) + theme_ipsum()
  #   
  # })
  
  
}