class StravaLoginController < ApplicationController
  def home
    @authorize_url = $strava_client.authorize_url(
      redirect_uri: 'http://localhost:3000/strava_login/redirect',
      approval_prompt: 'force',
      response_type: 'code',
      scope: 'activity:read_all',
      state: 'magic'
    )
  end

  def redirect
    access_token = params[:code]
    response = $strava_client.oauth_token(code: access_token)
    response.access_token
    response.refresh_token
    response.expires_at
    response.athlete
    cookies.permanent[:access_token] = access_token
  end
end
