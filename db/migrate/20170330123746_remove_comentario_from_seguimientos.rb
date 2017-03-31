class RemoveComentarioFromSeguimientos < ActiveRecord::Migration[5.0]
  def change
    remove_column :seguimientos, :comentario, :string
  end
end
