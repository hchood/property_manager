class BuildingsController < ApplicationController
  def index
  end

  def new
    @building = Building.new
  end

  def create
    @building = Building.new(building_params)
    if @building.save
      redirect_to new_building_path, notice: 'Successfully recorded building!'
    else
      # render 'new', notice: 'Uh oh!  We ran into some errors.'
    end
  end

  private

  def building_params
    params.require(:building).permit(:street_address, :city, :state, :zip_code, :description)
  end
end
