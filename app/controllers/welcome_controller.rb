#Base del proyecto hecha con e integración con travis hecha con:
# http://theblog.unpixel.fr/2015-12-09-continuous-delivery-with-travis-and-heroku/


class WelcomeController < ApplicationController

  def buscar
    tag = params[:tag]
    access_token = params[:access_token]
    tagresponse = HHTParty.get(https://api.instagram.com/v1/tags/{tag}?access_token={access_token})
    count = tagresponse["data"]["media_count"]
    dataresponse = HTTParty.get(“https://api.instagram.com/v1/tags/{tag}/media/recent?access_token={access_token})
    data = dataresponse["data"]
    response = {:total => count}
  end


#obligar que devuelva status
#render JSON:{{json}}, status: 200
#if paramestros no estan bien 400

end
