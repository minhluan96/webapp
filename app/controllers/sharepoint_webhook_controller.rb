class SharepointWebhookController < ApplicationController
  skip_before_action :verify_authenticity_token

  def initialize_webhook
    @token = params[:validationToken]

    puts "PARAMS= #{request.parameters[:value]}"
    render :plain => @token
  end
end
