

select_patientgrp <- function(embedding,center,radius){
  
  print(center)
  print(radius)
  cx <- embedding[,2][embedding[,1] == center]
  cy <- embedding[,3][embedding[,1] == center]
  r  <- radius
  print(cx)
  print(cy)
  print(r)
  pno <- c()
  embedding$Type <- "Unselected"
  print(embedding)
  #Select group coming under/on the circular distance from center patient.
  for(i in 1:length(embedding[,1])){
    px <- embedding[i,2]
    py <- embedding[i,3]
    d  <- sqrt(((px-cx)^2) + ((py-cy)^2))  
    if(d<=r){ pno <- append(pno,i)}
  }
  embedding$Type[pno] <- "Selected"
  print(embedding)
  
  # t <- list(family = "sans serif",
  #           size = 8,color = toRGB("grey50"))
  a <- list(
    x = cx,
    y = cy,
    text = "Selected Patient of Interest",
    xref = "x",
    yref = "y",
    showarrow = TRUE,
    arrowhead = 7,
    ax = 20,
    ay = -40
  )
  returnList <- c(a, embedding, cx, cy)
  
  return(returnList)

}