class SharepointWebhookController < ApplicationController
  skip_before_action :verify_authenticity_token

  def initialize_webhook
    token = params[:validationtoken]
    p "TOKEN #{token}"
    RestClient.post("https://saleshoodinc.sharepoint.com/sites/dientesting/_api/web/lists(guid'212e125c-f303-4c4d-9c96-5189de72ba41')/subscriptions", token, {"Content-Type" => "text/plain"})
  end
end
