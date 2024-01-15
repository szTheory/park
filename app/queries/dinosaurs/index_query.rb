class Dinosaurs
  class IndexQuery
    private

    attr_reader :dinosaurs_orm

    def initialize(dinosaurs_orm: Dinosaur)
      @dinosaurs_orm = dinosaurs_orm
    end

    public

    def dinosaurs(cage_id: nil)
      scope = dinosaurs_orm
      scope = scope.where(cage_id:) if cage_id.present?

      scope.all
    end
    
  end
end
