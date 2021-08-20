uploadTab <- tabItem(tabName = "upload",
        fluidRow(
        column(2,
              div(style = "display:inline-block; float:left", 
                  actionButton('toIntro', label = 'Introduction', status = "primary"))),
        column(8,
               div(style = "text-align:center;", 
                   HTML('<h5>Upload your own dataset to Analyze or Load/'),
                   a(href="demoData.zip", "Download", download=NA, target="_blank"),
                   HTML('our Demo data</h5>'), 
                   
                   
                   )
               ),
          column(2,
                  div(style = "display:inline-block; float:right", 
                      actionButton('uploaded', label = 'Proceed', 
                                   status = "success",
                                   )))
        ),
        hr(),
        fluidRow(
        column(3,
                selectInput("dataInput", 
                label = "",
                choices = c('Upload Clinical Data + Embedding',
                               'Upload Clinical Data + Compute SEAS Embedding',
                               'Load Demo Clinical Data + Demo Embedding'),
                multiple = FALSE)
                ),
        column(8,
                       
        conditionalPanel(
        condition = "input.dataInput=='Upload Clinical Data + Embedding'",
        fluidRow(       
        column(6,       
               fileInput("file2","Upload Clinical Dataset *",
                         multiple = FALSE, accept = c('.csv')),
               prettyCheckbox(
                       "fheader2", label = "File contains header", 
                       value = TRUE,
                       status = "primary",
                       shape = "curve"
               )
        ),
        column(6,
                fileInput("file1","Upload Patient Embedding *",
                           multiple = FALSE, accept = c('.csv')),
                prettyCheckbox(
                         "fheader1", label = "File contains header", 
                         value = TRUE,
                         status = "primary",
                         shape = "curve")                 
          ))
        ),
        conditionalPanel(
        condition = "input.dataInput=='Upload Clinical Data + Compute SEAS Embedding'",
          fluidRow(
                  column(4,       
                         fileInput("file3","Upload Clinical Dataset *",
                                   multiple = FALSE, accept = c('.csv')),
                         prettyCheckbox(
                                 "fheader3", label = "File contains header", 
                                 value = TRUE,
                                 status = "primary",
                                 shape = "curve"
                         )
                  ),
                  column(4,
                         radioButtons("embeddM", "Patient Embedding Method:",
                                      c("UMAP" = "umap",
                                        "tSNE" = "tsne"))
                  ),
                  column(4,
                         uiOutput('embeddingCal')
                  )
                  # column(4,
                  #        radioButtons("dist", "Distance Method:",
                  #                     c("Euclidian Distance" = "euclidian",
                  #                       "Cosine Similarity" = "cosine",
                  #                       "Jaccard Index" = "jaccard"))
                  # )
          )
       #   ,
       # fluidRow(
       # #         column(12,
       # #                uiOutput('embeddingCal')
       # #         )
       # # ,
       # column(4,
       #        dataTableOutput("tableEmbed2"))
       # )
        ),
        conditionalPanel(
        condition = "input.dataInput=='Load Demo Clinical Data + Demo Embedding'",
                fluidRow(
                        column(12, 
                HTML("<h6 class='text-center' style='margin-top:32px'>The Cancer Genome Atlas's GBM clinical case-study. Click on Load Data Button to start with demo data.</h6>"),
                        )
                )
        )),
          column(1,
                  div(style = "display:inline-block;float:right; margin-top:32px", 
                      actionButton("loadfiles", label = "Load Data", 
                                   status = "primary")
                      
                      ))
          
        ),
        # conditionalPanel(
        #         condition = "input.dataInput=='Upload Clinical Data + Compute SEAS                               Embedding'",
        #         fluidRow(
        #         column(8,
        #                uiOutput('embeddingCal')
        #         ),
        #         column(4,
        #                dataTableOutput("tableEmbed2"))
        # )),
        hr(),
        fluidRow(
          column(width = 12,
                 add_busy_bar(),
                 uiOutput("uploadedtables")
          ) )
)
