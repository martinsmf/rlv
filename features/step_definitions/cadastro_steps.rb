Given('that i access the registration page') do
    @signup_page.open
end

When('i submit my complete registration:') do |data_table|
# table is a Cucumber::MultilineArgument::DataTable
    user = data_table.hashes.first

    MongoDB.new.remove_user(user[:email])
    @signup_page.create(user)
    
end