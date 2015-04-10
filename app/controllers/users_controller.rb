class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @pins = @user.pins.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 8)
  end
end
