class AddPeriodoToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :periodo, :string
  end
end
