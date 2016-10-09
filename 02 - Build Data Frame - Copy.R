# 1. Process blog 
gram <- readRDS("./training/bigram_blog")
sum <- colSums(gram, na.rm = TRUE)
DF <- data.frame(feature = names(sum), frequency=sum)
gram <- readRDS("./training/trigram_blog")
sum <- colSums(gram, na.rm = TRUE)
DF <- rbind(DF, data.frame(feature = names(sum), frequency=sum))
saveRDS(DF, "./training/blog.df")

# 2. Process twitter
gram <- readRDS("./training/bigram_twitter")
sum <- colSums(gram, na.rm = TRUE)
DF <- data.frame(feature = names(sum), frequency=sum)
gram <- readRDS("./training/trigram_twitter")
sum <- colSums(gram, na.rm = TRUE)
DF <- rbind(DF, data.frame(feature = names(sum), frequency=sum))
saveRDS(DF, "./training/twitter.df")

# 3. Process news
gram <- readRDS("./training/bigram_news")
sum <- colSums(gram, na.rm = TRUE)
DF <- data.frame(feature = names(sum), frequency=sum)
gram <- readRDS("./training/trigram_news")
sum <- colSums(gram, na.rm = TRUE)
DF <- rbind(DF, data.frame(feature = names(sum), frequency=sum))
saveRDS(DF, "./training/news.df")
rm(DF)
