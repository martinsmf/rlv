Given('que acesso a página principal') do
    visit "http://rocklov-web:3000/"
  end
  
  When('submeto minhas credenciais com {string} e {string}') do |email, password|
    find("input[placeholder='Seu e-email']").set email
    find("input[type=password]").set password

    find(".btn").click
  end