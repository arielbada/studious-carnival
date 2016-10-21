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

ActiveRecord::Schema.define(version: 20161020113857) do

  create_table "alumnos", force: :cascade do |t|
    t.string   "dni"
    t.string   "nombre"
    t.string   "apellido"
    t.integer  "localidad_id"
    t.string   "domicilio"
    t.string   "telefono_fijo"
    t.string   "telefono_celular"
    t.string   "correo"
    t.date     "fecha_nacimiento"
    t.integer  "sede_id"
    t.boolean  "inscripcion_certificado"
    t.boolean  "inscripcion_foto"
    t.boolean  "inscripcion_partida"
    t.boolean  "inscripcion_ficha"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["localidad_id"], name: "index_alumnos_on_localidad_id"
    t.index ["sede_id"], name: "index_alumnos_on_sede_id"
  end

  create_table "localidades", force: :cascade do |t|
    t.string   "localidad"
    t.string   "region_educativa"
    t.string   "nodo"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "sedes", force: :cascade do |t|
    t.string   "escuela"
    t.string   "direccion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
