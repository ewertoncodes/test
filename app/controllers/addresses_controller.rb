class AddressesController < ApplicationController
  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)

    if @address.save
      redirect_to root_path, notice: 'Address was successfully created.'
    else
      render :new
    end
  end

  private

  def address_params
    params.require(:address).permit(:zip_code, :street, :complement, :neighborhood, :city, :state, :ibge_code)
  end
end
