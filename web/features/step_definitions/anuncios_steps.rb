Given('Login with {string} and {string}') do |email, password|
    @email = email
    steps %{
        Given that access the main page
        When i submit my credentials with "#{email}" and "#{password}"
    }
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