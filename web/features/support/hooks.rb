Before do
    @alert = Alert.new
    @dash_page = DashPage.new
    @equipos_page = EquiposPage.new
    @signup_page = SignupPage.new

    #page.driver.browser.manege.window.maximize
    page.current_window.resize_to(1440, 900)
end

After do
   temp_shot = page.save_screenshot("logs/temp_screenshot.png")

   Allure.add_attachment(
       name: "Screenshot",
       type: Allure::ContentType::PNG,
       source: File.open(temp_shot)
   )
end