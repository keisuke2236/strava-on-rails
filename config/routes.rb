Rails.application.routes.draw do
  get 'strava_login/home'
  get 'strava_login/redirect'
  root to: 'static_pages#home'
end
