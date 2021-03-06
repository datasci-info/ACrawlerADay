#20150705 A CRAWLER A DAY：PTT ALLTOGETHER版的女生PO文時間
#想當年宅男們在Alltogether版闖盪，往往發現適合自己的女生時，已經為時已晚，對方可能已經收到了幾百封信，甚至有些女孩子太完美了，在宅宅看到文章之前，文章早已經因為響應太過踴躍，而被作者刪除。

#目標網站：https://www.ptt.cc/bbs/AllTogether/index.html

#學習 or 複習爬技術：

#CurlSSL
#config
#GET

#### 沒把題意看清楚，只需要捉發文的時間就可以了

library(httr) # 捉網頁用
library(stringr) # 可使用正規表格法
library(dplyr)  # 整理資料 提供 sql-like 語法

# 求解順序如下
# step1 單頁資料 (只找徵男): 
#        (1) table_girl_new_article_info : 發文id, 發文時間
# step2 多頁資料
# step3 轉存SQLite:將上述資料轉存


# step1 (1) table_girl_new_article_info
res <- GET("https://www.ptt.cc/bbs/AllTogether/M.1438091156.A.8FD.html")
res <- content(res, 'text', encoding = 'utf8')
res <- htmlParse(res, encoding = 'utf8')

article_meta_value = xpathSApply(res, '//*[@class="article-meta-value"]', xmlValue)
# 以 xpath 取得 article-meta-value class 資訊 
# [1]:作者 id    [2]看板名稱
# [3]:文章標題   [4]發文時間

girl_id_nickname = article_meta_value[1] 
# 作者id且包含 nickname 

girl_id = str_extract(girl_id_nickname, "\\w+")   
# \\w 等於[a-zA-Z_0-9] 數字或是英文字,不包含空白(space)
# 只要發文者的 id，濾掉 nickname

# 文章標題中是否含有 "徵男" → 判斷發文者是女性 
girl_id_is = str_detect( article_meta_value[3]  , '徵男') 

# 確定發文者是女性時才執行以下動作，如果發文者是男性，也不用去管男性的回應如何……
if (girl_id_is)  
  
{ 
  
  table_girl_new_article_info = c( girl_id , article_meta_value[4] )
  names(table_girl_new_article_info ) = c("girl_id" , "post_time") 
  
  
}


# step2 待補