class PrazoAtpa < ApplicationRecord
  validates :prazo_final, presence: true
  validates :admin_responsavel, presence: false
end
