Given('that access the main page') do
  @login_page.open
end
  
When('i submit my credentials with {string} and {string}') do |email, password|
  @login_page.with(email, password)
end