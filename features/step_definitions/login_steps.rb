Given('that access the main page') do
    visit "/"
  end
  
When('i submit my credentials with {string} and {string}') do |email, password|
  @email = email
  find("input[placeholder='Seu e-email']").set email
  find("input[type=password]").set password

  find(".btn").click
end