class AvailabilitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_partner, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_availability, only: %i[ show edit update destroy ]

  # GET /availabilities or /availabilities.json
  def index
    @availabilities = Availability.all
  end

  # GET /availabilities/1 or /availabilities/1.json
  def show
  end

  # GET /availabilities/new
  def new
    @availability = Availability.new
  end

  # GET /availabilities/1/edit
  def edit
  end

  # POST /availabilities or /availabilities.json
  def create
    @availability = Availability.new(availability_params)

    respond_to do |format|
      if @availability.save
        format.html { redirect_to @availability, notice: "Availability was successfully created." }
        format.json { render :show, status: :created, location: @availability }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @availability.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /availabilities/1 or /availabilities/1.json
  def update
    respond_to do |format|
      if @availability.update(availability_params)
        format.html { redirect_to @availability, notice: "Availability was successfully updated." }
        format.json { render :show, status: :ok, location: @availability }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @availability.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /availabilities/1 or /availabilities/1.json
  def destroy
    @availability.destroy!

    respond_to do |format|
      format.html { redirect_to availabilities_path, status: :see_other, notice: "Availability was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_availability
      @availability = Availability.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def availability_params
      params.expect(availability: [ :user_id, :start_time, :end_time ])
    end

    def require_partner
      unless current_user&.partner?
        redirect_to root_path, alert: "Only partners can manage availabilities."
      end
    end
end
