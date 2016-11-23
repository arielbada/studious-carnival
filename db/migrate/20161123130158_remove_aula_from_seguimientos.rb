class RemoveAulaFromSeguimientos < ActiveRecord::Migration[5.0]
  def change
    remove_column :seguimientos, :aula, :string
  end
end
