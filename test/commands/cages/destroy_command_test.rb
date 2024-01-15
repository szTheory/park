require 'test_helper'

class Cages::DestroyCommandTest < ActiveSupport::TestCase
  test 'successfully destroys a cage' do
    cage = Cage.create!(power_status: 'ACTIVE')

    result = Cages::DestroyCommand.new.destroy!(cage_id: cage.id)

    assert result.success?
  end

  test 'handles non-existent cage gracefully' do
    result = Cages::DestroyCommand.new.destroy!(cage_id: 1)

    refute result.success?
  end
end
