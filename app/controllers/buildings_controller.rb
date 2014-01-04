class BuildingsController < ApplicationController
  def index
    @buildings = Building.all
  end

  def new
    @building = Building.new
    @owners = Owner.all
  end

  def create
    @building = Building.new(building_params)
    if @building.save
      redirect_to new_building_path, notice: 'Successfully recorded building!'
    else
      flash[:notice] = 'Uh oh!  We ran into some errors.'
      render 'new'
    end
  end

  private

  def building_params
    params.require(:building).permit(:street_address, :city, :state, :zip_code, :description, :owner_id)
  end
end
