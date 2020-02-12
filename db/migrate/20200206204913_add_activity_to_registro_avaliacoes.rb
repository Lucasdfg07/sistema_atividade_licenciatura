class AddActivityToRegistroAvaliacoes < ActiveRecord::Migration[5.2]
  def change
    add_column :registro_avaliacoes, :id_activity, :integer
  end
end
