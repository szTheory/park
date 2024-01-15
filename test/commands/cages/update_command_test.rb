require 'test_helper'

class Cages::UpdateCommandTest < ActiveSupport::TestCase
  test 'successfully updates a cage' do
    cage = Cage.create!(max_capacity: 10, power_status: 'ACTIVE')
    valid_update_params = { max_capacity: 15, power_status: 'ACTIVE' }

    result = Cages::UpdateCommand.new.update!(cage_id: cage.id, cage_params: valid_update_params)

    assert result.success?
    assert result.cage.persisted?
    assert_equal 15, result.cage.max_capacity
    assert_equal 'ACTIVE', result.cage.power_status
    assert_empty result.errors
  end

  test 'fails to update a cage with invalid parameters' do
    cage = Cage.create!(max_capacity: 10, power_status: 'ACTIVE')
    invalid_update_params = { max_capacity: 0, power_status: nil }

    result = Cages::UpdateCommand.new.update!(cage_id: cage.id, cage_params: invalid_update_params)

    refute result.success?
    assert result.cage.persisted?
    refute_empty result.errors
  end
end
