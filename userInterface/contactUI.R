contactTab <- tabItem(
  tabName = 'contact',
  # HTML("<span>Contact will appear here")
  includeMarkdown("userInterface/contact.Rmd")
)

gitTab <- tabItem(
  tabName = 'github',
  HTML("<span>Github links will appear here")
)