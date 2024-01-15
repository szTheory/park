class Dinosaurs
  class ShowQuery
    private

    attr_reader :dinosaurs_orm

    def initialize(dinosaurs_orm: Dinosaur)
      @dinosaurs_orm = dinosaurs_orm
    end

    public

    def dinosaur(dinosaur_id:)
      dinosaurs_orm.where(id: dinosaur_id).first
    end
  end
end
