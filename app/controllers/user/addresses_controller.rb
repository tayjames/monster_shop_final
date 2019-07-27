class User::AddressesController < ApplicationController
  def new
    @user = current_user
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to profile_path
    else
      flash[:alert] = @address.errors.full_messages.join(". ")
      @user = current_user
      render :new
    end
  end

  private
  def address_params
    params[:address][:user_id] = current_user.id
    params.require(:address).permit(:id, :street, :city, :state, :zip, :nickname, :user_id)
  end
end
