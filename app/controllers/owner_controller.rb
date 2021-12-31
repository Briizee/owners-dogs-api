class OwnerController < ApplicationController
    def index
        owners = Owner.includes(:dogs).order("created_at DESC")
        render json: owners, include: :dogs
    end

    def create
        owner = Owner.create(owner_param)
        render json: owner
    end

    def update
        owner = Owner.find(params[:id])
        owner.update_attributes(owner_param)
        render json: owner
    end

    def destroy
        owner = Owner.find(params[:id])
        owner.destroy
        head :no_content, status: :ok
    end

    private
    def owner_param
        params.require(:owner).permit(:first_name, :last_name, :age, :email)
    end

end
