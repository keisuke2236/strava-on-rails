class StaticPagesController < ApplicationController
  SHIRAISHI_TOUGE_ID = 633698

  def home
    client = get_strava_client
    @shiraishi_touge_efforts = client.segment_efforts(SHIRAISHI_TOUGE_ID)
    @shiraishi_profile = client.segment(SHIRAISHI_TOUGE_ID)
    @athlete = client.athlete

    @shiraishi_count = client.segment_efforts(SHIRAISHI_TOUGE_ID, per_page: 100).count

    if client.segment_efforts(SHIRAISHI_TOUGE_ID, per_page: 100).count >= 100
      @shiraishi_100 = true
    end
  end

  private

  def get_strava_client
    Strava::Api::Client.new(
      access_token: Rails.application.credentials.strava[:access_token]
    )
  end
end
