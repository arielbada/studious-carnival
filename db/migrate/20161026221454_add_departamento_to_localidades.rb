class AddDepartamentoToLocalidades < ActiveRecord::Migration[5.0]
  def change
    add_column :localidades, :departamento, :string
  end
end
