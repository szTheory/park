class Cages
  class DestroyCommand
    Result = Struct.new(:success?, keyword_init: true)

    private

    attr_reader :cages_orm

    def initialize(cages_orm: Cage)
      @cages_orm = cages_orm
    end

    public

    def destroy!(cage_id:)
      cage = cages_orm.where(id: cage_id).first
      return Result.new(success?: false) unless cage

      success = cage.destroy

      Result.new(success?: success)
    end
  end
end
