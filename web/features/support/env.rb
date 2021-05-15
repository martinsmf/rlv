require "allure-cucumber"
require "capybara"
require "capybara/cucumber"
require "faker"
require "httparty"
require "mongo"

require_relative "page_helper"
require_relative "../support/services/base_service.rb"

World(Pages)

CONFIG = YAML.load_file(File.join(Dir.pwd, "/features/support/config/#{ENV["CONFIG"]}"))

case ENV["BROWSER"]
when "firefox"
    @driver = :selenium
when "chrome"
    @driver = :selenium_chrome
when "fire_headless"
    @driver = :selenium_headless
when "chrome_headless"
    Capybara.register_driver :selenium_chrome_headless do |app|
        version = Capybara::Selenium::Driver.load_selenium
        options_key = Capybara::Selenium::Driver::CAPS_VERSION.satisfied_by?(version) ? :capabilities : :options
        browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
          opts.add_argument('--headless')
          opts.add_argument('--disable-gpu')
          opts.add_argument('--disable-site-isolation-trials')
          opts.add_argument('--nosandbox')
          opts.add_argument('--disable-dev-shm-usage')
        end
      
        Capybara::Selenium::Driver.new(app, **{ :browser => :chrome, options_key => browser_options })
      end

    @driver = :selenium_chrome_headless
else
    raise "Navegador não encontrado, variável @driver está vasia! :("
end

Capybara.configure do |config|
    config.default_driver = @driver
    config.app_host = CONFIG["url"]
    config.default_max_wait_time = 10
end

AllureCucumber.configure do |config|
    config.results_directory = "/logs/allure"
    config.clean_results_directory = true
end