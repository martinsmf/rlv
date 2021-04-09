Given('that i am logged in') do
    steps %{
        Given that access the main page
        When i submit my credentials with "brook@onepiece.com" and "teste123"
    }
end

Given('access the registration form') do
    click_button "Criar anúncio"
    expect(page).to have_css "#equipoForm"
end

Given('that i have the following equipment:') do |data_table|
# table is a Cucumber::MultilineArgument::DataTable
    @announcement = data_table.rows_hash
    MongoDB.new.remove_equipo(@announcement[:name], @email)
    
end

When('i submit the registration of that item') do

   thumb = Dir.pwd + "/features/support/fixtures/images/#{@announcement[:thumb]}"

    find("#thumbnail [type=file]", visible: false).set thumb
    find("[placeholder$=equipamento]").set @announcement[:name]
    find("#category").find("option", text: @announcement[:category]).click
    find("[placeholder^=Valor]").set @announcement[:price]
    click_button "Cadastrar"
end

Then('i see of that item on Dashboard') do
    announcement = find(".equipo-list")
    expect(announcement).to have_content @announcement[:name]
    expect(announcement).to have_content "R$#{@announcement[:price]}/dia"
end