class LoginElements
    include Capybara::DSL

    def field_email
        return find("input[placeholder='Seu email']")
    end

    def field_pass
        return find("input[type=password]")
    end
end