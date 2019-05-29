require 'selenium-webdriver'
require 'capybara/rspec'

Capybara.configure do |capybara_config|
  capybara_config.default_driver = :selenium_chrome_headless
  capybara_config.default_max_wait_time = 5
end

Capybara.register_driver :selenium_chrome_headless do |app|
  Selenium::WebDriver::Chrome::Service.driver_path = "/mnt/c/Windows/chromedriver.exe"
  Capybara::Selenium::Driver.new(app,
    browser: :chrome,
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: {
        args: %w(headless no-sandbox disable-gpu window-size=1680,1050),
      }
    )
  )
end

Capybara.default_driver = :selenium_chrome_headless
Capybara.javascript_driver = :selenium_chrome_headless
