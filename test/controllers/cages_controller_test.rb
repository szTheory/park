require 'test_helper'

class CagesControllerTest < ActionDispatch::IntegrationTest
  test 'index' do
    Cage.create!(power_status: 'ACTIVE')

    get cages_url

    assert_response :success
    assert_equal Cage.all.to_json, response.body
  end

  test 'index filters by power status' do
    Cage.create!(power_status: 'ACTIVE')
    Cage.create!(power_status: 'DOWN')

    get cages_url(power_status: 'ACTIVE')

    assert_response :success
    assert_equal Cage.where(power_status: 'ACTIVE').to_json, response.body
  end

  test 'show' do
    cage = Cage.create!(power_status: 'ACTIVE')

    get cage_url(cage)

    assert_response :success
    assert_equal cage.to_json, response.body
  end

  test 'show when cage does not exist' do
    get cage_url(1)

    assert_response :not_found
    assert_equal({ message: 'Cage not found' }.to_json, response.body)
  end

  test 'create' do
    post cages_url, params: { cage: { power_status: 'ACTIVE' } }

    assert_response :success
    assert_equal Cage.last.to_json, response.body
  end

  test 'create with errors' do
    post cages_url, params: { cage: { power_status: '' } }

    assert_response :unprocessable_entity
    assert_equal({ errors: { power_status: ["can't be blank", 'is not included in the list'] } }.to_json, response.body)
  end

  test 'update' do
    cage = Cage.create!(power_status: 'ACTIVE')

    patch cage_url(cage), params: { cage: { power_status: 'DOWN' } }

    assert_response :success
    assert_equal cage.reload.power_status, 'DOWN'
  end

  test 'update with errors' do
    cage = Cage.create!(power_status: 'ACTIVE')

    patch cage_url(cage), params: { cage: { power_status: '' } }

    assert_response :unprocessable_entity
    assert_equal({ errors: { power_status: ["can't be blank", 'is not included in the list'] } }.to_json, response.body)
  end

  test 'destroy' do
    cage = Cage.create!(power_status: 'ACTIVE')

    delete cage_url(cage)

    assert_response :success
    assert_equal({ message: 'Cage deleted' }.to_json, response.body)
  end
end
