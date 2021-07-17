class StravaLoginController < ApplicationController
  SHIRAISHI_TOUGE_ID = 633698

  def home
    url = 'https://frozen-bastion-61341.herokuapp.com/redirect'
    url = 'http://localhost:3000/strava_login/redirect' if Rails.env.development?
    @authorize_url = strava_client.authorize_url(
      redirect_uri: 'http://localhost:3000/strava_login/redirect',
      approval_prompt: 'force',
      response_type: 'code',
      scope: 'activity:read_all',
      state: 'magic'
    )
  end

  def redirect
    access_token = params[:code]
    response = strava_client.oauth_token(code: access_token)
    cookies.permanent[:access_token] = response.access_token

    # ログインしたユーザーで strava_client を取得
    user_client = strava_user_client(response.access_token)

    @shiraishi_touge_efforts = user_client.segment_efforts(SHIRAISHI_TOUGE_ID)
    @shiraishi_profile = user_client.segment(SHIRAISHI_TOUGE_ID)
    @athlete = user_client.athlete

    @shiraishi_count = user_client.segment_efforts(SHIRAISHI_TOUGE_ID, per_page: 100).count

    if user_client.segment_efforts(SHIRAISHI_TOUGE_ID, per_page: 100).count >= 100
      @shiraishi_100 = true
    end

  end

  private

  def strava_client
    return $strava_client if $strava_client.present?

    $strava_client = Strava::OAuth::Client.new(
      client_id: Rails.application.credentials.strava[:client_id],
      client_secret: Rails.application.credentials.strava[:client_seed]
    )
  end

  def strava_user_client(access_token)
    Strava::Api::Client.new(access_token: access_token)
  end
end
