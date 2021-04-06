Given('that i access the registration page') do
    visit "http://rocklov-web:3000/signup"
end

When('i submit my registration') do
    find("#fullName").set "Matheus Martins"
    find("#email").set "matheus@gamil.com"
    find("#password").set "pwd123"
    click_button "Cadastrar"
end

Then('i am redirected to the Dashboard') do
    expect(page).to have_css ".dashboard"
end