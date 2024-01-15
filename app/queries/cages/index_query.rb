class Cages
  class IndexQuery
    private

    attr_reader :cages_orm

    def initialize(cages_orm: Cage)
      @cages_orm = cages_orm
    end

    public

    def cages_index(power_status: nil)
      scope = cages_orm
      scope = scope.where(power_status:) if power_status

      scope.all
    end
  end
end
