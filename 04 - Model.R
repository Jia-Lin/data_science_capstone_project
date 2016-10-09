library(data.table)
model <- readRDS("./training/blog.df")
model$feature <- trimws(as.character(model$feature))
model$gram <- sapply(strsplit(model$feature, " "),length)
model <- model[which(model$gram > 1),]
model2 <- readRDS("./training/twitter.df")
model2$feature <- trimws(as.character(model2$feature))
model2$gram <- sapply(strsplit(model2$feature, " "),length)
model2 <- model2[which(model2$gram > 1),]
model3 <- readRDS("./training/news.df")
model3$feature <- trimws(as.character(model3$feature))
model3$gram <- sapply(strsplit(model3$feature, " "),length)
model <- rbind(model, model2, model3)
rm(model2)
rm(model3)
saveRDS(model, "./training/model")


object.size(model)
# remove 1-gram features, it is 2,792,705,512 bytes; 21,258,709 tokens.

dim(model) #it is 2,696,771,736 bytes; 20,308,946 tokens.

library(dplyr)
# As the trigrams were generated separately by blogs, twitters and news, there are many duplicates. 
# Code below is to group all of them and sum up the frequency.
g <- group_by(model, feature, gram)
rm(model)
model <- summarize(g, sum(frequency))
object.size(model) # it is 3,655,670,208 bytes
dim(model) # 42,442,944 entries
saveRDS(model, "./training/model")
setDT(model)
model2 <- model[which(model$gram == 2),] #  9,566,527 tokens.
model3 <- model[which(model$gram == 3),] # 10,742,419 tokens.
rm(model)
model2 <- mutate(model2, last_word = sapply(strsplit(feature, split=" "),function(x) (x[2])))
model3 <- mutate(model3, last_word = sapply(strsplit(feature, split=" "),function(x) (x[3])))
model <- rbind(model2, model3)
rm(model2)
rm(model3)
model$phrase <- gsub("\\s(\\w+)$", "", model$feature)
saveRDS(model, "./training/model")
final_model <- model[,c(3, 5, 4, 2)] 
rm(model)
saveRDS(final_model, "./training/final_model.DF")
write.csv(final_model, "./training/final_model.csv")
# the data frame has 20,308,946 tokens
# remove singletons,
rm(final_model)
#final <- read.csv("./training/final_model.csv") # 42,363,505
final <- fread("./training/final_model.csv", sep = ",", header = TRUE, stringsAsFactors=FALSE, nrows=-1)
names(final)[2] <- "frequency"
final <- final[, !"V1", with = FALSE]
final <- final[which(final$frequency > 1),]
dim(final)
# it has 4,387,392 entries now.
write.csv(final, "./training/final.csv")
rm(final)
