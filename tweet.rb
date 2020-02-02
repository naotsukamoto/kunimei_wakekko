require 'date'
require 'twitter'
require 'dotenv/load'

class Tweet

  def initialize
    # 投稿内容の初期化
    @text = ""
    # クライアントの生成
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SECRET']
      config.access_token        = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end
  end

  ## 投稿idの定義

  ### ツイート数取得
  
  my_user = client.user
  @tc = my_user.tweets_count

  ### 投稿id化

  @tc += 1 

  ## 国名をハッシュで取得

#   country = ISO3166::Country.new('JP')

  ## ランダムに重複ありで3つ取得


  ## 各文字の区切り位置を決める




  # Tweetの投稿処理呼び出し
  def send_tweet
    create_text
    update
  end

  # ツイート本文の生成
  def create_text
    # 投稿内容を設定
    if @tc % 2 == 0 then
        @text = "これはQuestionです:" + country.translation(:ja) + tc.to_s + "回目です"
    else
        @text = "これはAnswerです:" + tc.to_s + "回目です"
    end
  end

  private

  # Tweet投稿処理
  def update
    begin 
      @client.update(@text)
    rescue => e
      p e # エラー時はログを出力
    end
  end
end

# ツイートを実行
if __FILE__ == $0
  Tweet.new.send_tweet
end