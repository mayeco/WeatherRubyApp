require 'unirest'

module ApplicationHelper # :nodoc:

  @@aerisapi_client_id = ENV['AERISAPI_CLIENT_ID']
  @@aerisapi_client_secret = ENV['AERISAPI_CLIENT_SECRET']
  @@secret = 'client_id=' + @@aerisapi_client_id + '&client_secret=' + @@aerisapi_client_secret
  @@url_base = 'https://api.aerisapi.com/forecasts/%s?from=today&to=today&'

  module_function

  def cityweather(city)
    url = format @@url_base + @@secret, city
    begin
      response = Unirest.get url
    rescue => ex
      return false
    end

    data = JSON.parse(response.raw_body)
    return false unless data['success']
    data = data['response']
    data = data[0]
    data = data['periods']
    data[0]
  end
end
