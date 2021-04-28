# Enrichment Testing by RES ||  version 1.

# Enrichment Test

FSEA.ES1 <-
  function(main.list, selected.set, weighted.score.type = 1, correl.vector = NULL) {
    
    tag.indicator <- sign(match(main.list, selected.set, nomatch = 0))  
    # notice that the sign is 0 (no tag) or 1 (tag)
    no.tag.indicator <- 1 - tag.indicator
    N <- length(main.list)
    Nh <- length(selected.set)
    Nm <- N - Nh
    if (weighted.score.type == 0) {
      correl.vector <- rep(1, N)
    }
    alpha <- weighted.score.type
    correl.vector <- abs(correl.vector^alpha)
    sum.correl.tag <- sum(correl.vector[tag.indicator == 1])
    norm.tag <- 1/sum.correl.tag
    norm.no.tag <- 1/Nm
    RES <- cumsum(tag.indicator * correl.vector * norm.tag - no.tag.indicator * norm.no.tag)
    max.ES <- max(RES)
    min.ES <- min(RES)
    if (max.ES > -min.ES) {
      # ES <- max.ES
      ES <- signif(max.ES, digits = 4)
      arg.ES <- which.max(RES)
    } else {
      # ES <- min.ES
      ES <- signif(min.ES, digits = 4)
      arg.ES <- which.min(RES)
    }
    return(list(ES = ES, arg.ES = arg.ES, RES = RES, indicator = tag.indicator))
  }
