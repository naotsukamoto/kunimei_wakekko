require 'date'
require 'twitter'
require 'dotenv/load'
require 'countries'

class Tweet

  def initialize
    # 投稿内容の初期化
    @text = ""
    # 投稿内容(タグ)
    @text_tag = "#国名わけっこゲーム #ジャルジャル #M1 #日本語ver"
    # クライアントの生成
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SECRET']
      config.access_token        = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end
    ## 日本語変換
    ISO3166.configure do |config|
      config.locales = [:en, :de, :fr, :es, :ja]
    end
    # 国名取得
    @c = ISO3166::Country.all
    @c_one = @c[rand(@c.length)]
    @c_name = @c_one.translations['ja']
    # 文字数が短いときは国名を変更  
    while @c_name.length < 4
      @c_one = @c[rand(@c.length)]
      @c_name = @c_one.translations['ja']
    end
  end

  # Tweetの投稿処理呼び出し
  def send_tweet
    creat_content
    create_text
    update
    # sleep(300)
    create_text2
    update2
  end

  # 国名生成
  def creat_content
    # 投稿内容を設定
    my_user = @client.user
    @tc = my_user.tweets_count
    @tc +=1
    # 国名を任意のところで区切る
    c_name_split = @c_name.split(/\A(.{2,#{rand(@c_name.length)}})/,2)[1..-1]
    # 前と後の文字を格納
    @c_name_split_first = c_name_split[0]
    @c_name_split_last = c_name_split[1]
  end

  # ツイート本文の生成
  def create_text
    # # 投稿内容を設定
    # my_user = @client.user
    # tc = my_user.tweets_count
    # # 投稿id化
    # tc += 1
    # # 国名をランダムで取得
    # c_name = @c_name[rand(@c_name.length)]
    # # 国名を任意のところで区切る
    # c_name_split = c_name.split(/\A(.{1,#{rand(c_name.length)}})/,2)[1..-1]
    # # 前と後の文字を格納
    # c_name_split_first = c_name_split[0]
    # c_name_split_last = c_name_split[1]
    # 格納
    @text = "##{@tc.to_s} Ques.\n#{@c_name_split_first}\n#{@text_tag}"
    # if tc % 2 == 0 then
    #     @text = "これはQuestionです:#{c_name_split_first}:#{tc.to_s}回目です"
    # else
    #     @text = "これはQuestionです:#{c_name_last}:#{tc.to_s}回目です"
    # end
  end

  def create_text2
    # 格納
    @text2 = "##{@tc.to_s} Ans.\n#{@c_name_split_last}\nFull:#{@c_name} #{@c_one.emoji_flag}\n#{@text_tag}"
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
  def update2
    begin 
      @client.update(@text2)
    rescue => e
      p e # エラー時はログを出力
    end
  end
end


# ツイートを実行
if __FILE__ == $0
  Tweet.new.send_tweet
end