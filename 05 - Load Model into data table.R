library(data.table)
f <- unzip("./training/final.zip")
DT <- fread(f, sep = ",", header = TRUE, stringsAsFactors=FALSE, nrows=-1)
setkey(DT, phrase)
