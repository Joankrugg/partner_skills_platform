class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_client, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_subscription, only: %i[ show edit update destroy ]

  # GET /subscriptions or /subscriptions.json
  def index
    @subscriptions = Subscription.all
    @subscription = current_user.subscription
  end

  # GET /subscriptions/1 or /subscriptions/1.json
  def show
  end

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
  end

  # GET /subscriptions/1/edit
  def edit
  end

  # POST /subscriptions or /subscriptions.json
  def create
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'eur',
          product_data: { name: 'Monthly Subscription' },
          unit_amount: 1000, # €10.00
          recurring: { interval: 'month' }
        },
        quantity: 1
      }],
      mode: 'subscription',
      success_url: subscriptions_url + '?success=true',
      cancel_url: subscriptions_url + '?canceled=true',
      customer_email: current_user.email
    )
    redirect_to session.url, allow_other_host: true
  end

  # PATCH/PUT /subscriptions/1 or /subscriptions/1.json
  def update
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_to @subscription, notice: "Subscription was successfully updated." }
        format.json { render :show, status: :ok, location: @subscription }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1 or /subscriptions/1.json
  def destroy
    @subscription.destroy!

    respond_to do |format|
      format.html { redirect_to subscriptions_path, status: :see_other, notice: "Subscription was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def subscription_params
      params.expect(subscription: [ :user_id, :start_date, :end_date, :status ])
    end
    def require_client
      unless current_user&.client?
        redirect_to root_path, alert: "Only clients can manage subscriptions."
      end
    end
end
