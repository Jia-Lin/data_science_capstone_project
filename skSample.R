skSample <- function(inputFile, outputFile, prob, phrase=NULL) {
  if (!file.exists(inputFile)) {
    return(FALSE)
  }
  
  if (file.exists(outputFile)) {
    file.remove(outputFile)
  }
  
  inputCon <- file(inputFile, open="r")
  outputCon <- file(outputFile, open="w")
  while (TRUE) {
    line1 <- tolower(readLines(inputCon, n=1))
    if (length(line1) == 0) {
      break
    }
    if (!is.null(phrase)) {
      if (regexpr(phrase, line1) <= 0) {
        next
      }
    }
    if (rbinom(1, 2, prob)) {
      s_line <- line1
      if (!is.null(phrase)) {
        sens <- strsplit(line1, split=",|[.]|:|[?]|!)")
        s_line <- ""
        for (sen in sens[[1]]) {
          if (regexpr(phrase, sen) > 0) {
            s_line <- paste(s_line, sen, sep=".")
          }
        } 
      }
       writeLines(s_line, outputCon) 
      #writeLines(line1, outputCon)    
       
    }
  }
  close(inputCon)
  close(outputCon)
}