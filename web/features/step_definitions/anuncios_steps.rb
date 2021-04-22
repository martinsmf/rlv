Given('Login with {string} and {string}') do |email, password|
    @email = email
    steps %{
        Given that access the main page
        When i submit my credentials with "#{email}" and "#{password}"
    }
    #checkpoint para garantir que estamos no deashboard
    expect(@dash_page.on_dash?).to be true
end

Given('access the registration form') do
    @dash_page.goto_equipo_form
end

Given('that i have the following equipment:') do |data_table|
# table is a Cucumber::MultilineArgument::DataTable
    @announcement = data_table.rows_hash
    MongoDB.new.remove_equipo(@announcement[:name], @email)
    
end

When('i submit the registration of that item') do
    @equipos_page.create(@announcement)
end

Then('i see of that item on Dashboard') do
    expect(@dash_page.equipo_list).to have_content @announcement[:name]
    expect(@dash_page.equipo_list).to have_content "R$#{@announcement[:price]}/dia"
end

# Remover anúncios

Given('that i have a announcement:') do |table|
    # table is a Cucumber::MultilineArgument::DataTable
    user_id = page.execute_script("return localStorage.getItem('user')")
    thumbnail = File.open(File.join(Dir.pwd, "features/support/fixtures/images/", table.rows_hash[:thumb]), "rb")

    @equipo = {
        thumbnail: thumbnail,
        name: table.rows_hash[:name],
        category: table.rows_hash[:category],
        price: table.rows_hash[:price]
    }

    EquiposService.new.create(@equipo, user_id)
    visit current_path
end

When('i remove this announcement') do
    item = @dash_page.delete_equipo(@equipo[:name])
    sleep 1 #think time
end

When('i confim the deletion') do
    @dash_page.confirm_removal
end

When('i don\'t confim the deletion') do
    @dash_page.cancel_removal
end

Then('i must not see this item on my Dashboard') do
    expect(
        @dash_page.has_no_equipo?(@equipo[:name])
    )
    .to be true
end

Then('that item must remain in my Dashboard') do
    expect(@dash_page.equipo_list).to have_content @equipo[:name]
end