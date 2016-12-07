class RemoveCohorteAndModuloFromSeguimientos < ActiveRecord::Migration[5.0]
  def change
    remove_column :seguimientos, :cohorte, :string
    remove_column :seguimientos, :modulo, :string
  end
end
