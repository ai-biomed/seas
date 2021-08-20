function(input,output,session){

  t <- list(family = 'Arial',
            size = 20, color = '#424B54')
                           #User Interface functions.
  NumericCols <- NULL
  FactorCols <- NULL
  
  observeEvent(input$begin, {
    updateTabItems(session, "tabs", "upload")
  }
  )
  observeEvent(input$toIntro, {
    updateTabItems(session, "tabs", "introduction")
  }
  )
  
  
  observeEvent(input$uploaded, {
    updateTabItems(session, "tabs", "dataExplore")
  }
  )
  observeEvent(input$exploredbck, {
    updateTabItems(session, "tabs", "upload")
  }
  )
  observeEvent(input$explored, {
    updateTabItems(session, "tabs", "select")
  }
  )
  observeEvent(input$selectedbck, {
    updateTabItems(session, "tabs", "dataExplore")
  }
  )
  
  observeEvent(input$selected, {
    updateTabItems(session, "tabs", "analyze")
  }
  )
  observeEvent(input$analyzedbck, {
    updateTabItems(session, "tabs", "select")
  }
  )
  observeEvent(input$analyzed, {
    updateTabItems(session, "tabs", "result")
  }
  )
  observeEvent(input$resultbck, {
    updateTabItems(session, "tabs", "analyze")
  }
  )
  
# loading files
  embedReq <- reactive({
    paste(
      
      input$loadfiles,
      input$calculate
    )
  })
  
  dfembed <- eventReactive(input$loadfiles,{

#    if(input$demoData)
#      req(input$file1)
    if(input$dataInput == 'Load Demo Clinical Data + Demo Embedding'){
      df <- read.csv(embeddingFilePath, header = TRUE)
    }
    else if(input$dataInput == 'Upload Clinical Data + Compute SEAS Embedding'){
      req(input$file3)
      df <- embeddResult()
      return(df) 
      
    }
    else{
      req(input$file1)
      df <- read.csv(input$file1$datapath, header = input$fheader1)
    }
#   df <- read.csv(embeddingFilePath, header = TRUE)
    colnames(df)[1] <- "Sample_ID"
    return(df)
  })
  
  
  dfmain <- eventReactive(input$loadfiles,{
    if(input$dataInput == 'Load Demo Clinical Data + Demo Embedding'){
      df <- read.csv(clinicalFilePath, header = TRUE)
      
    }
    else if(input$dataInput == 'Upload Clinical Data + Compute SEAS Embedding'){
      req(input$file3)
      df <- read.csv(input$file3$datapath, header = input$fheader3)
    }
    else{
      req(input$file2)
      df <- read.csv(input$file2$datapath, header = input$fheader2)
    }
    
    colnames(df)[1] <- "Sample_ID"
    rownames(df) <- df[,1]
    return(df)
  })  
  
  # dfColDataType <- eventReactive(input$loadfiles,{
  #   req(input$file3)
  #   df <- read.csv(input$file3$datapath, header = input$fheader3)
  #   colnames(df)[1] <- "Sample_ID"
  #   rownames(df) <- df[,1]
  #   return(df)
  # })  
  

  
  colChoiceFactorName <- eventReactive(input$loadfiles, {
    datMain = dfmain()
    for(x in colnames(datMain)){
      if(class(datMain[,x])  == 'factor' | class(datMain[,x])  == 'logical') {FactorCols <- append(FactorCols,as.character(x))}
    }
    return(FactorCols)
  })
  colChoiceNumericName <- eventReactive(input$loadfiles, {
    datMain = dfmain()
    for(x in colnames(datMain)){
      if(class(datMain[,x])  == 'integer' | class(datMain[,x])  == 'numeric') {NumericCols <- append(NumericCols,as.character(x))}
    }
    return(NumericCols)
  })
  
  colChoiceNumericName2 <- eventReactive(input$file3, {
    datMain <- read.csv(input$file3$datapath, header = input$fheader3)
    for(x in colnames(datMain)){
      if(class(datMain[,x])  == 'integer' | class(datMain[,x])  == 'numeric') {NumericCols <- append(NumericCols,as.character(x))}
    }
    return(NumericCols)
  })
  
  colChoiceAttrName <- eventReactive(input$loadfiles, {
    dat = dfmain()
    dat <- dat[-1]
    colChoices <- as.vector(colnames(dat))
    return(colChoices)
  })
  
  
#calculating embedding
#   output$embeddingCal <- renderUI({
#     req(input$file3,input$loadfiles)
#     fluidRow(
#       column(4,
#              HTML("Carefully select the clinotypes to calculate embedding and click on Calculate button. View the results in embedding tab below.<br>
#                   Make sure to remove/fill missing values in your dataset.")
#              ),
#       column(6,
#              selectInput("embeddCal",
#                          label = "",
#                          choices = colChoiceNumericName(),
#                          multiple = TRUE
#              )
#       ),
#       column(2,
#              actionButton("calculate","Calculate",
#                           status = 'primary')
#       )
#       #,
#     #  column(8
#            #  ,
#             # dataTableOutput('tableEmbedCal')
# #)
#     )
#   })
#   
  output$embeddingCal <- renderUI({
    req(input$file3)
#    print(colChoiceNumericName2())
    fluidRow(
    column(12,
         selectInput("embeddCal",
                     label = "Clinotype for SEAS Embedding",
                     choices = colChoiceNumericName2(),
                     multiple = TRUE
         ),
         HTML("Carefully select the clinotypes to calculate embedding.<br>View the results in embedding tab below.<br>Make sure to pre-remove/fill missing values in your dataset.")
         #              ),
    )
    )
  })
  
  embeddResult <- eventReactive(input$embeddCal,{
    req(input$embeddCal)
    print("Entered")
    dat <- read.csv(input$file3$datapath, header = input$fheader3)
    method <- input$embeddM
    print(method)
    clinotypesNum <- input$embeddCal
    #clinotypesNum <- colChoiceNumericName()
   # Labels <- dat[,label]
    # dat <- dat[ , apply(dat, 2, function(x) !any(is.na(x)))]
    dat <-  dat  %>% drop_na(clinotypesNum)
    if(method == 'tsne'){
    tsne <- Rtsne(dat[,clinotypesNum], dims = 2, perplexity=30, 
                  verbose=TRUE, max_iter = 500, check_duplicates = FALSE)
    print("tsne calculated")
    dat2 <- data.frame("Sample_ID" = dat[,1],"x" = tsne$Y[,1], "y"= tsne$Y[,2])
    return(dat2)
    }
    else{
      umapRes <- umap(dat[,clinotypesNum])
      print("UMAP calculated")
      dat2 <- data.frame("Sample_ID" = dat[,1],
                         "x" = umapRes$layout[,1], 
                         "y"= umapRes$layout[,2])
      return(dat2)
    }
    
    # output$tableEmbedCal <- renderDT({
    #   datatable(tsne,extensions = c('Responsive'), class = 'cell-border stripe',
    #             options = list(pageLength = 5,responsive = TRUE)
    #   )})
    
  })
  
  output$tableEmbed2 <- renderDT({
    datatable(embeddResult(),extensions = c('Responsive'), 
               class = 'cell-border stripe',
              options = list(pageLength = 5,responsive = TRUE)
    )
  })
  
  
# loading tables
  output$tableEmbed <- renderDT({
    if(input$dataInput == 'Upload Clinical Data + Compute SEAS Embedding'){
      datatable(embeddResult(),extensions = c('Responsive'), class = 'cell-border stripe',
                options = list(pageLength = 5,responsive = TRUE)
      )
    }
else{
    datatable(dfembed(),extensions = c('Responsive'), class = 'cell-border stripe',
              options = list(pageLength = 5,responsive = TRUE)
    )}
  })
  output$tableMain <- renderDT({
    datatable(dfmain(),extensions = c('Responsive'), class = 'cell-border stripe',
              options = list(pageLength = 5,responsive = TRUE)
    )
  })
  output$uploadedtables <- renderUI({
    req(input$loadfiles
      #input$file1,input$file2, 
        #input$file3
        )
         tabsetPanel(
           tabPanel("Feature Set",
                    dataTableOutput('tableMain')),
           tabPanel("Embedding",
                    dataTableOutput('tableEmbed'))
           # tabPanel("Attribute Data Type",
           #          dataTableOutput('tableColDataType'))
     )
  })
  
# Drag and drop for datatype selection
  output$dragNdrop <- renderUI({
    
    cols <- colChoiceAttrName()
    bucket_list(
      header = "Drag Clinotypes to respective Data Types",
      add_rank_list(
        text = "Clinotypes",
        labels = cols,
        options = sortable_options(
          multiDrag = TRUE
        )
      ),
      add_rank_list(
        text = "Categorical Binary",
        labels = NULL,
      ),
      add_rank_list(
        text = "Discrete",
        labels = NULL
      ),
      add_rank_list(
        text = "Rank type",
        labels = NULL
      ),
      orientation = "horizontal"
      )
    
  })
  
# Tab -> Data Exploration
  output$optplot1tab2 <- renderUI({
    fluidRow(
      column(12,
         selectInput("factType", label = "Discrete Clinotype (X-axis)",
                     choices = sort(colChoiceFactorName()),
                     multiple = FALSE),
         selectInput("numType", label = "Continous Clinotype (Y-axis)",
                     choices = colChoiceNumericName(),
                     multiple = FALSE),
         selectInput("primeFact", label = "Group By",
                     choices = sort(colChoiceFactorName()),
                     multiple = FALSE)))
  })
    output$optplot2tab2 <- renderUI({
      fluidRow(
        column(12,
               selectInput("lmcol1", label = "Continous Clinotype (X-Axis)",
                           choices = colChoiceNumericName(),
                           multiple = FALSE),
               selectInput("lmcol2", label = "Continous Clinotype (Y-Axis)",
                           choices = sort(colChoiceNumericName()),
                           multiple = FALSE),
               selectInput("primeFact2", label = "Group By",
                           choices = sort(colChoiceFactorName()),
                           multiple = FALSE)))
    })

  
  output$dataSummary <- renderPrint({ 
    dat <- dfmain()
    summary(dat) 
  })
  
  
  
  output$plot2de  <- renderPlotly({
    req(input$loadfiles)
    datMain =  dfmain()
    a <- input$factType
    b <- input$numType
    colr <- input$primeFact
    levels(datMain[,a])[levels(datMain[,a]) == ""] <- "MissingLabel"
    levels(datMain[,colr])[levels(datMain[,colr]) == ""] <- "MissingLabel"
    fig1 <- plot_ly(datMain, x = datMain[,a], y = datMain[,b], 
                    color = datMain[,colr], type = "box",
                    line  = list(color = 'rgb(8,48,107)',outliercolor = 'rgb(8,48,107)', outlierwidth = 2, width = 2))
    fig1 <- fig1 %>% layout(boxmode = "group",
                            xaxis = list(title = a),
                            yaxis = list(title = b),
                            paper_bgcolor = '#F2F2F2',
                            plot_bgcolor = '#F2F2F2',
                            margin = list(t = 50),
                            font = t)
  })
  
  output$lmplot <- renderPlotly({
    req(input$loadfiles, input$primeFact)
    datMain =  dfmain()
    colr <- input$primeFact2
    a <- input$lmcol1
    b <- input$lmcol2
    datMain <-  datMain  %>% drop_na(a,b) 
    levels(datMain[,colr])[levels(datMain[,colr]) == ""] <- "MissingLabel"
    # Showing a linear Model Prediction and Correlation
    fit <- lm(datMain[,b] ~ datMain[,a], data = datMain )
    fig <- plot_ly(datMain, x = datMain[,a])
    fig <- fig %>% add_markers(y = datMain[,b], 
                               color = datMain[,colr], 
                               colors = c('#E08D79','#FFE1A8','#008DD5','#685F74'),
                               marker = list(size = 9,
                                             line = list(color = '#472D30',
                                                         width = 1)))
    fig <- fig %>% add_lines(x = datMain[,a], y = fitted(fit),
                             line = list(color = '#1E555C',
                                         width = 3.2),
                             name = "Linear Model Predcition")
    fig <- fig %>% layout(
      xaxis = list(title = a),
      yaxis = list(title = b),
      paper_bgcolor = '#F2F2F2',
      plot_bgcolor = '#F2F2F2',
      margin = list(t = 50),
      font = t
      
    )})
  
  
  
  
  
  
  
#plotting and select in tab "select"
  
######
######  //  Plot Mode: Select Sample IDs by lasso/box.
######
  output$colorModePlot <-  renderUI({
    ch <- colChoiceAttrName()
    ch <- append(ch,'EmbeddingGroups')
    ch <- sort(ch)
    selectInput("colorMode", label = "Select Patient Color Type",
                choices = ch,
                multiple = FALSE)   
  })
  

samplesSelect <- reactiveVal()

output$sampleSelectPlot0 <- renderPlotly({
  req(reactive(input$colorMode))
  dat <- dfembed()
  dat2 <- dfmain()
  NumericCols <- colChoiceNumericName()
  cm <- input$colorMode
  if(cm %in% NumericCols){
    dat2[,cm] <- cut2(dat2[,cm], g = 4)
  }
  if(cm == 'EmbeddingGroups'){
    dat2$EmbeddingGroups <-  dat[,4]
  }
  cols <- ifelse(dat[,1] %in% samplesSelect(),"triangle-up", "circle" )
  fig  <- plot_ly(data = dat, x = dat[,2], y = dat[,3],
                  text = ~paste("Sample ID: ", dat[,1]),
                  mode = 'markers',
                  source = 'x', customdata = dat[,1],
                  color = dat2[,cm],
                  marker = list(size=9))
  fig <- fig %>% add_markers()
  fig <- fig %>% layout(dragmode = 'lasso',
                        xaxis = list(title = "X-Coordinate for Patient"),
                        yaxis = list(title = "Y-Coordinate for Patient"),
                        paper_bgcolor = '#F2F2F2',
                        plot_bgcolor = '#F2F2F2',
                        margin = list(t = 50),
                        font = t) 
  fig <- fig %>% event_register("plotly_selected")
  fig <- fig %>% config(displaylogo = FALSE, collaborate = FALSE)
  fig

})

observeEvent(event_data("plotly_selected", source = 'x'), {
  samples <- event_data("plotly_selected", source = 'x')$customdata
  samples_old_new <- c(samplesSelect(), samples)
  samplesSelect(unique(samples_old_new))
})


# clear the set of patients when a double-click occurs
observeEvent(event_data("plotly_deselect", source = 'x'), {
  samplesSelect(NULL)
})

output$brushplotly <- renderPrint({
  d <- event_data("plotly_selected", source = 'x')
  if (!is.null(d)) d
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
    req(reactive(input$colorMode))
    dat <- dfembed()
    dat2 <- dfmain()
    NumericCols <- colChoiceNumericName()
    cm <- input$colorMode
    if(cm %in% NumericCols){
      dat2[,cm] <- cut2(dat2[,cm], g = 4)
    }
    if(cm == 'EmbeddingGroups'){
      dat2$EmbeddingGroups <-  dat[,4]
    }
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
    
    a <- list(
      x = cx, y = cy,
      text = "Selected Patient of Interest",
      xref = "x", yref = "y",
      showarrow = TRUE, arrowhead = 7,
      ax = 20, ay = -40
    )
    fig <- plot_ly(data = embedding, x = embedding[,2], y = embedding[,3],
                   #text = ~paste("Sample ID: ", embedding[,1]),
                   text = embedding[,1],
    #               marker = list(color = as.factor(embedding$Type)))
                   color = dat2[,cm], 
                  marker = list(size=9))
                      # color = as.factor(embedding$Type))
    fig <- fig %>% add_markers()
    fig <- layout(fig, title = 'Highlighting Patient Group',
                  annotations = a,
                  shapes = list(
                    list(type = 'circle',
                         xref = 'x', x0 = cx+r, x1 = cx-r,
                         yref = 'y', y0 = cy+r, y1 = cy-r,
                         fillcolor = 'rgb(50, 20, 90)', line = list(color = 'rgb(50, 20, 90)'),
                         opacity = 0.15)),
                  xaxis = list(title = "X-Coordinate for Patient"),
                  yaxis = list(title = "Y-Coordinate for Patient"),
                  paper_bgcolor = '#F2F2F2',
                  plot_bgcolor = '#F2F2F2',
                  margin = list(t = 50),
                  font = t)
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
    fig <- plot_ly(data = embedding, x = embedding[,2], y = embedding[,3],
                   #text = ~paste("Sample ID: ", embedding[,1]),
                   text = embedding[,1],
                   marker = list(color = cols))
                   #color = as.factor(embedding$Type))
    fig <- fig %>% add_markers()
    fig <- fig %>% layout(xaxis = list(title = "X-Coordinate for Patient"),
                          yaxis = list(title = "Y-Coordinate for Patient"),
                          paper_bgcolor = '#F2F2F2',
                          plot_bgcolor = '#F2F2F2',
                          margin = list(t = 50),
                          font = t) 
    fig
  })
  
    
    
  
    observe({
      cho <- append("All",colChoiceAttrName())
      updateSelectInput(
        session,
        'selectTestMode',
        choices = cho
      )
      
    })
    

  getQuerySet <- function(){
    if(input$selectSetMode == 'Select group from Plot'){
      print("trying selecting mode 1")
      qs <- samplesSelect()
    }
    else if(input$selectSetMode == 'Select Patient Neighborhood'){
      qs <- sampleCluster()
    }
    else if(input$selectSetMode == 'Enter custom set list'){
      qs <- customListQs()
    }
    else 
    {
      qs <- "Error"
    }
    return(qs)
  }
  
   reactive({
  })
   
   output$tableSelectOut <- renderDT(server = FALSE,{
     dat1 <- dfmain()
     qs <- getQuerySet()
     dat3 <- dat1[qs,] #           
  #   dat2 <- dfembed()
   #  dat3 <- filter(dat1, dat1[,1] %in% samplesSelect())
     if (!is.null(dat3)){
       return(
         datatable(
           dat3, extensions = c('Responsive','Buttons'), class = 'cell-border stripe',
           options = list(pageLength = 5,responsive = TRUE,
                          dom = 'Bfrtip',
                buttons = c('copy', 'csv','print'))
         )
       )} else { HTML("Selected Samples will appear here.")}
   })
   
  
   output$qslen <- renderText({
     qslen <- getQuerySet()
     qslen <- length(qslen)
     paste("Cohort Size: ", qslen)
     })
   
   output$pplen <- renderText({
     dat <- dfmain()
     pplen <- length(dat[,1]) 
     paste("Population Size: ", pplen)
     })
     
     
   # output$qslen <- renderUI({
   #   
   #   qslen <- getQuerySet()
   #   qslen <- length(qslen)
   #   fluidRow(
   #     column(12,
   #            HTML("Cohort size is: ",qslen )
   #            
   #            )
   #     
   #   )
# 
#   })
  
# Hypergeom
   hyprgm <- function(testCol,main,qs,thresh,thresh2,numCols){

     main1 <- main[!(main[,2] == "PredictionGroup"),]
     print(tail(main1,5))
     PG <- main[main[,1] == "PredictionGroup",1]
     qs0 <- length(PG)
     res <- c()
     for(i in testCol){
       mset <-  main1  %>% drop_na(i) 
       qs2 <- qs[(qs %in% mset[,1])]
       # if(class(main[,i]) == 'logical'| class(main[,i]) == 'factor'){ #| all(main[        ,i] == 'NaN')
       #   main[,i][is.na(main[,i])] <- "MissingValue"
       #   main[,i] <- as.factor(main[,i])
       # 
       #   }
       if(class(main1[,i]) == 'numeric' | class(main1[,i]) == 'integer' ){
         mset[,i] <- cut2(mset[,i], q = 4)
             # if(is.na(main[,i])){
             #   main[,i][is.na(main[,i])] <- 0
             # }
       }
       print(i)
       
       print(levels(mset[,i]))
       
       coln <- c()
       popsize <- c()
       csize <- c()
       v <- c()
       p <- c()
       e <- c()
       pk <- c()
       ck <- c()
       for(y in levels(mset[,i])){
         #print(y)
         # Total number of Patients in background data.
         N <- length(mset[,i])
         # Number of Patients in patient group.
         n <- length(qs) + qs0
#         qset <- main[qs,] #
         # K <- sum(main[,i] == y)
         # k <- sum(qset[,i] == y) #k
         K <- sum(mset[,i] == y)
         k <- sum(mset[qs2,i] == y) #k
         p.value <- phyper(q=k, m=K, n=N-K, k=n, lower.tail=TRUE)
         p.value <- round(p.value, digits = 4)
         # if(y == ""){
         #    y <- "Unknown"
         # }
         v <- append(v,y)
         p <- append(p,p.value)
         coln <- append(coln,i)
         ck <- append(ck,k)
         pk <- append(pk,K)
         popsize <- append(popsize,N)
         csize <- append(csize,n)
         if(is.na(p.value)){e <- append(e,"NA")} else{
           ifelse(((p.value <= thresh) & (p.value <= thresh2)),e <- append(e,"Enriched"),e <- append(e,"Not Enriched"))
           
         }
       }
       # print(coln)
       # print(e)
       # print(p)
       res <- rbind(res,cbind(coln,v,pk,ck,p,e,popsize,csize))
     }
     print(res[,5])
     q <- p.adjust(res[,5], method = 'fdr')
     res <- cbind(res,q)
     return(res)



   }

     
  # Callbacks
  
  
  testreq <- reactive({
    paste(

      input$threshslider,
      input$selectTestMode,
      input$selectSetMode,
      input$sampleSelectList,
      input$hyptest,
      input$threshslider2
      )
  })
  
  dfresult <- eventReactive(testreq(),{
#    req(input$file1,input$file2)
    thresh2 <- input$threshslider2
    thresh  <-  input$threshslider
    qs <- getQuerySet()
    factCols <- colChoiceFactorName()
    numCols  <- colChoiceNumericName()
    main <- dfmain()
    testCol  <- input$selectTestMode
    if(testCol == 'All'){testCol <- colChoiceAttrName()[-1]}
    res <- hyprgm(testCol,main,qs,thresh,thresh2,numCols)
    return(res)

  })

  output$table4 <- renderDT(server = FALSE,{
    req(input$selectTestMode)
    dat <- dfresult()
    if(!is.null(dat)){
      return(
        datatable(dat, colnames = c('Clinotype', 'Variable','Population','Cohort', 
                                    'P-Value','Enrichment',"N","n","Adjusted P-value"),
                  extensions = c('Responsive','Buttons'), 
                  class = 'cell-border stripe',
                  options = list(order = list(4, 'asc'),
                                  pageLength = 10,responsive = TRUE,
                                 dom = 'Bfrtip',
                                 buttons = c('copy', 'csv','print'))
                  #,style = 'bootstrap'
        )
      )
    }
  })
  

  output$table5 <- renderDT(server = FALSE,{
    dat <- dfresult()
    print(dat)
    dat <- dat[dat[,6] == "Enriched",]
      return(
        datatable(dat, selection = 'single', colnames = c('Clinotype', 'Variable','Population','Cohort', 
                                    'P-Value','Enrichment'),
                  extensions = c('Responsive','Buttons'), class = 'cell-border stripe',
                  
                  options = list(order = list(4, 'asc'),
                                 pageLength = 10,responsive = TRUE,
                                dom = 'Bfrtip',
                    buttons = c('copy', 'csv', 'print'))
                  #,style = 'bootstrap'
        )
      )
  })
  
  output$y11 = renderPrint({
    dat <- dfresult()
   # print(dat)
    dat <- dat[dat[,6] == "Enriched",]
    dat[input$table5_rows_selected,1]
    })
  
  # 
  # 
  # 
  output$pieplotOut <- renderPlotly({
    tempdf <- dfresult()
    
    dat1 <- tempdf[tempdf[,6] == "Enriched",]
    vart <- dat1[input$table5_rows_selected,1]
    
    labels <- tempdf[tempdf[,1] == vart,2]
    values <- as.vector(tempdf[tempdf[,1] == vart,4])

    
    fig <- plot_ly(type='pie', labels=labels, values=values,
                   textinfo='label+percent',
                   insidetextorientation='radial',
                   marker = list(colors = c('#AA9ABA','#E3B9BC','#008DD5','#685F74'),
                                 line = list(color = '#FFFFFF', width = 1)))
    fig <- fig %>% layout(title = paste('Composition of ',vart," values in cohort", sep = ""),
          paper_bgcolor = '#F2F2F2',
           plot_bgcolor = '#F2F2F2',
          margin = list(t = 60),

           font = list(family = 'Arial',
                       size = 12, color = '#424B54'))
    fig
  })
  
  
    output$contColResUI <- renderUI({
    
      selectInput("contColRes", label = "Continous Clinotype (Y-axis)",
                  choices = colChoiceNumericName(),
                  multiple = FALSE)
  })
  
  output$violinPlotRes <- renderPlotly({
    main <- dfmain()
    tempdf <- dfresult()
    dat1 <- tempdf[tempdf[,6] == "Enriched",]
    i <- dat1[input$table5_rows_selected,1]
    qs <- getQuerySet()
    main$State <- "Population"
    main[qs,'State'] = "Cohort"
    j <- input$contColRes
    
    if(class(main[,i]) == 'logical'| class(main[,i]) == 'factor' | all(main[,i] == 'NaN')){
        main[,i][is.na(main[,i])] <- "MissingValue"
        main[,i] <- as.factor(main[,i])
        
      }
      else if(class(main[,i]) == 'numeric' | class(main[,i]) == 'integer' ){
        main[,i] <- cut2(main[,i], g = 4)
      }
    levels(main[,i])[levels(main[,i]) == ""] <- "MissingLabel"
  fig <- main %>%
    plot_ly(type = 'violin') 
  fig <- fig %>%
    add_trace(
      x =  main[,i][main$State == 'Population'],
      y =  main[,j][main$State == 'Population'],
      legendgroup = 'Population',
      scalegroup = 'Population',
      name = 'Population',
      box = list(
        visible = T
      ),
      meanline = list(
        visible = T
      ),
      color = '#AA9ABA'
    ) 
  fig <- fig %>%
    add_trace(
      x =  main[,i][main$State == 'Cohort'],
      y =  main[,j][main$State == 'Cohort'],
      legendgroup = 'Cohort',
      scalegroup = 'Cohort',
      name = 'Cohort',
      box = list(
        visible = T
      ),
      meanline = list(
        visible = T
      ),
      color = '#E3B9BC'
    ) 
  
  fig <- fig %>%
    layout(
      xaxis = list(
        title = "Selected Enriched Clinotype"
      ),
      yaxis = list(
        zeroline = T,
        title = "Selected Continous Clinotype"
        
      ),
      violinmode = 'group'
    )
  
  fig
  
  })  
  # output$boxChartConfig <- renderPlotly({
  #   NumericCols <- colChoiceNumericName()
  #   datMain =  dfmain()
  #   cm <- input$colorMode
  #   qs <- getQuerySet()
  #   datMain$State <- "Background Set"
  #   datMain[qs,'State'] = "Selected Cohort"
  #   testCol  <- input$selectTestMode
  #   if(testCol %in% NumericCols){
  #      datMain[,testCol] <- cut2(datMain[,testCol], g = 4)
  #   }
  #   fig1 <- plot_ly() %>% 
  #     add_trace(datMain, x = datMain[,testCol],
  #               line  = list(color = 'rgb(8,48,107)',outliercolor = 'rgb(8,48,107)', 
  #                            outlierwidth = 2, width = 2),
  #               y = datMain[,cm],
  #               color =  datMain[,'State'],
  #               colors =  c('#AA9ABA','#E3B9BC','#008DD5','#685F74'),
  #               type = "box") %>% 
  #     layout(boxmode = "group",
  #       title = paste('Distribution of ',cm," in background and selected cohort per ",testCol, sep = ""),
  #       xaxis = list(title = "Selection State"),
  #       yaxis = list(title = cm),
  #       paper_bgcolor = '#F2F2F2',
  #       plot_bgcolor = '#F2F2F2',
  #       margin = list(t = 50),
  #       font = t)
  #   return(fig1)
  # })
  # 
  
}