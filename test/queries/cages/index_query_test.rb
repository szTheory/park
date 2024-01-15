require 'test_helper'

class Cages::IndexQueryTest < ActiveSupport::TestCase
  test 'retrieves all cages' do
    cage1 = Cage.create!(max_capacity: 10, power_status: 'ACTIVE')
    cage2 = Cage.create!(max_capacity: 15, power_status: 'DOWN')
    cage3 = Cage.create!(max_capacity: 20, power_status: 'ACTIVE')

    result = Cages::IndexQuery.new.cages_index

    assert_includes result, cage1
    assert_includes result, cage2
    assert_includes result, cage3
    assert_equal Cage.count, result.size
  end
end
