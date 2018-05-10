class SharepointWebhookController < ApplicationController
  skip_before_action :verify_authenticity_token

  def initialize_webhook
    @token = params[:validationtoken]
    render :plain => @token
  end
end
