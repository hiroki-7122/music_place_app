# 以下のrequireは、railsの自動require機能により不要になる(!)
=begin
require 'net/http'
require 'uri'
require 'json'
=end
class StaticPagesController < ApplicationController
  def home
  @users = User.all
  @hash = Gmaps4rails.build_markers(@users) do |user, marker|
    marker.lat user.latitude
    marker.lng user.longitude
    marker.infowindow user.description
    marker.json({title: user.title})
    end
  end

  def help
  end

  def search_form
  end

  def search
    @key=params[:q]
    # hash形式でパラメタ文字列を指定し、URL形式にエンコード
    params = URI.encode_www_form({
      lang: 'ja_jp',
      entry: 'music',
      media: 'music',
      country: 'JP',
      term: "#{@key}",
      limit: 10,
    })
    # URIを解析し、hostやportをバラバラに取得できるようにする
    uri = URI.parse("https://itunes.apple.com/search?#{params}")
    # リクエストパラメタを、インスタンス変数に格納
    @query = uri.query

    https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      res = https.start {
        https.get(uri.request_uri)
      }

      if res.code == '200'
        # responseのbody要素をJSON形式で解釈し、hashに変換
        @result = JSON.parse(res.body)
        # 表示用の変数に結果を格納
        #@trackViewUrl ="url:"+@result["results"][0]["trackViewUrl"]
        #for num in 1..9 do
        #  @trackViewUrl[num] =@trackViewUrl+"url:"+@result["results"][num]["trackViewUrl"]
        #end
        #@trackName = @result["results"][0]["trackName"]
      # 別のURLに飛ばされた場合
    else
      puts "OMG!! #{res.code} #{res.message}"
    end
  end
end
