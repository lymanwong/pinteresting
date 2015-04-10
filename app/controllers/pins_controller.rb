class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @user=current_user
    @pins = Pin.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 8)
  end

  def show
    @user=current_user
  end

  def new
    @user=current_user
    @pin = current_user.pins.build
  end

  def edit
    @user=current_user
  end

  def create
    @user=current_user
    @pin = current_user.pins.build(pin_params)
    # if we are using json
    # respond_to do |format|
    #   if @pin.save
    #     format.html { redirect_to @pin, notice: 'Pin was successfully created.' }
    #     format.json { render :show, status: :created, location: @pin }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @pin.errors, status: :unprocessable_entity }
    #   end
    # end
    if @pin.save
      redirect_to @pin, notice: 'Pin was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    @user=current_user
    # if we are using json
    # respond_to do |format|
    #   if @pin.update(pin_params)
    #     format.html { redirect_to @pin, notice: 'Pin was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @pin }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @pin.errors, status: :unprocessable_entity }
    #   end
    # end
    if @pin.update(pin_params)
      redirect_to @pin, notice: 'Pin was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @user=current_user
    # if we are using json
    # @pin.destroy
    # respond_to do |format|
    #   format.html { redirect_to pins_url, notice: 'Pin was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
    @pin.destroy
    redirect_to pins_url
  end

  private

    def set_pin
      @pin = Pin.find(params[:id])
    end

    def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: "You are not authorized to edit this pin" if @pin.nil?
    end

    def pin_params
      params.require(:pin).permit(:description, :image, :image_remote_url)
    end
end
