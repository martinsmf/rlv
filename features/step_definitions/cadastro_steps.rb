Given('that i access the registration page') do
    visit "http://rocklov-web:3000/signup"
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

Then('i am redirected to the Dashboard') do
    expect(page).to have_css ".dashboard"
end

When('i submit my registration:') do |data_table|
# table is a Cucumber::MultilineArgument::DataTable
     user = data_table.rows_hash

    find("#fullName").set user[:name]
    find("#email").set user[:email]
    find("#password").set user[:password]

    click_button "Cadastrar"
end
  
Then('i see the message {string}') do |expect_alert|
    alert = find(".alert-dark")
    expect(alert.text).to eql expect_alert  
end