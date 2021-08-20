introductionTab <-  tabItem(
  tabName = 'introduction',
  class = " main", 
  fluidRow(
    column(8,
          
           carousel(
             id = "mycarousel",
             carouselItem(
               caption = "Item 1",
               tags$img(src = "images/SEAS_workflow2.png",class="img-fluid")
             ),
             carouselItem(
               caption = "Item 2",
               tags$img(src = "images/SEAS_Poster.png",class="img-fluid")
             ),
             indicators = TRUE
           )
           # style = "text-align:center;
           #      flex-direction: column; justify-content: center;",
           # img(src = "images/SEAS_workflow2.png", class="img-fluid", height= "600px")
           ),
    column(4,
           fluidRow(
             column(12,
                    HTML("<h5>About SEAS</h5>"),
                    div(style = "text-align:justify",
                    HTML("<p>
                           We defined and provided the initial solution for the Statistical Enrichment Analysis of Samples (SEAS) problem. Here, we denoted a patient population S and a set of all clinical attributes C. Given any cohort s in S, the main question is which attributes are representative or enriched in s. To answer the question, we applied the 'gene-set enrichment analysis' method to computer the enrichment score and the statistical significance for each attribute. We customized the enrichment method to handle both numerical and categorical attributes.</p> <a target='_blank' href='https://aimed-uab.github.io/SEAS/'>Read more.</a>")))
           ),
           hr(),
           fluidRow(
             column(12,
                    HTML("Check out the tutorial <a target='_blank' href='https://aimed-uab.github.io/SEAS/docs/seas-demo/'>here</a> to learn SEAS Analysis."),
                    div(class="text-center align-items-center mt-5 pt-5", 
                        actionButton('begin', label = 'Begin', status = "primary")))
           )
           
           
           )
  )
)