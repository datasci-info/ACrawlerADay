library(XML)
tables <- readHTMLTable("http://www.nfd.com.tw/lottery/49-year/49-2015.htm")
dataTable <- tables[[1]]
View(dataTable)

colnames(dataTable) <- c("year","monthDay","YN","x1","x2","x3","x4","x5","x6","s","TN")

df = dataTable[,c("x1","x2","x3","x4","x5","x6","s")]
df
