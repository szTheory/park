class Dinosaurs
  class IndexQuery
    private

    attr_reader :dinosaurs_orm

    def initialize(dinosaurs_orm: Dinosaur)
      @dinosaurs_orm = dinosaurs_orm
    end

    public

    def dinosaurs
      dinosaurs_orm.all
    end
  end
end
