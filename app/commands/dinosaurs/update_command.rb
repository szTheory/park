class Dinosaurs
  class UpdateCommand
    Result = Struct.new(:success?, :dinosaur, :errors, keyword_init: true)

    private

    attr_reader :dinosaurs_orm

    def initialize(dinosaurs_orm: Dinosaur)
      @dinosaurs_orm = dinosaurs_orm
    end

    public

    def update!(dinosaur_id:, dinosaur_params:)
      dinosaur = dinosaurs_orm.find(dinosaur_id)

      begin
        success = dinosaur.update(dinosaur_params)
        Result.new(success?: success, dinosaur:, errors: dinosaur.errors)
      rescue ArgumentError => e
        Result.new(success?: false, dinosaur:, errors: dinosaur.errors.full_messages << e.message)
      end
    end
  end
end
