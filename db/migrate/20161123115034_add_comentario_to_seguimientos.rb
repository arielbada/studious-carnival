class AddComentarioToSeguimientos < ActiveRecord::Migration[5.0]
  def change
    add_column :seguimientos, :comentario, :string
  end
end
