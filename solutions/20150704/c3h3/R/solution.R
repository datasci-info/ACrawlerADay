library(httr)
token = ""
data_url = sprintf("https://graph.facebook.com/v2.3/485470714811419/feed?limit=100&access_token=%s",token)

res = GET(data_url)
res_con = content(res)
res_con$data

content(res,"text")

content(res,"raw")
