class Alert
    include Capybara::DSL

    def alert_darck
        return find(".alert-dark").text
    end
end