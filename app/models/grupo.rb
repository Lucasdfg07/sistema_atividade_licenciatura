class Grupo < ApplicationRecord
  validates :nome_grupo, :grupo, presence: true
end
