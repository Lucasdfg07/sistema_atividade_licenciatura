class CreatePrazoAtpas < ActiveRecord::Migration[5.2]
  def change
    create_table :prazo_atpas do |t|
      t.string :admin_responsavel
      t.date :prazo_final, null: false, default: ""
      t.timestamps
    end
  end
end
