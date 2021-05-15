require_relative '../components/login_components.rb'
class LoginPage < LoginElements
    include Capybara::DSL
    def open
        visit "/"
    end

    def with(email, password)
        field_email.set email
        field_pass.set password
        click_button "Entrar"
    end

end