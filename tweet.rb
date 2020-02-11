require 'date'
require 'twitter'
require 'dotenv/load'
require 'countries'

class Tweet

  def initialize
    # 投稿内容の初期化
    @text = ""
    # 投稿内容(タグ)
    # @text_tag = "#国名わけっこゲーム #ジャルジャル #M1 #日本語ver"
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
    # @c_one = @c[rand(@c.length)]
    # 複数の国名取得and日本語に変更
    @c_select =  []
    3.times do |n|
      @c_select << @c[rand(@c.length)]
      @c_select_name = @c_select.map{|s| s.translations['ja']}
    end
    # 文字数が短いときは国名を変更  
    3.times do |x|
      while @c_select_name[x].length < 4
        @c_select[x] = @c[rand(@c.length)]
        @c_select_name[x] = @c_select[x].translations['ja']
      end
    end
    
    # @c_name = @c_one.translations['ja']
    # # 文字数が短いときは国名を変更  
    # while @c_name.length < 4
    #   @c_one = @c[rand(@c.length)]
    #   @c_name = @c_one.translations['ja']
    # end

    # 投稿内容(タグ)
    @text_tag1 = "#国名わけっこゲーム #ジャルジャル #M1"
    @text_tag2 = "#国名わけっこゲーム #ジャルジャル #M1 ##{@c_select_name[0]} ##{@c_select_name[1]} ##{@c_select_name[2]}"
  end

  # Tweetの投稿処理呼び出し
  def send_tweet
    creat_content
    create_text
    update
    # 10分後に答えをツイートする
    sleep(600)
    create_text2
    update2
  end

  # 国名生成
  def creat_content
    # 投稿内容を設定
    my_user = @client.user
    @tc = my_user.tweets_count
    @tc = @tc/2 + 1
    # 3つの国名を任意のところで区切る
    min = @c_select_name.map(&:length).min - 2
    @c_select_name_split = []
    @c_select_name.each do |s|
      @c_select_name_split << s.split(/\A(.{2,#{min}})/,2)[1..-1]
    end
    # @c_select_name_split = @c_select_name.map{|n| n.split(/\A(.{2,#{min}})/,2)[1..-1]}
    # # 国名を任意のところで区切る
    # c_name_split = @c_name.split(/\A(.{2,#{rand(@c_name.length)}})/,2)[1..-1]
    # # 前と後の文字を格納
    # @c_name_split_first = c_name_split[0]
    # @c_name_split_last = c_name_split[1]
  end

  # ツイート本文の生成
  def create_text
    # # 国名をランダムで取得
    # c_name = @c_name[rand(@c_name.length)]
    # # 国名を任意のところで区切る
    # c_name_split = c_name.split(/\A(.{1,#{rand(c_name.length)}})/,2)[1..-1]
    # # 前と後の文字を格納
    # c_name_split_first = c_name_split[0]
    # c_name_split_last = c_name_split[1]
    # # 格納
    # @text = "#{@c_name_split_first}\n#{@text_tag}"
    @text = "##{@tc.to_s} Q.\n#{@c_select_name_split[0][0]}#{@c_select_name_split[1][0]}#{@c_select_name_split[2][0]}\n#{@text_tag1}"
  end

  def create_text2
    # # 格納
    # @tc +=1
    # @text2 = "#{@c_name_split_last}\nFull:#{@c_name} #{@c_one.emoji_flag}\n#{@text_tag}"
    @text2 = "##{@tc.to_s} A.\n#{@c_select_name_split[0][1]}#{@c_select_name_split[1][1]}#{@c_select_name_split[2][1]}\nFULL:#{@c_select_name[0]}/#{@c_select_name[1]}/#{@c_select_name[2]}\n#{@text_tag2}"
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