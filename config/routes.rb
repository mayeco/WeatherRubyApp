Rails.application.routes.draw do
  get '/', to: 'welcome#index', as: 'homepage'

  get '/:city', to: 'welcome#city_weather', as: 'city_weather_name'
end
