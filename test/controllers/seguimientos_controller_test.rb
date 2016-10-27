require 'test_helper'

class SeguimientosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @seguimiento = seguimientos(:one)
  end

  test "should get index" do
    get seguimientos_url
    assert_response :success
  end

  test "should get new" do
    get new_seguimiento_url
    assert_response :success
  end

  test "should create seguimiento" do
    assert_difference('Seguimiento.count') do
      post seguimientos_url, params: { seguimiento: { alumno_id: @seguimiento.alumno_id, aula: @seguimiento.aula, calificacion: @seguimiento.calificacion, cohorte: @seguimiento.cohorte, estado: @seguimiento.estado, fecha_acta: @seguimiento.fecha_acta, modulo: @seguimiento.modulo } }
    end

    assert_redirected_to seguimiento_url(Seguimiento.last)
  end

  test "should show seguimiento" do
    get seguimiento_url(@seguimiento)
    assert_response :success
  end

  test "should get edit" do
    get edit_seguimiento_url(@seguimiento)
    assert_response :success
  end

  test "should update seguimiento" do
    patch seguimiento_url(@seguimiento), params: { seguimiento: { alumno_id: @seguimiento.alumno_id, aula: @seguimiento.aula, calificacion: @seguimiento.calificacion, cohorte: @seguimiento.cohorte, estado: @seguimiento.estado, fecha_acta: @seguimiento.fecha_acta, modulo: @seguimiento.modulo } }
    assert_redirected_to seguimiento_url(@seguimiento)
  end

  test "should destroy seguimiento" do
    assert_difference('Seguimiento.count', -1) do
      delete seguimiento_url(@seguimiento)
    end

    assert_redirected_to seguimientos_url
  end
end
