require 'test_helper'

class Dinosaurs::ShowQueryTest < ActiveSupport::TestCase
  test 'retrieves a specific dinosaur by id' do
    cage = Cage.create!(max_capacity: 10, power_status: 'ACTIVE')
    dinosaur1 = Dinosaur.create!(name: 'T-Rex', species: 'tyrannosaurus', cage:)
    Dinosaur.create!(name: 'Velociraptor', species: 'velociraptor', cage:)

    result = Dinosaurs::ShowQuery.new.dinosaur(dinosaur_id: dinosaur1.id)

    assert_equal dinosaur1, result
  end

  test 'returns nil for a non-existent dinosaur id' do
    non_existent_dinosaur_id = 1

    result = Dinosaurs::ShowQuery.new.dinosaur(dinosaur_id: non_existent_dinosaur_id)

    assert_nil result
  end
end
