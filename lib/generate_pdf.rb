require 'prawn'

module GeneratePdf
  PDF_OPTIONS = {
    # Escolhe o Page size como uma folha A4
    :page_size   => "A4",
    # Define o formato do layout como portrait (poderia ser landscape)
    :page_layout => :portrait,
    # Define a margem do documento
    :margin      => [40, 50]
  }

    def self.activity user, activities
      # Apenas uma string aleatório para termos um corpo de texto pro contrato
      # lorem_ipsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec elementum nulla id dignissim iaculis. Vestibulum a egestas elit, vitae feugiat velit. Vestibulum consectetur non neque sit amet tristique. Maecenas sollicitudin enim elit, in auctor ligula facilisis sit amet. Fusce imperdiet risus sed bibendum hendrerit. Sed vitae ante sit amet sapien aliquam consequat. Duis sed magna dignissim, lobortis tortor nec, suscipit velit. Nulla sit amet fringilla nisl. Integer tempor mauris vitae augue lobortis posuere. Ut quis tellus purus. Nullam dolor mauris, egestas varius ligula non, cursus faucibus orci sectetur non neque sit amet tristique. Maecenas sollicitudin enim elit, in auctor ligula facilisis sit amet. Fusce imperdiet risus sed bibendum hendrerit. Sed vitae ante sit amet sapien aliquam consequat."

      Prawn::Document.new(PDF_OPTIONS) do |pdf|
        # Define a cor do traçado
        pdf.fill_color "666666"
        pdf.image "#{Rails.root}/public/logo/ifflogo.png", :at => [-20,790], :scale => 0.5
        pdf.move_down 10

        # Cria um texto com tamanho 30 PDF Points, bold alinha no centro
        pdf.text "Relatório de Atividades
                  Cadastradas", :size => 26, :style => :bold, :align => :center

        # Move 80 PDF points para baixo o cursor
        pdf.move_down 50
        pdf.text "Dados do Aluno
                  Nome: #{user.nome}
                  Matrícula: #{user.matricula}
                  Curso: #{user.licenciatura}\n
                  Quantidade de horas cadastradas:\n", :size => 12, :style => :bold
        
        pdf.text "#{user.cargahoraria[18]} de #{MAXIMO[18]}", :size => 12, :style => :bold

        pdf.move_down 20
        table_data = [["<b>Atividades</b>", "Horas Cadastradas"],
                      ["<b><u>Contabilização de Horas</u></b>", "<b>#{user.cargahoraria[18]}<b>"],
                      ["<b>Participação como ouvinte em Palestras, Seminários, Congressos, Conferências, Simpósios, Fóruns, Encontros, Mesas Redondas, Minicursos, Oficinas e similares</b>", "<b>#{user.cargahoraria[0]}<b>"],
                      ["<b>Participação no desenvolvimento de projetos de extensão sob orientação de professor,na área de formação</b>", "<b>#{user.cargahoraria[1]}<b>"],
                      ["<b>Participação no desenvolvimento de projeto de pesquisa sob orientação de professor, na área de formação</b>", "<b>#{user.cargahoraria[2]}<b>"],
                      ["<b>Visitas orientadas a exposições, museus, teatros, patrimônio artístico ou cultural </b>", "<b>#{user.cargahoraria[3]}<b>"],
                      ["<b>Participação em atividades artísticas e culturais sob a supervisão de professor e/ou de profissional do IFFluminense</b>", "<b>#{user.cargahoraria[4]}<b>"],
                      ["<b>Representação em Órgãos Colegiados e/ou Comissões do IFFluminense campus Campos Centro</b>", "<b>#{user.cargahoraria[5]}<b>"],
                      ["<b>Participação em atividade de extensão, na área de formação, nas modalidades presencial e/ou semipresencial</b>", "<b>#{user.cargahoraria[6]}<b>"],
                      ["<b>Atuação em função de bolsista ou voluntário no IFFluminense, em, no mínimo, 02 (dois) períodos letivos</b>", "<b>#{user.cargahoraria[7]}<b>"],
                      ["<b>Participação em curso de extensão, na área de formação, na modalidade online</b>", "<b>#{user.cargahoraria[8]}<b>"],
                      ["<b>Participação em Atividade de Monitoria, na área de formação, no 2.º segmento do Ensino Fundamental, em Cursos de Nível Médio e/ou em Curso Superior</b>", "<b>#{user.cargahoraria[9]}<b>"],
                      ["<b>Participação como ouvinte na apresentação oral de Qualificação de Projeto e/ou de Monografia (Trabalho de Conclusão, Dissertação e Tese), na área de formação e/ou em áreas afins à formação</b>", "<b>#{user.cargahoraria[10]}<b>"],
                      ["<b>Participação como ouvinte na apresentação oral de Monografias (Trabalho Conclusão de Curso, Dissertação e Tese), na área de formação e/ou em áreas afins à formação</b>", "<b>#{user.cargahoraria[11]}<b>"],
                      ["<b>Apresentação de trabalhos acadêmicos, científicos ou culturais em instituições de âmbito local, regional, nacional e/ou internacional</b>", "<b>#{user.cargahoraria[12]}<b>"],
                      ["<b>Publicação em periódicos / em Anais (Resumo e/ou Artigo Completo)</b>", "<b>#{user.cargahoraria[13]}<b>"],
                      ["<b>Publicação em Livros</b>", "<b>#{user.cargahoraria[14]}<b>"],
                      ["<b>Participação na organização e coordenação de eventos acadêmico-científico-culturais internos ou externos ao IFFluminense</b>", "<b>#{user.cargahoraria[15]}<b>"],
                      ["<b>Participação em Grupo de Estudo Temático sob orientação de professor, em semestre letivo, na área de formação e/ou em áreas afins à formação</b>", "<b>#{user.cargahoraria[16]}<b>"],
                      ["<b>Apresentação de trabalhos de pesquisa institucional em eventos científicos internos ou externos</b>", "<b>#{user.cargahoraria[17]}<b>"],]

        pdf.table(table_data,:header => true, :width => 500, :cell_style => { :inline_format => true, size: 9 })

        pdf.move_down 20
        pdf.text "Atividades cadastradas", :size => 12, :style => :bold
        cont = 1
        activities.each do |activity|
          if ((activity.status == "Deferido")||(activity.status == "Indeferido"))
            pdf.text "\nAtividade #{cont}", :size => 11, :style => :bold
            pdf.text "Tema: #{activity.titulo}
                      Status: #{activity.status}
                      Instituição: #{activity.local_realizacao_atividade}
                      Data: #{activity.data_evento.strftime("%d/%m/%Y")}
                      Relatório da Atividade: #{activity.relatorio}
                      Avaliador: #{activity.edited_by}
                      Horas Atribuídas: #{activity.hora_computada}", :size =>10
          cont += 1
          end
        end

        if(cont == 1)
          pdf.text "Não existem atividades aprovadas", :size => 10
        end

        # Escreve o texto com os detalhes que o usuário entrou
        #pdf.text "#{details}", :size => 12, :align => :justify, :inline_format => true
        # Move mais 30 PDF points para baixo o cursor
        #pdf.move_down 10
        # Adiciona o nome com 12 PDF points, justify e com o formato inline (Observe que o <b></b> funciona para deixar em negrito)
        #pdf.text "Com o cliente: <b>#{name}</b> por R$#{price}", :size => 12, :align => :justify, :inline_format => true
        # Muda de font para Helvetica
        pdf.font "Helvetica"
        # Inclui um texto com um link clicável (usando a tag link) no bottom da folha do lado esquerdo e coloca uma cor especifica nessa parte (usando a tag color)
        pdf.text "Relatório de Atividades Cadastradas", :size => 10, :inline_format => true, :valign => :bottom, :align => :left
        # Inclui em baixo da folha do lado direito a data e o némero da página usando a tag page
        pdf.number_pages "Gerado: #{(Time.now).strftime("%d/%m/%y as %H:%M")} - Página <page>", :start_count_at => 1, :page_filter => :all, :at => [ bounds.right - 270, -20], :align => :right, :size => 8
        # Gera no nosso PDF e coloca na pasta public com o nome agreement.pdf
        return pdf
      end
    end

end
