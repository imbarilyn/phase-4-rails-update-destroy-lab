class PlantsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :response_not_found

  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = find_plant
    render json: plant
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end

  def update
    plant = find_plant
    plant.update(plant_params)
      render json: plant
    # rescue ActiveRecord::RecordNotFound
    #   response_not_found
  end

  def destroy
    plant = find_plant
    plant.destroy
      head :no_content
  # rescue ActiveRecord::RecordNotFound
  #     response_not_found
end

  private
   
  def response_not_found
    render json: {error: "plant not found"}, status: 404
  end

  def find_plant
    Plant.find(params[:id])
  end



  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end
end
