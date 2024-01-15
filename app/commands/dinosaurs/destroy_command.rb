class Dinosaurs
  class DestroyCommand
    Result = Struct.new(:success?, keyword_init: true)

    private

    attr_reader :dinosaurs_orm

    def initialize(dinosaurs_orm: Dinosaur)
      @dinosaurs_orm = dinosaurs_orm
    end

    public

    def destroy!(dinosaur_id:)
      dinosaur = dinosaurs_orm.where(id: dinosaur_id).first
      return Result.new(success?: false) unless dinosaur

      success = dinosaur.destroy

      Result.new(success?: success)
    end
  end
end
