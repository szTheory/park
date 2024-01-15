require 'test_helper'

class DinosaurTest < ActiveSupport::TestCase
  test 'dinosaurs require a name' do
    dinosaur = Dinosaur.new(name: '', species: 'tyrannosaurus')

    assert dinosaur.invalid?
    assert dinosaur.errors[:name].any?
  end

  test 'a dinosaur is an herbivore if its species is triceratops' do
    dinosaur = Dinosaur.new(name: 'Trike', species: 'triceratops')

    assert dinosaur.herbivore?
  end

  test 'a dinosaur is a carnivore if its species is tyrannosaurus' do
    dinosaur = Dinosaur.new(name: 'Rexy', species: 'tyrannosaurus')

    assert dinosaur.carnivore?
  end

  test 'carnivores can only be in a cage with dinosaurs of the same species' do
    cage = Cage.create!(power_status: 'ACTIVE', max_capacity: 1)
    Dinosaur.create!(name: 'Veloz', species: 'velociraptor', cage:)

    carnivore = Dinosaur.create(name: 'Rexy', species: 'tyrannosaurus', cage:)

    assert carnivore.invalid?
    assert carnivore.errors.full_messages.include?('Cage carnivores can only be in cage with same species')
  end

  test 'dinosaurs require a species' do
    dinosaur = Dinosaur.new(name: 'Trike', species: '')

    assert dinosaur.invalid?
    assert dinosaur.errors[:species].any?
  end

  test 'a carnivore cannot be in a cage with an herbivore' do
    cage = Cage.create!(power_status: 'ACTIVE', max_capacity: 2)
    Dinosaur.create!(name: 'Trike', species: 'triceratops', cage:)
    dinosaur = Dinosaur.new(name: 'Rexy', species: 'tyrannosaurus', cage:)

    assert dinosaur.invalid?
    assert dinosaur.errors.full_messages.include?('Cage carnivores cannot be in same cage as herbivores')
  end

  test 'carnivore species' do
    Dinosaur::CARNIVORES.each do |carnivore|
      dinosaur = Dinosaur.new(name: 'Rexy', species: carnivore)

      assert dinosaur.carnivore?
    end
  end

  test 'herbivore species' do
    Dinosaur::HERBIVORES.each do |herbivore|
      dinosaur = Dinosaur.new(name: 'Trike', species: herbivore)

      assert dinosaur.herbivore?
    end
  end
end
