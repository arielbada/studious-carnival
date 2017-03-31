class AddEsSedeProvincialToLocalidades < ActiveRecord::Migration[5.0]
  def change
    add_column :localidades, :es_sede_provincial, :boolean
  end
end
