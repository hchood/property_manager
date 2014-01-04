class OwnersController < ApplicationController
  def index
    @owners = Owner.all
  end

  def new
    @owner = Owner.new
  end

  def create
    @owner = Owner.new(owner_params)
    if @owner.save
      redirect_to new_owner_path, notice: 'Successfully recorded owner!'
    else
      flash[:notice] = 'Uh oh!  We encountered a problem.'
      render 'new'
    end
  end

  def destroy
    @owner = Owner.find(params[:id])
    if @owner.destroy
      redirect_to owners_path, notice: 'Owner deleted.'
    else
      flash[:notice] = 'Uh oh!  We encountered a problem.'
      render 'index'
    end
  end

  private

  def owner_params
    params.require(:owner).permit(:first_name, :last_name, :email, :company)
  end
end
