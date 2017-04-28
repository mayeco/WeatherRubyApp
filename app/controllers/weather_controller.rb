require 'application_helper'

class WeatherController < ApplicationController # :nodoc:

  @@valid_cities = {
      'paris,fr': 'Paris',
      'bangkok,th': 'Bangkok',
      'santiago,cl': 'Santiago',
      'new york,ny': 'New York',
      'bamako,ml': 'Bamako',
  }

  def index # :nodoc:
    @weather = {}

    @@valid_cities.each do |city|
      @weather[city[0]] = ApplicationHelper.cityweather city[0]
      unless @weather[city[0]]
        raise 'Failed to request "' + city[0] + '" weather'
      end
    end

    @valid_cities = @@valid_cities
  end

  def city_weather # :nodoc:
    @city = params['city']

    unless @@valid_cities.keys.include?(@city.to_sym)
      raise 'Not valid city'
    end

    @weather = ApplicationHelper.cityweather @city
    unless @weather
      raise 'Failed to request "' + @city + '" weather'
    end

    @valid_cities = @@valid_cities
  end
end
