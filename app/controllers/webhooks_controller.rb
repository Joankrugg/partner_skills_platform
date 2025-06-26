class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, ENV['STRIPE_WEBHOOK_SECRET']
      )
    rescue JSON::ParserError, Stripe::SignatureVerificationError
      return head :bad_request
    end

    if event['type'] == 'checkout.session.completed'
      session = event['data']['object']
      user = User.find_by(email: session['customer_email'])
      if user
        # Activate the user's subscription
        user.create_subscription!(
          start_date: Time.current,
          end_date: 1.month.from_now,
          status: 'active'
        )
      end
    end

    head :ok
  end
end