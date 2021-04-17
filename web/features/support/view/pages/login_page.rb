class LoginPage
    include Capybara::DSL
    attr_accessor :login_elements

    def initialize
        @login_elements = LoginElements.new
    end

    def open
        visit "/"
    end

    def with(email, password)
        @login_elements.field_email.set email
        find("input[type=password]").set password
        click_button "Entrar"
    end

end