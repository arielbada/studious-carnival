require 'test_helper'

class LocalidadesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @localidad = localidades(:one)
  end

  test "should get index" do
    get localidades_url
    assert_response :success
  end

  test "should get new" do
    get new_localidad_url
    assert_response :success
  end

  test "should create localidad" do
    assert_difference('Localidad.count') do
      post localidades_url, params: { localidad: { localidad: @localidad.localidad, nodo: @localidad.nodo, region_educativa: @localidad.region_educativa } }
    end

    assert_redirected_to localidad_url(Localidad.last)
  end

  test "should show localidad" do
    get localidad_url(@localidad)
    assert_response :success
  end

  test "should get edit" do
    get edit_localidad_url(@localidad)
    assert_response :success
  end

  test "should update localidad" do
    patch localidad_url(@localidad), params: { localidad: { localidad: @localidad.localidad, nodo: @localidad.nodo, region_educativa: @localidad.region_educativa } }
    assert_redirected_to localidad_url(@localidad)
  end

  test "should destroy localidad" do
    assert_difference('Localidad.count', -1) do
      delete localidad_url(@localidad)
    end

    assert_redirected_to localidades_url
  end
end
