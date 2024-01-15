class Dinosaurs
  class IndexQuery
    Filters = Struct.new(:cage_id, :species, keyword_init: true)

    private

    attr_reader :dinosaurs_orm

    def initialize(dinosaurs_orm: Dinosaur)
      @dinosaurs_orm = dinosaurs_orm
    end

    public

    def dinosaurs(filters: Filters.new)
      scope = dinosaurs_orm
      scope = scope.where(cage_id: filters.cage_id) if filters.cage_id
      scope = scope.where(species: filters.species) if filters.species

      scope.all
    end
  end
end
