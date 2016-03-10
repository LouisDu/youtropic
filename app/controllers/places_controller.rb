class PlacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_place, only: [ :show, :edit, :update, :destroy ]

  def index
    @places = Place.all
  end

  def show
    @user = current_user
  end

  def new
    @place = Place.new
  end

  def create
    @user = current_user
    @place = @user.places.build(place_params)
    if @place.save
      flash[:notice] = "You're place has been saved."
      redirect_to @place
    else
      render :new
    end
  end

  def edit
  end

  def update
    @place.update(place_params)
    redirect_to action: 'index'
  end

  def destroy
    @place.destroy
    redirect_to places_path

  end

  private

  def place_params
    params.require(:place).permit(:name, :category_id, :capacity, :price, :street, :city, :zipcode, :country, :description, :user_id, pictures: [])
  end

  def set_place
    @place = Place.find(params[:id])
  end

end
