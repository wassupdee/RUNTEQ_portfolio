Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--headless")
  options.add_argument("--disable-gpu") # 古いバージョンのChrome用
  options.add_argument("--no-sandbox") # CI環境での実行に必須
  options.add_argument("--window-size=1920,1080")

  Capybara::Selenium::Driver.new(app, browser: :chrome, options:)
end

Capybara.javascript_driver = :selenium_chrome_headless
