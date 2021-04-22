Given('que meu perfil de anunciante é {string} e {string}') do |email, password|
    @email_anunciante = email
    @pass_anunciante = password
end

Given('que tenho o seguinte equipamento cadastrado:') do |table|
    # table is a Cucumber::MultilineArgument::DataTable
    user_id = SessionsService.new.get_user_id(@email_anunciante, @pass_anunciante)
    thumbnail = File.open(File.join(Dir.pwd, "features/support/fixtures/images/", table.rows_hash[:thumb]), "rb")

    @equipo = {
        thumbnail: thumbnail,
        name: table.rows_hash[:name],
        category: table.rows_hash[:category],
        price: table.rows_hash[:price]
    }

    MongoDB.new.remove_equipo(@equipo[:name], @email_anunciante)
    result = EquiposService.new.create(@equipo, user_id)
    @equipo_id = result.parsed_response["_id"]
end

Given('acesso meu dashboard') do
    steps %{
        Given that access the main page
        When i submit my credentials with "#{@email_anunciante}" and "#{@pass_anunciante}"
    }
    #checkpoint para garantir que estamos no deashboard
    expect(@dash_page.on_dash?).to be true
end

When('{string} e {string} solicita a locação desse equipamento') do |email, password|
    locatario_id = SessionsService.new.get_user_id(email, password)
    EquiposService.new.booking(@equipo_id, locatario_id)
end

Then('devo ver a seguinte mensagem:') do |doc_string|
    expect_message = doc_string.gsub("DATA_ATUAL", Time.now.strftime("%d/%m/%Y"))
    expect(@dash_page.msg_locacao).to have_text expect_message
end

Then('devo ver os links: {string} e {string} no pedido') do |button_accept, button_reject|
    expect(@dash_page.order_actions(button_accept)).to be true
    expect(@dash_page.order_actions(button_reject)).to be true
end