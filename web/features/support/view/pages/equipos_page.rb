require_relative '../components/equipos_components.rb'
class EquiposPage < EquposComopnents
    include Capybara::DSL

    def create(equipo)
        # checkpoin com timeout explíto
        page.has_css?("#equipoForm")

        upload(equipo[:thumb]) unless equipo[:thumb].empty? # equipo[:thumb].length > 0

        find("[placeholder$=equipamento]").set equipo[:name]
        select_cat(equipo[:category]) if equipo[:category].length > 0
        find("[placeholder^=Valor]").set equipo[:price]
        click_button "Cadastrar"

    end

    def select_cat(cat)
        find("#category").find("option", text: cat).select_option
    end

    def upload(file_name)
        thumb = Dir.pwd + "/features/support/fixtures/images/#{file_name}"

        imput_thumb.set thumb
    end
end