class AddIdPlataformaToSecciones < ActiveRecord::Migration[5.0]
  def change
    add_column :secciones, :id_plataforma, :string
  end
end
