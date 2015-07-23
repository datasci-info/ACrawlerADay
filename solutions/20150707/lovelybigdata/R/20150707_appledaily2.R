# 完全不熟 Git 請多指教 … 謝謝
#20150707 A CRAWLER A DAY：蘋果即時新聞表列
# Web Site: http://www.appledaily.com.tw/realtimenews/section/new/
 
library(httr)

res = GET("http://www.appledaily.com.tw/realtimenews/section/new/")
# This site : GET method / No javascript: Data in Documents tab / CSS Selector
 
node = htmlParse(content(res, "text", encoding = "utf8"))


library(CSS) 

#儲存資料結構：
#文章 url --
#文章 title --
#發文時間 --
  
## Data Parser ############

Apple_Data = list()

# link
Apple_Data$Link = cssApply(node,"#maincontent > div.thoracis > div.abdominis.rlby.clearmen > ul > li > a",cssLink)
# Addd origin url 
Apple_Data$Link  = paste("http://www.appledaily.com.tw" , Apple_Data$Link  ,sep='')


# Time 
Apple_Data$Time = cssApply(node,"#maincontent > div.thoracis > div.abdominis.rlby.clearmen > ul > li > a > time",cssCharacter)

# Title
Apple_Data$Title = cssApply(node,"#maincontent > div.thoracis > div.abdominis.rlby.clearmen > ul > li:nth-child(1) > a > h1",cssCharacter)

# List to data.frame
Apple_df = data.frame(Apple_Data)

#Check again
View(Apple_df)
