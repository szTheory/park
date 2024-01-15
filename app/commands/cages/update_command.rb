class Cages
  class UpdateCommand
    Result = Struct.new(:success?, :cage, :errors, keyword_init: true)

    private

    attr_reader :cages_orm

    def initialize(cages_orm: Cage)
      @cages_orm = cages_orm
    end

    public

    def update!(cage_id:, cage_params:)
      cage = cages_orm.find(cage_id)

      success = cage.update(cage_params)

      Result.new(success?: success, cage:, errors: cage.errors)
    end
  end
end
