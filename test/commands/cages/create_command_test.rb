require 'test_helper'

class Cages::CreateCommandTest < ActiveSupport::TestCase
  test 'successfully creates a cage' do
    cage_params = { max_capacity: 10, power_status: 'ACTIVE' }

    result = Cages::CreateCommand.new.create!(cage_params:)

    assert result.success?
    assert result.cage.persisted?
    assert_empty result.errors
  end

  test 'fails to create a cage with invalid parameters' do
    cage_params = { max_capacity: 10, power_status: nil }

    result = Cages::CreateCommand.new.create!(cage_params:)

    refute result.success?
    refute result.cage.persisted?
    refute_empty result.errors
  end
end
