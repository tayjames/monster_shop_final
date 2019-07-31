class User::AddressesController < ApplicationController
  def new
    @user = current_user
    @address = Address.new
  end

  def create
    @address = current_user.addresses.new(address_params)
    if @address.save
      redirect_to profile_path
    else
      flash[:alert] = @address.errors.full_messages.join(". ")
      @user = current_user
      render :new
    end
  end

  def edit
    @user = current_user
    @address = Address.find(params[:id])
  end

  def update
    @user = current_user
    @address = Address.find(params[:id])

    if @address.shipped_orders.empty? && @address.update_attributes(address_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  def destroy
    @user = current_user
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to profile_path
    # if @address.shipped_orders.empty?
    # @address.destroy
    # else
    #   flash[:notice] = "Address can't be deleted"
    # end
  end

  private

  def address_params
    params[:address][:user_id] = current_user.id
    params.require(:address).permit(:id, :street, :city, :state, :zip, :nickname, :user_id)
  end
end
