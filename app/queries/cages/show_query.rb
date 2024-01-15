class Cages
  class ShowQuery
    private

    attr_reader :cages_orm

    def initialize(cages_orm: Cage)
      @cages_orm = cages_orm
    end

    public

    def cage(cage_id:)
      cages_orm.where(id: cage_id).first
    end
  end
end
