require 'test_helper'

class Dinosaurs::CreateCommandTest < ActiveSupport::TestCase
  test 'successfully creates a dinosaur' do
    cage = Cage.create!(power_status: 'ACTIVE')
    dinosaur_params = { name: 'T-Rex', species: 'tyrannosaurus', cage_id: cage.id }

    result = Dinosaurs::CreateCommand.new.create!(dinosaur_params:)

    assert result.success?
    assert result.dinosaur.persisted?
    assert_empty result.errors
  end

  test 'fails to create a dinosaur with invalid parameters' do
    cage = Cage.create!(power_status: 'ACTIVE')
    invalid_dinosaur_params = { name: '', species: 'tyrannosaurus', cage_id: cage.id }

    result = Dinosaurs::CreateCommand.new.create!(dinosaur_params: invalid_dinosaur_params)

    refute result.success?
    refute_empty result.errors
  end

  test 'fails to create a dinosaur with invalid species' do
    cage = Cage.create!(power_status: 'ACTIVE')
    invalid_dinosaur_params = { name: 'T-Rex', species: 'unknown', cage_id: cage.id }

    result = Dinosaurs::CreateCommand.new.create!(dinosaur_params: invalid_dinosaur_params)

    refute result.success?
    refute_empty result.errors
  end
end
