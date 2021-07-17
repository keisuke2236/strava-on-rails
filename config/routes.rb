Rails.application.routes.draw do
  get 'strava_login/redirect'
  root to: 'strava_login#home'
end
