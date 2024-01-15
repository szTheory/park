require 'test_helper'

class Dinosaurs::DestroyCommandTest < ActiveSupport::TestCase
  test 'successfully destroys a dinosaur' do
    cage = Cage.create!(power_status: 'ACTIVE', max_capacity: 1)
    dinosaur = Dinosaur.create!(name: 'T-Rex', species: 'tyrannosaurus', cage:)

    result = Dinosaurs::DestroyCommand.new.destroy!(dinosaur_id: dinosaur.id)

    assert result.success?
    assert_nil Dinosaur.find_by(id: dinosaur.id)
  end

  test 'handles non-existent dinosaur gracefully' do
    result = Dinosaurs::DestroyCommand.new.destroy!(dinosaur_id: -1) # Assuming -1 is an ID that will not exist.

    refute result.success?
  end
end
