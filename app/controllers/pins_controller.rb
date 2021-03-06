class PinsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_pin, only: [:show, :edit, :update, :destroy]


  def index
    @pins = Pin.all.order("created_at ASC").paginate(:page => params[:page], :per_page => 5) # goes to the db and gets all the info and saves it to @pins variable
                    # which we use it later in index.html.erb
  end

  def show
  end

  def new
    @pin = current_user.pins.build

  end

  def edit
  end

  def create
    @pin = current_user.pins.build(pin_params)
    if @pin.save
      redirect_to @pin, notice: 'Pin was successfully created.'
    else
      render :new
    end
  end



  def update
      if @pin.update(pin_params)
        redirect_to @pin, notice: 'Pin was successfully updated.' 
      else
        render :edit
      end
  end

  def destroy
    @pin.destroy
      redirect_to pins_url, notice: 'Pin was successfully destroyed.'
      head :no_content 
  end

  private

    def set_pin
      @pin = Pin.find(params[:id])
    end

    def correct_user
    @pin = current_user.pins.find_by(id: params[:id])
    redirect_to pins_path, notice: "Not authorized to edit this pin" if @pin.nil?
    # if pin is nil it will redirect to pins path
    end

    def pin_params
      params.require(:pin).permit(:description, :image)
      # here we have to permit uploading a picture
    end
end
