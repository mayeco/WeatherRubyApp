class WelcomeController < ApplicationController # :nodoc:
  def index # :nodoc:
    require 'unirest'

    @welcome = 'hello world'.to_s

    data = Unirest.get'https://httpbin.org/get'

    @response = JSON.parse(data.raw_body)

  end
end
