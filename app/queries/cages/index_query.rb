class Cages
  class IndexQuery
    private

    attr_reader :cages_orm

    def initialize(cages_orm: Cage)
      @cages_orm = cages_orm
    end

    public

    def cages_index
      cages_orm.all
    end
  end
end
