require 'test_helper'

class Dinosaurs::IndexQueryTest < ActiveSupport::TestCase
  test 'retrieves all dinosaurs' do
    cage1 = Cage.create!(max_capacity: 10, power_status: 'ACTIVE')
    cage2 = Cage.create!(max_capacity: 15, power_status: 'ACTIVE')
    dinosaur1 = Dinosaur.create!(name: 'Dino1', species: 'tyrannosaurus', cage_id: cage1.id)
    dinosaur2 = Dinosaur.create!(name: 'Dino2', species: 'tyrannosaurus', cage_id: cage2.id)
    dinosaur3 = Dinosaur.create!(name: 'Dino3', species: 'tyrannosaurus', cage_id: cage2.id)

    result = Dinosaurs::IndexQuery.new.dinosaurs

    assert_includes result, dinosaur1
    assert_includes result, dinosaur2
    assert_includes result, dinosaur3
  end
end
