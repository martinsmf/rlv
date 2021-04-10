Before do
    @alert = Alert.new
    @dash_page = DashPage.new
    @equipos_page = EquiposPage.new
    @login_page = LoginPage.new
    @signup_page = SignupPage.new

    #page.driver.browser.manege.window.maximize
    page.current_window.resize_to(1440, 900)
end