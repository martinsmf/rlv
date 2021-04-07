require "capybara"
require "capybara/cucumber"
require "faker"
require "mongo"

Capybara.configure do |config|
    config.default_driver = :selenium_chrome
end