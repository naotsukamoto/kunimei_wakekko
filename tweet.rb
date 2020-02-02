require 'date'
require 'twitter'
require 'dotenv/load'
require 'countries'

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
    # 国名定義
    @c = ISO3166::Country.all
    @c_name = []
    @c.each do |country|
        @c_name << country.name
    end
  end

  # ランダムに重複ありで3つ取得


  # 各文字の区切り位置を決める


  # Tweetの投稿処理呼び出し
  def send_tweet
    create_text
    update
  end

  # ツイート本文の生成
  def create_text
    # 投稿内容を設定
    my_user = @client.user
    tc = my_user.tweets_count
    # 投稿id化
    tc += 1
    # 国名をランダムで取得
    c_name = @c_name[rand(@c_name.length)]
    # 国名を任意のところで区切る
    c_name_split = c_name.split(/\A(.{1,#{rand(c_name.length)}})/,2)[1..-1]
    # 前と後の文字を格納
    c_name_split_first = c_name_split[0]
    # 格納
    @text = "これは#{tc.to_s}回目のQuestionです。#{c_name_split_first}答えは・・・#{@c_name}です"
    # if tc % 2 == 0 then
    #     @text = "これはQuestionです:#{c_name_split_first}:#{tc.to_s}回目です"
    # else
    #     @text = "これはQuestionです:#{c_name_last}:#{tc.to_s}回目です"
    # end
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