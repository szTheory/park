require 'test_helper'

class DinosaursControllerTest < ActionDispatch::IntegrationTest
  test 'index' do
    cage = Cage.create!(power_status: 'ACTIVE', max_capacity: 1)
    Dinosaur.create!(name: 'T-Rex', species: 'tyrannosaurus', cage:)

    get dinosaurs_url(cage)

    assert_response :success
    assert_equal cage.dinosaurs.to_json, response.body
  end

  test 'show' do
    cage = Cage.create!(power_status: 'ACTIVE', max_capacity: 1)
    dinosaur = Dinosaur.create!(name: 'T-Rex', species: 'tyrannosaurus', cage:)

    get dinosaur_url(dinosaur)

    assert_response :success
    assert_equal dinosaur.to_json, response.body
  end

  test 'show with non-existent dinosaur' do
    get dinosaur_url(-1) # Assuming -1 is an ID that does not exist

    assert_response :not_found
  end

  test 'create' do
    cage = Cage.create!(power_status: 'ACTIVE', max_capacity: 1)
    dinosaur_params = { dinosaur: { name: 'T-Rex', species: 'tyrannosaurus', cage_id: cage.id } }

    post dinosaurs_url, params: dinosaur_params

    assert_response :created
    assert_equal Dinosaur.last.to_json, response.body
  end

  test 'create with invalid params' do
    cage = Cage.create!(power_status: 'ACTIVE')
    invalid_params = { dinosaur: { name: '', species: 'unknown', cage_id: cage.id } }

    post dinosaurs_url, params: invalid_params

    assert_response :unprocessable_entity
  end

  test 'update' do
    cage = Cage.create!(power_status: 'ACTIVE', max_capacity: 1)
    dinosaur = Dinosaur.create!(name: 'T-Rex', species: 'tyrannosaurus', cage:)
    update_params = { dinosaur: { name: 'Rexy', species: 'tyrannosaurus' } }

    patch dinosaur_url(dinosaur), params: update_params

    assert_response :success
    assert_equal 'Rexy', dinosaur.reload.name
  end

  test 'update with invalid params' do
    cage = Cage.create!(power_status: 'ACTIVE', max_capacity: 1)
    dinosaur = Dinosaur.create!(name: 'T-Rex', species: 'tyrannosaurus', cage:)
    invalid_params = { dinosaur: { name: '', species: 'unknown' } }

    patch dinosaur_url(dinosaur), params: invalid_params

    assert_response :unprocessable_entity
  end

  test 'destroy' do
    cage = Cage.create!(power_status: 'ACTIVE', max_capacity: 1)
    dinosaur = Dinosaur.create!(name: 'T-Rex', species: 'tyrannosaurus', cage:)

    delete dinosaur_url(dinosaur)

    assert_response :success
  end

  test 'destroy non-existent dinosaur' do
    delete dinosaur_url(-1) # Assuming -1 is an ID that does not exist

    assert_response :not_found
  end
end
