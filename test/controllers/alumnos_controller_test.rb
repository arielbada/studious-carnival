require 'test_helper'

class AlumnosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @alumno = alumnos(:one)
  end

  test "should get index" do
    get alumnos_url
    assert_response :success
  end

  test "should get new" do
    get new_alumno_url
    assert_response :success
  end

  test "should create alumno" do
    assert_difference('Alumno.count') do
      post alumnos_url, params: { alumno: { apellido: @alumno.apellido, correo: @alumno.correo, dni: @alumno.dni, domicilio: @alumno.domicilio, fecha_nacimiento: @alumno.fecha_nacimiento, inscripcion_certificado: @alumno.inscripcion_certificado, inscripcion_ficha: @alumno.inscripcion_ficha, inscripcion_foto: @alumno.inscripcion_foto, inscripcion_partida: @alumno.inscripcion_partida, localidad_id: @alumno.localidad_id, nombre: @alumno.nombre, sede_id: @alumno.sede_id, telefono_celular: @alumno.telefono_celular, telefono_fijo: @alumno.telefono_fijo } }
    end

    assert_redirected_to alumno_url(Alumno.last)
  end

  test "should show alumno" do
    get alumno_url(@alumno)
    assert_response :success
  end

  test "should get edit" do
    get edit_alumno_url(@alumno)
    assert_response :success
  end

  test "should update alumno" do
    patch alumno_url(@alumno), params: { alumno: { apellido: @alumno.apellido, correo: @alumno.correo, dni: @alumno.dni, domicilio: @alumno.domicilio, fecha_nacimiento: @alumno.fecha_nacimiento, inscripcion_certificado: @alumno.inscripcion_certificado, inscripcion_ficha: @alumno.inscripcion_ficha, inscripcion_foto: @alumno.inscripcion_foto, inscripcion_partida: @alumno.inscripcion_partida, localidad_id: @alumno.localidad_id, nombre: @alumno.nombre, sede_id: @alumno.sede_id, telefono_celular: @alumno.telefono_celular, telefono_fijo: @alumno.telefono_fijo } }
    assert_redirected_to alumno_url(@alumno)
  end

  test "should destroy alumno" do
    assert_difference('Alumno.count', -1) do
      delete alumno_url(@alumno)
    end

    assert_redirected_to alumnos_url
  end
end
