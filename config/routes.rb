Rails.application.routes.draw do
  get '/', to: 'weather#index', as: 'homepage'
  get '/:city', to: 'weather#city_weather', as: 'city_weather_name'
end
