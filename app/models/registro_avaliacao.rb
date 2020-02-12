class RegistroAvaliacao < ApplicationRecord
    validates :aluno_id, :nome_aluno, :id_activity, :status, :avaliador, presence: false
end
