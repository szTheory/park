require 'test_helper'

class Dinosaurs::UpdateCommandTest < ActiveSupport::TestCase
  test 'successfully updates a dinosaur' do
    cage = Cage.create!(power_status: 'ACTIVE')
    dinosaur = Dinosaur.create!(name: 'Velociraptor', species: 'velociraptor', cage:)
    valid_update_params = { name: 'Raptor', species: 'velociraptor' }

    result = Dinosaurs::UpdateCommand.new.update!(dinosaur_id: dinosaur.id, dinosaur_params: valid_update_params)

    assert result.success?
    assert result.dinosaur.persisted?
    assert_equal 'Raptor', result.dinosaur.name
    assert_equal 'velociraptor', result.dinosaur.species
    assert_empty result.errors
  end

  test 'fails to update a dinosaur with invalid parameters' do
    cage = Cage.create!(power_status: 'ACTIVE')
    dinosaur = Dinosaur.create!(name: 'T-Rex', species: 'tyrannosaurus', cage:)
    invalid_update_params = { name: '', species: 'unknown' }

    result = Dinosaurs::UpdateCommand.new.update!(dinosaur_id: dinosaur.id, dinosaur_params: invalid_update_params)

    refute result.success?
    assert result.dinosaur.persisted?
    refute_empty result.errors
  end
end
