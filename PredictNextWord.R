PredictNextWord <- function(phr) {
  words <- strsplit(phr, " ")
  if (length(words[[1]]) != 2) {
    print("please enter exactly two words separated by space")
    return(NULL)
  }
  # s <- grep(phrase, dbFetch(final_hash, "phrase"))
  df <- DT[phrase == phr, ]
  s <- dim(df)[1]
  if (s == 0 ) {
    #s <- grep(words[[1]][2], dbFetch(final_hash, "phrase"))
    df <- DT[phrase == words[[1]][2], ]
    s <- dim(df)[1]
    if (s == 0 ) {
    print( "Can't find next word")
    return(NULL)
    }
  }
  
  gt <- summarize(group_by(df, frequency), freqOFfreq = n())
  gt <- gt[order(gt$frequency),]
  d <- data.frame(count = 1:max(gt$frequency))
  gt <- merge(d, gt, by.x = "count", by.y = "frequency", all.x = TRUE, all.y=TRUE)
  gt <- transform(gt, freqOFfreq = ifelse(is.na(freqOFfreq), 0, freqOFfreq))
  # get N and N1
  N <- 0
  Nr1 <- 0
  for (i in 1:max(gt$count)) {
    if (Nr1 == 0 & gt[i, ]$freqOFfreq > 0 ) {
      Nr1 <- gt[i, ]$freqOFfreq
    }
    N <- N + gt[i,]$freqOFfreq * gt[i,]$count
  }
  #set k = 5
  k <- 5
  c <- NULL
  p<- NULL
  
  for (i in 1:max(gt[,1])) {
    # if (i == 0) {
    #   p[i] <- fpm[1,]$freqOFfreq
    # }
    Nri <- gt[i, ]$freqOFfreq
    Nrip <- gt[i+1, ]$freqOFfreq
    Nrkp <- gt[k+1, ]$freqOFfreq
    if (i > k | i == max(gt[,1])) {
      c[i] <- Nri
    } else {
      if (Nri != 0) {
        c[i] <- ((i+1)*(Nrip/Nri)-(i*(k+1)*Nrkp/Nr1)) / (1 - ((k+1)*Nrkp/Nr1))  
      } else {
        c[i] <- 0
      }
    }
    p[i] <- c[i] / N
  }
  g <- cbind(gt, c, p)
  df <- merge(df, g, by.x = "frequency", by.y = "count", all.x = TRUE)
  df <- df[order(-df$p),]
  return(df$last_word[1:3])
}
