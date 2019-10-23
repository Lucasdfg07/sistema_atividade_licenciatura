# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_08_15_183451) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer "grupo", null: false
    t.date "data_evento", null: false
    t.string "tipo"
    t.string "titulo", null: false
    t.string "local_realizacao_atividade", null: false
    t.text "relatorio", null: false
    t.bigint "user_id"
    t.float "hora_computada", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.text "feedback"
    t.string "edited_by"
    t.json "documents"
    t.string "nome_grupo"
    t.string "nome_usuario"
    t.string "nome_do_evento"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "duvidas", force: :cascade do |t|
    t.string "duvida"
    t.string "resposta"
  end

  create_table "eventos", force: :cascade do |t|
    t.string "noticia"
    t.string "noticia_foto"
  end

  create_table "relatnaoformais", force: :cascade do |t|
    t.string "denominada_estagio"
    t.string "CNPJ_estagio"
    t.string "rua_estagio"
    t.string "bairro_estagio"
    t.string "municipio_estagio"
    t.string "estado_estagio"
    t.string "cep_estagio"
    t.string "telefone_estagio"
    t.string "representado_por"
    t.string "ano"
    t.string "semestre"
    t.string "endereco"
    t.string "numero"
    t.string "bairro"
    t.string "municipio"
    t.string "estado"
    t.string "periodo_de"
    t.string "periodo_a"
    t.string "nome"
    t.string "matricula_aluno"
    t.string "periodo"
    t.string "licenciatura"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relatorios", force: :cascade do |t|
    t.string "representado_por", default: "", null: false
    t.string "semestre", default: "", null: false
    t.string "ano", default: "", null: false
    t.string "endereco", default: "", null: false
    t.string "bairro", default: "", null: false
    t.string "municipio", default: "", null: false
    t.string "estado", default: "", null: false
    t.string "CEP", default: "", null: false
    t.string "periodo_de", default: "", null: false
    t.string "periodo_a", default: "", null: false
    t.string "nome"
    t.string "matricula_aluno"
    t.string "periodo"
    t.string "licenciatura"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relatoutros", force: :cascade do |t|
    t.string "parceria_firmada_com"
    t.string "denominada_estagio"
    t.string "CNPJ_estagio"
    t.string "rua_estagio"
    t.string "numero_estagio"
    t.string "periodo_letivo"
    t.string "bairro_estagio"
    t.string "municipio_estagio"
    t.string "telefone_estagio"
    t.string "representado_por"
    t.string "ano"
    t.string "endereco"
    t.string "bairro"
    t.string "municipio"
    t.string "estado"
    t.string "CEP"
    t.string "periodo_de"
    t.string "periodo_a"
    t.string "nome"
    t.string "matricula_aluno"
    t.string "periodo"
    t.string "licenciatura"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relatparticulares", force: :cascade do |t|
    t.string "denominada_estagio"
    t.string "CNPJ_estagio"
    t.string "rua_estagio"
    t.string "numero_estagio"
    t.string "bairro_estagio"
    t.string "municipio_estagio"
    t.string "estado_estagio"
    t.string "cep_estagio"
    t.string "telefone_estagio"
    t.string "representado_por"
    t.string "ano"
    t.string "semestre"
    t.string "endereco"
    t.string "numero"
    t.string "bairro"
    t.string "municipio"
    t.string "estado"
    t.string "CEP"
    t.string "periodo_de"
    t.string "periodo_a"
    t.string "nome"
    t.string "matricula_aluno"
    t.string "periodo"
    t.string "licenciatura"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relatpublicos", force: :cascade do |t|
    t.string "parceria_firmada_com"
    t.string "denominada_estagio"
    t.string "CNPJ_estagio"
    t.string "rua_estagio"
    t.string "numero_estagio"
    t.string "periodo_letivo"
    t.string "bairro_estagio"
    t.string "municipio_estagio"
    t.string "telefone_estagio"
    t.string "representado_por"
    t.string "ano"
    t.string "semestre"
    t.string "endereco"
    t.string "bairro"
    t.string "municipio"
    t.string "estado"
    t.string "CEP"
    t.string "periodo_de"
    t.string "periodo_a"
    t.string "nome"
    t.string "matricula_aluno"
    t.string "periodo"
    t.string "licenciatura"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nome", null: false
    t.string "matricula", null: false
    t.string "licenciatura", null: false
    t.string "inicio_ano", null: false
    t.string "termino_ano", null: false
    t.integer "role", default: 0
    t.string "cargahoraria"
    t.string "cargahoraria_total"
    t.string "avatar"
    t.string "periodo"
    t.string "situacao", default: "0"
    t.boolean "pdf_centro", default: false
    t.boolean "pdf_guarus", default: false
    t.boolean "pdf_publico", default: false
    t.boolean "pdf_particular", default: false
    t.boolean "pdf_naoformal", default: false
    t.boolean "status_impressao", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "activities", "users"
end
