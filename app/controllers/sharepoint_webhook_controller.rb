class SharepointWebhookController < ApplicationController
  skip_before_action :verify_authenticity_token

  def initialize_webhook
    @token = params[:validationtoken]

    puts "PARAMS= #{request}"
    render :plain => @token
  rescue ActionDispatch::Http::Parameters::ParseError => e
    puts "PARAMS= #{e.raw_post}"
  end
end
