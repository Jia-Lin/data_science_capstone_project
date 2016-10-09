setwd("C:/Users/jialin/coursera/data science/capstone")
# setwd("C:/Users/FP003585/Downloads/Coursera/Data Science/Capstone")
# 1. Process blog 
#gram <- readRDS("./training/bigram_blog")
gram <- readRDS("./training/trigram_blog")
sum <- colSums(gram, na.rm = TRUE)
#sum <- sum[-which(is.na(names(sum)))]
DF <- data.frame(feature = names(sum), frequency=sum)
#gram <- readRDS("./training/trigram_blog")
#sum <- colSums(gram, na.rm = TRUE)
#sum <- sum[-which(is.na(names(sum)))]
#DF <- rbind(DF, data.frame(feature = names(sum), frequency=sum))
saveRDS(DF, "./training/blog.df")

# 2. Process twitter
#gram <- readRDS("./training/bigram_twitter")
gram <- readRDS("./training/trigram_twitter")
sum <- colSums(gram, na.rm = TRUE)
#sum <- sum[-which(is.na(names(sum)))]
DF <- data.frame(feature = names(sum), frequency=sum)
#gram <- readRDS("./training/trigram_twitter")
#sum <- colSums(gram, na.rm = TRUE)
#sum <- sum[-which(is.na(names(sum)))]
#DF <- rbind(DF, data.frame(feature = names(sum), frequency=sum))
saveRDS(DF, "./training/twitter.df")

# 3. Process news
#gram <- readRDS("./training/bigram_news")
gram <- readRDS("./training/trigram_news")
sum <- colSums(gram, na.rm = TRUE)
#sum <- sum[-which(is.na(names(sum)))]
DF <- data.frame(feature = names(sum), frequency=sum)
#gram <- readRDS("./training/trigram_news")
#sum <- colSums(gram, na.rm = TRUE)
#sum <- sum[-which(is.na(names(sum)))]
#DF <- rbind(DF, data.frame(feature = names(sum), frequency=sum))
saveRDS(DF, "./training/news.df")
rm(DF)
# DF$feature <- as.character(DF$feature)
# DF$feature <- trimws(DF$feature)
# DF$gram <- sapply(strsplit(DF$feature, " "),length)
# 
# # remove uni grams from data frame, the data set has 19,561,847 records
# DF <- DF[which(DF$gram > 1),]
