require 'test_helper'

class AlumnoObservacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @alumno_observacion = alumno_observaciones(:one)
  end

  test "should get index" do
    get alumno_observaciones_url
    assert_response :success
  end

  test "should get new" do
    get new_alumno_observacion_url
    assert_response :success
  end

  test "should create alumno_observacion" do
    assert_difference('AlumnoObservacion.count') do
      post alumno_observaciones_url, params: { alumno_observacion: { observacion: @alumno_observacion.observacion } }
    end

    assert_redirected_to alumno_observacion_url(AlumnoObservacion.last)
  end

  test "should show alumno_observacion" do
    get alumno_observacion_url(@alumno_observacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_alumno_observacion_url(@alumno_observacion)
    assert_response :success
  end

  test "should update alumno_observacion" do
    patch alumno_observacion_url(@alumno_observacion), params: { alumno_observacion: { observacion: @alumno_observacion.observacion } }
    assert_redirected_to alumno_observacion_url(@alumno_observacion)
  end

  test "should destroy alumno_observacion" do
    assert_difference('AlumnoObservacion.count', -1) do
      delete alumno_observacion_url(@alumno_observacion)
    end

    assert_redirected_to alumno_observaciones_url
  end
end
