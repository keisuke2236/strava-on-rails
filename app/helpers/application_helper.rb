module ApplicationHelper
  def strava_client
    return $strava_client if $strava_client.present?

    $strava_client = Strava::OAuth::Client.new(
      client_id: Rails.application.credentials.strava[:client_id],
      client_secret: Rails.application.credentials.strava[:client_seed]
    )
  end
end
