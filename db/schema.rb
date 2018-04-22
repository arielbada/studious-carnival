# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180420201305) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alumno_observaciones", force: :cascade do |t|
    t.string "observacion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "alumno_observaciones_alumnos", id: false, force: :cascade do |t|
    t.bigint "alumno_observacion_id", null: false
    t.bigint "alumno_id", null: false
    t.index ["alumno_id", "alumno_observacion_id"], name: "index_alumno_alumno_observacion", unique: true
  end

  create_table "alumnos", id: :serial, force: :cascade do |t|
    t.string "dni"
    t.string "nombre"
    t.string "apellido"
    t.integer "localidad_id"
    t.string "domicilio"
    t.string "telefono_fijo"
    t.string "telefono_celular"
    t.string "correo"
    t.date "fecha_nacimiento"
    t.boolean "inscripcion_certificado"
    t.boolean "inscripcion_foto"
    t.boolean "inscripcion_partida"
    t.boolean "inscripcion_ficha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "sigae"
    t.string "comentario"
    t.string "comentario_inscripcion"
    t.string "sexo"
    t.integer "sede_id"
    t.index ["localidad_id"], name: "index_alumnos_on_localidad_id"
    t.index ["sede_id"], name: "index_alumnos_on_sede_id"
  end

  create_table "localidades", id: :serial, force: :cascade do |t|
    t.string "localidad"
    t.string "region_educativa"
    t.string "nodo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "departamento"
    t.boolean "es_sede_provincial"
  end

  create_table "secciones", id: :serial, force: :cascade do |t|
    t.string "seccion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "fecha_inicio"
    t.date "fecha_finalizacion"
    t.string "id_plataforma"
  end

  create_table "sedes", id: :serial, force: :cascade do |t|
    t.string "escuela"
    t.string "direccion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "telefono"
    t.string "nombre_contacto"
    t.integer "localidad_id"
    t.string "email"
    t.string "telefono_contacto"
    t.string "email_contacto"
    t.boolean "tipo_sede_conectividad"
    t.boolean "tipo_sede_presencial"
    t.boolean "tipo_sede_consulta"
    t.boolean "tiene_pc"
    t.boolean "tiene_internet"
    t.string "observaciones"
    t.index ["localidad_id"], name: "index_sedes_on_localidad_id"
  end

  create_table "seguimientos", id: :serial, force: :cascade do |t|
    t.integer "alumno_id"
    t.date "fecha_acta"
    t.string "estado"
    t.integer "calificacion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "seccion_id"
    t.index ["alumno_id"], name: "index_seguimientos_on_alumno_id"
    t.index ["fecha_acta"], name: "index_seguimientos_on_fecha_acta"
    t.index ["seccion_id"], name: "index_seguimientos_on_seccion_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "alumnos", "sedes"
  add_foreign_key "sedes", "localidades"
end
