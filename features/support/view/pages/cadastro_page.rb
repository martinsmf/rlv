class SignupPage
    include Capybara::DSL

    def open
        visit "/signup"
    end

    def create(user)
        find("#fullName").set user[:name]
        find("#email").set user[:email]
        find("#password").set user[:password]

        click_button "Cadastrar"
    end
    
end