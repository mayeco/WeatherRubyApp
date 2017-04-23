require 'unirest'

class WelcomeController < ApplicationController # :nodoc:

  @@valid_city = {
      'paris,fr': 'Paris',
      'bangkok,th': 'Bangkok',
      'santiago,cl': 'Santiago',
      'new york,ny': 'New York',
      'bamako,ml': 'Bamako',
  }

  @@aerisapi_client_id = ENV['AERISAPI_CLIENT_ID']
  @@aerisapi_client_secret = ENV['AERISAPI_CLIENT_SECRET']
  @@secret = 'client_id=' + @@aerisapi_client_id + '&client_secret=' + @@aerisapi_client_secret
  @@url_base = 'https://api.aerisapi.com/forecasts/%s?from=today&to=today&'

  def index # :nodoc:

    @weather = {}

    @@valid_city.each do |city|
      url = sprintf @@url_base + @@secret, city[0]
      response = Unirest.get url
      data = JSON.parse(response.raw_body)

      if not data['success']
        raise 'Error in request'
      end

      data = data['response']
      data = data[0]
      data = data['periods']
      data = data[0]

      @weather[city[0]] = data
    end

    @valid_city = @@valid_city

  end

  def city_weather # :nodoc:
    @city = params['city']

    if not @@valid_city.keys.include?(@city.to_sym)
      raise 'Not valid city'
    end

    url = sprintf @@url_base + @@secret, @city
    response = Unirest.get url
    data = JSON.parse(response.raw_body)

    if not data['success']
      raise 'Error in request'
    end

    data = data['response']
    data = data[0]
    data = data['periods']
    @weather = data[0]

    @valid_city = @@valid_city
  end
end
