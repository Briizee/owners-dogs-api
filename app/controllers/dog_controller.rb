class DogController < ApplicationController
    def index
        dogs = Dog.includes(:owners).order("created_at DESC")
        render json: dogs, include: :owners
    end

    def show
        dog = Dog.includes(:owners).find(params[:id])
        render json: dog, include: :owners
    end

    def create
        dog = Dog.create(dog_param)
        render json: dog
    end

    def update
        dog = Dog.find(params[:id])
        dog.update_attributes(dog_param)
        render json: dog 
    end

    def destroy
        dog = Dog.find(params[:id])
        dog.destroy
        head :no_content, status: :ok
    end

    private
    def dog_param
        params.require(:dog).permit(:name, :age, :breed, :color, :sex)
    end
end
