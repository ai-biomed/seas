# Enrichment Testing by hypergeometric ||  version 1.

hypgm <- function(background,query,sltdcols,FT,threshold){
  background <- background
  query <- query
  sltdcols <- sltdcols
  FT <- FT
  thresh <- threshold
  #    coldatatype
  #    casePair
  tempdf <-as.data.frame(matrix(nrow=length(sltdcols),ncol=7))
  colnames(tempdf) <- c("Attribute","N","K","n","k","PValue","Significant")
  
  # Total number of Patients in background data.
  N <- length(background[,1])
  # Number of Patients in patient group.
  n <- length(query)      
  qset <- background[query,] # change this !!!!!!!!!!!
  
  for (i in 1:length(sltdcols)){
    
    # Number of selected feature type in background data.
    K <- sum(background[,sltdcols[i]] == FT)
    # N-K = Number of non-required feature type in selected attribute in background data.
    # Number of selected feature type in patient group.
    #print(qset)
    k <- sum(qset[,sltdcols[i]] == FT)      #k
    #   k.range <- 0:min(k,K)
    # Hypergeometric Testing for p-value
    p.value <- phyper(q=k, m=K, n=N-K, k=n, lower.tail=TRUE)
    p.value <- round(p.value, digits = 4)
    #   Store values in dataframe
    
    tempdf$Attribute[i] <- sltdcols[i]
    tempdf$N[i] <- N 
    tempdf$K[i] <- K 
    tempdf$n[i] <- n 
    tempdf$k[i] <- k 
    tempdf$PValue[i] <- p.value
    tempdf$Threshold[i] <- thresh
    if(p.value <= thresh){
      tempdf$Significant[i] <- "Yes"
    }else{tempdf$Significant[i] <- "No"}
    
  }
  return(tempdf)
}