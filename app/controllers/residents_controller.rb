# frozen_string_literal: true

class ResidentsController < ApplicationController
  before_action :set_resident, only: %i[show edit update destroy]

  # GET /residents or /residents.json
  def index
    if params[:query].present?
      @residents = Resident.search_by_full_name(params[:query])
    else
      @residents = Resident.includes(:address).all
    end
  end

  # GET /residents/1 or /residents/1.json
  def show; end

  # GET /residents/new
  def new
    @resident = Resident.new
    @resident.build_address
  end

  # GET /residents/1/edit
  def edit; end

  # POST /residents or /residents.json
  def create
    @resident = Resident.new(resident_params)

    respond_to do |format|
      if @resident.save
        ResidentMailer.notify(@resident).deliver_now
        TwilioClient.new.send_text(@resident, 'Você foi cadastrado no sistema!')

        format.html { redirect_to resident_url(@resident), notice: 'Resident was successfully created.' }
        format.json { render :show, status: :created, location: @resident }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @resident.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_status
    @resident = Resident.find(params[:id])
    if @resident.update(resident_params)
      ResidentMailer.notify_status(@resident).deliver_now
      redirect_to residents_path, notice: 'Status atualizado com sucesso.'
    else
      redirect_to residents_path, alert: 'Falha ao atualizar o status.'
    end
  end

  # PATCH/PUT /residents/1 or /residents/1.json
  def update
    respond_to do |format|
      if @resident.update!(resident_params)
        format.html { redirect_to resident_url(@resident), notice: 'Resident was successfully updated.' }
        format.json { render :show, status: :ok, location: @resident }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @resident.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_resident
    @resident = Resident.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def resident_params
    params.require(:resident).permit(
      :full_name,
      :cpf,
      :cns,
      :email,
      :birth_date,
      :phone,
      :photo,
      :status,
      address_attributes: %i[
        zip_code
        street
        complement
        neighborhood
        city
        state
        ibge_code
      ]
    )
  end
end
