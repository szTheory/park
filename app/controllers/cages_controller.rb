class CagesController < ApplicationController
  def index
    power_status = params.fetch(:power_status, nil)

    cages = Cages::IndexQuery.new.cages_index(power_status:)

    render json: cages
  end

  def show
    cage = Cages::ShowQuery.new.cage(cage_id: params.fetch(:id))

    if cage
      render json: cage
    else
      render json: { message: 'Cage not found' }, status: :not_found
    end
  end

  def create
    result = Cages::CreateCommand.new.create!(cage_params:)

    if result.success?
      render json: result.cage
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  def update
    result = Cages::UpdateCommand.new.update!(cage_id: params.fetch(:id), cage_params:)

    if result.success?
      render json: result.cage
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    Cages::DestroyCommand.new.destroy!(cage_id: params.fetch(:id))

    render json: { message: 'Cage deleted' }
  end

  private

  def cage_params
    params.require(:cage).permit(:power_status)
  end
end
