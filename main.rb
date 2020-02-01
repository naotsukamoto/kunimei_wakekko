require 'twitter'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "hjUd6CUD4CS512L2aU1oKBALq"
  config.consumer_secret     = "9xo3nr9iBjRBmdkvkqplJ6iTKEwqMyIfJGSLRp2EZgN0omifHr"
  config.access_token        = "1221350086048772096-BW9FBnqcWWWELRQ8LRCdTFiBqiceGW"
  config.access_token_secret = "n2oP51udT64aq0hLo7CXOFaLrLsf5r0P20vsTuzkud4oH"
end

stream_client = Twitter::Streaming::Client.new do |config|
  config.consumer_key        = "hjUd6CUD4CS512L2aU1oKBALq"
  config.consumer_secret     = "9xo3nr9iBjRBmdkvkqplJ6iTKEwqMyIfJGSLRp2EZgN0omifHr"
  config.access_token        = "1221350086048772096-BW9FBnqcWWWELRQ8LRCdTFiBqiceGW"
  config.access_token_secret = "n2oP51udT64aq0hLo7CXOFaLrLsf5r0P20vsTuzkud4oH"
end

## 投稿idの定義

### ツイート数取得
my_user = client.user
tc = my_user.tweets_count

### 投稿id化

tc += 1

## 国名をハッシュで取得

country = ISO3166::Country.new('JP')

## ランダムに重複ありで3つ取得


## 各文字の区切り位置を決める


## 呟く

if tc % 2 == 0 then

### Questionを呟く
client.update("これはQuestionです:" + country.translation(:ja) + tc.to_s + "回目です")

else

### Answerを呟く
client.update("これはAnswerです:" + tc.to_s + "回目です")

end


## refarences
# 国名取得
# https://loumo.jp/wp/archive/20170710100041/