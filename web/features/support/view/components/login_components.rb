class LoginElements
    include Capybara::DSL

    def field_email
        return find("input[placeholder='Seu email']")
    end
end