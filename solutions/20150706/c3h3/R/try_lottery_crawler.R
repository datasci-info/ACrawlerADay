library(XML)
tables <- readHTMLTable("http://www.nfd.com.tw/lottery/49-year/49-2015.htm",  stringsAsFactors = F )
dataTable <- tables[[1]]
View(dataTable)

colnames(dataTable) <- c("year","monthDay","YN","x1","x2","x3","x4","x5","x6","s","TN")

df = dataTable[,c("x1","x2","x3","x4","x5","x6","s")]
df

library(dplyr)
vec = do.call(c,as.list(df))
names(vec) = NULL
df = data.frame(x=vec)
ndf = df %>% group_by(x) %>% summarise(n=n())
barplot(ndf$n,names=ndf$x)

ndf = df %>% group_by(x) %>% summarise(n=n()) %>% arrange(desc(n))

barplot(ndf$n,names=ndf$x)
head(ndf,10)
