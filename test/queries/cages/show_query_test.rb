require 'test_helper'

class Cages::ShowQueryTest < ActiveSupport::TestCase
  test 'retrieves a specific cage by id' do
    cage1 = Cage.create!(max_capacity: 10, power_status: 'ACTIVE')
    Cage.create!(max_capacity: 15, power_status: 'DOWN')

    result = Cages::ShowQuery.new.cage(cage_id: cage1.id)

    assert_equal cage1, result
  end

  test 'returns nil for a non-existent cage id' do
    cage_id = 1

    result = Cages::ShowQuery.new.cage(cage_id:)

    assert_nil result
  end
end
