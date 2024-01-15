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

  test 'filters by cage' do
    cage1 = Cage.create!(max_capacity: 10, power_status: 'ACTIVE')
    cage2 = Cage.create!(max_capacity: 15, power_status: 'ACTIVE')
    dinosaur1 = Dinosaur.create!(name: 'Dino1', species: 'tyrannosaurus', cage_id: cage1.id)
    Dinosaur.create!(name: 'Dino2', species: 'tyrannosaurus', cage_id: cage2.id)
    Dinosaur.create!(name: 'Dino3', species: 'tyrannosaurus', cage_id: cage2.id)

    filters = Dinosaurs::IndexQuery::Filters.new(cage_id: cage1.id)
    result = Dinosaurs::IndexQuery.new.dinosaurs(filters:)

    assert_equal [dinosaur1], result
  end

  test 'filters by species' do
    cage1 = Cage.create!(max_capacity: 10, power_status: 'ACTIVE')
    cage2 = Cage.create!(max_capacity: 15, power_status: 'ACTIVE')
    dinosaur_species1 = Dinosaur.create!(name: 'Dino1', species: 'brachiosaurus', cage_id: cage1.id)
    dinosaur_species2 = Dinosaur.create!(name: 'Dino2', species: 'ankylosaurus', cage_id: cage2.id)

    filters = Dinosaurs::IndexQuery::Filters.new(species: dinosaur_species1.species)
    result = Dinosaurs::IndexQuery.new.dinosaurs(filters:)

    assert_equal [dinosaur_species1], result
  end

  test 'filters by cage and species' do
    cage1 = Cage.create!(max_capacity: 10, power_status: 'ACTIVE')
    cage2 = Cage.create!(max_capacity: 15, power_status: 'ACTIVE')
    dinosaur1 = Dinosaur.create!(name: 'Dino1', species: 'triceratops', cage_id: cage1.id)
    Dinosaur.create!(name: 'Dino2', species: 'stegosaurus', cage_id: cage2.id)
    Dinosaur.create!(name: 'Dino3', species: 'triceratops', cage_id: cage2.id)

    filters = Dinosaurs::IndexQuery::Filters.new(cage_id: cage1.id, species: 'triceratops')
    result = Dinosaurs::IndexQuery.new.dinosaurs(filters:)

    assert_equal [dinosaur1], result
  end
end
