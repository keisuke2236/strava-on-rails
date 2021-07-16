class StaticPagesController < ApplicationController
  SHIRAISHI_TOUGE_ID = 633698

  def home
    client = get_strava_client
    @shiraishi_touge_efforts = client.segment_efforts(SHIRAISHI_TOUGE_ID)
    @shiraishi_profile = client.segment(SHIRAISHI_TOUGE_ID)
    segment_leaderboard = client.segment_leaderboard(SHIRAISHI_TOUGE_ID)
    @athlete = client.athlete
  end

  private

  def get_strava_client
    Strava::Api::Client.new(
      access_token: Rails.application.credentials.strava[:access_token]
    )
  end
end
