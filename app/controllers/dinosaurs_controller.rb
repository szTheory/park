class DinosaursController < ApplicationController
  def index
    dinosaurs = Dinosaurs::IndexQuery.new.dinosaurs

    if dinosaurs
      render json: dinosaurs
    else
      render json: { message: 'Cage not found' }, status: :not_found
    end
  end

  def show
    dinosaur = Dinosaurs::ShowQuery.new.dinosaur(dinosaur_id: params.fetch(:id))

    if dinosaur
      render json: dinosaur
    else
      render json: { message: 'Dinosaur not found' }, status: :not_found
    end
  end

  def create
    result = Dinosaurs::CreateCommand.new.create!(dinosaur_params:)

    if result.success?
      render json: result.dinosaur, status: :created
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  def update
    result = Dinosaurs::UpdateCommand.new.update!(dinosaur_id: params.fetch(:id), dinosaur_params:)

    if result.success?
      render json: result.dinosaur
    else
      render json: { errors: result.errors || { dinosaur: ['not found'] } }, status: :unprocessable_entity
    end
  end

  def destroy
    result = Dinosaurs::DestroyCommand.new.destroy!(dinosaur_id: params.fetch(:id))

    if result.success?
      render json: { message: 'Dinosaur deleted' }
    else
      render json: { message: 'Dinosaur not found' }, status: :not_found
    end
  end

  private

  def dinosaur_params
    params.require(:dinosaur).permit(:name, :species, :cage_id)
  end
end
