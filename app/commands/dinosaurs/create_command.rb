class Dinosaurs
  class CreateCommand
    Result = Struct.new(:success?, :dinosaur, :errors, keyword_init: true)

    private

    attr_reader :dinosaurs_orm

    def initialize(dinosaurs_orm: Dinosaur)
      @dinosaurs_orm = dinosaurs_orm
    end

    public

    def create!(dinosaur_params:)
      dinosaur = dinosaurs_orm.create(dinosaur_params)

      Result.new(
        success?: dinosaur.errors.blank?,
        dinosaur:,
        errors: dinosaur.errors
      )
    rescue ArgumentError => e
      Result.new(
        success?: false,
        dinosaur: nil,
        errors: [e.message]
      )
    end
  end
end
