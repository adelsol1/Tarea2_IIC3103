#Base del proyecto hecha con e integración con travis hecha con:
# http://theblog.unpixel.fr/2015-12-09-continuous-delivery-with-travis-and-heroku/

class WelcomeController < ApplicationController

  def buscar

    if ((params[:tag]!="")&&(params[:access_token]!=""))
      tagresponse =HTTParty.get('https://api.instagram.com/v1/tags/' + params[:tag]+ '?access_token=' + params[:access_token])
      count = tagresponse["data"]["media_count"]
      dataresponse = HTTParty.get('https://api.instagram.com/v1/tags/'+ params[:tag]+ '/media/recent?access_token=' + params[:access_token] + '&count=20')
      data = dataresponse["data"]
      response = Array[]

      data.each do |var|
        if  (var["standard_resolution"])
          resulution = var["standard_resolution"]
        else
          if (var["low_resolution"])
            resolution = var["low_resolution"]
          else
            resolution = var["thumbnail"]
          end
        end
        response << { :tags => var["tags"], :likes => var["likes"]["count"], :url => resolution, :caption => var["caption"]["text"]}
      end
      finalresponse = {:metadata => {:total =>count}, :posts => response, :version => "1.0.0"}
      render :json => finalresponse, status: 200

    else
      render status: 400
    end
  end

#obligar que devuelva status
#render JSON:{{json}}, status: 200
#if paramestros no estan bien 400
end
