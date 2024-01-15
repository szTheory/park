require 'test_helper'

class CagesTest < ActiveSupport::TestCase
  test 'cages have a maximum capacity' do
    cage = Cage.create!(max_capacity: 1, power_status: 'ACTIVE')

    Dinosaur.create!(name: 'Trike', species: 'triceratops', cage_id: cage.id)
    assert_raises(ActiveRecord::RecordInvalid) do
      Dinosaur.create!(name: 'Trike2', species: 'triceratops', cage_id: cage.id)
    end
  end

  test '#dinosaurs_count' do
    cage = Cage.create!(max_capacity: 2, power_status: 'ACTIVE')

    Dinosaur.create!(name: 'Trike', species: 'triceratops', cage_id: cage.id)
    Dinosaur.create!(name: 'Trike2', species: 'triceratops', cage_id: cage.id)

    assert_equal cage.dinosaurs_count, 2
  end

  test 'power status is ACTIVE or DOWN' do
    cage_active = Cage.create!(max_capacity: 1, power_status: 'ACTIVE')
    cage_down = Cage.create!(max_capacity: 1, power_status: 'DOWN')

    assert cage_active.valid?
    assert cage_down.valid?

    assert_raises(ArgumentError) do
      Cage.create!(max_capacity: 1, power_status: 'INVALID')
    end
  end

  test 'cages cannot be powered off if they contain dinosaurs' do
    cage = Cage.create!(max_capacity: 1, power_status: 'ACTIVE')
    Dinosaur.create!(name: 'Trike', species: 'triceratops', cage_id: cage.id)

    assert_raises(ActiveRecord::RecordInvalid) do
      cage.update!(power_status: 'DOWN')
    end
  end

  test 'cages cannot be powered down if they contain dinosaurs' do
    cage = Cage.create!(max_capacity: 1, power_status: 'ACTIVE')
    Dinosaur.create!(name: 'Trike', species: 'triceratops', cage_id: cage.id)

    assert_raises(ActiveRecord::RecordInvalid) do
      cage.update!(power_status: 'DOWN')
    end
  end

  test 'queries a list of dinosaurs in a cage' do
    cage = Cage.create!(max_capacity: 1, power_status: 'ACTIVE')
    Dinosaur.create!(name: 'Trike', species: 'triceratops', cage_id: cage.id)

    assert_equal cage.dinosaurs.count, 1
  end

  test 'queries a list of dinosaurs in a cage by species' do
    cage = Cage.create!(max_capacity: 1, power_status: 'ACTIVE')
    Dinosaur.create!(name: 'Trike', species: 'triceratops', cage_id: cage.id)

    assert_equal cage.dinosaurs.where(species: 'triceratops').count, 1
  end
end
