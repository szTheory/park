class Cages
  class CreateCommand
    Result = Struct.new(:success?, :cage, :errors, keyword_init: true)

    private

    attr_reader :cages_orm

    def initialize(cages_orm: Cage)
      @cages_orm = cages_orm
    end

    public

    def create!(cage_params:)
      cage = cages_orm.new(cage_params)

      success = cage.save

      Result.new(success?: success, cage:, errors: cage.errors)
    end
  end
end
