Given('that i access the registration page') do
    visit "/signup"
end

When('i submit my complete registration:') do |data_table|
# table is a Cucumber::MultilineArgument::DataTable
    user = data_table.hashes.first

    MongoDB.new.remove_user(user[:email])

    find("#fullName").set user[:name]
    find("#email").set user[:email]
    find("#password").set user[:password]

    click_button "Cadastrar"
end