faqTab <- tabItem(
  tabName = 'faq',
  # boxLayout(
  #   type = "columns",
  #   lapply(1:6, function(i) {
  #     box(
  #       width = NULL,
  #       title = paste("Question No.", i),
  #       closable = FALSE,
  #       collapsible = TRUE,
  #       status = "warning",
  #       solidHeader = FALSE,
  #       label = boxLabel(
  #         text = 1,
  #         status = "danger"
  #       ),
  #       height ="220px",
  #       "Some answer to the question in title"
  #     )
  #   })
  # )
  includeMarkdown("userInterface/documentation.Rmd")
)