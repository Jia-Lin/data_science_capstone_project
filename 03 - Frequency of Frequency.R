library(dplyr)

pm2 <- readRDS("pm2.df")
pm3 <- readRDS("pm3.df")
# remove singletons
pm2 <- pm2[which(pm2$frequency>1),]
pm3 <- pm2[which(pm3$frequency>1),]
fpm2 <- summarize(group_by(pm2, frequency), freqOFfreq = n())
fpm3 <- summarize(group_by(pm3, frequency), freqOFfreq = n())
scatter.smooth(log10(fpm3$frequency), log10(fpm3$freqOFfreq))
