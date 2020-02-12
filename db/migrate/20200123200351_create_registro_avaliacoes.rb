class CreateRegistroAvaliacoes < ActiveRecord::Migration[5.2]
  def change
    create_table :registro_avaliacoes do |t|
      t.integer :aluno_id, null: false  
      t.string :nome_aluno, null: false
      t.string :status, null: false
      t.string :avaliador, null: false
      t.timestamps
    end
  end
end
