source("skSample.R")
skSample("./final/en_US/en_US.blogs.txt", "./training/en_US.blogs.txt", 0.6)
skSample("./final/en_US/en_US.news.txt", "./training/en_US.news.txt", 0.6)
skSample("./final/en_US/en_US.twitter.txt", "./training/en_US.twitter.txt", 0.6)

# tokenize and build n-grams - 
# use fast-ngrams program provided by amobodi
# https://gist.github.com/ambodi/b9d3fd69bc02b078b1ab7d180301dd29
source("fast-ngrams.R")
#blogs.txt

con <- file("./training/en_US.blogs.txt", "r") 
data <- readLines(con, encoding = 'UTF-8')
close(con)
data <- clean(data)
trigram <- text_to_ngrams(decode(data), 3)
saveRDS(trigram, "./training/trigram_blog")
rm(trigram)

# twitter.txt
con <- file("./training/en_US.twitter.txt", "r") 
data <- readLines(con, encoding = 'UTF-8')
close(con)
data <- clean(data)
trigram <- text_to_ngrams(decode(data), 3)
saveRDS(trigram, "./training/trigram_twitter")
rm(trigram)

# news.txt
con <- file("./training/en_US.news.txt", "r") 
data <- readLines(con, encoding = 'UTF-8')
close(con)
data <- clean(data)
trigram <- text_to_ngrams(decode(data), 3)
saveRDS(trigram, "./training/trigram_news")
rm(trigram)
rm(data)


