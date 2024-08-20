Capybara.register_driver :remote_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('no-sandbox')
  options.add_argument('headless')
  options.add_argument('disable-gpu')
  options.add_argument('window-size=1440,990')
  Capybara::Selenium::Driver.new(app, browser: :remote, url: ENV['SELENIUM_DRIVER_URL'], capabilities: options)
end

# Capybara.register_driver :remote_chrome do |app|
#   url = ENV['SELENIUM_DRIVER_URL']
#   options = Selenium::WebDriver::Chrome::Options.new
#   options.args << 'no-sandbox'
#   options.args << 'headless'
#   options.args << 'disable-gpu'
#   options.args << 'window-size=1680,1050'

#   Capybara::Selenium::Driver.new(app, browser: :remote, url: url, options: options)

#   Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
# end

# Capybara.register_driver :remote_chrome do |app|
#   options = Selenium::WebDriver::Chrome::Options.new
#   options.add_argument('--headless')
#   options.add_argument('--disable-gpu') # 古いバージョンのChrome用
#   options.add_argument('--no-sandbox') # CI環境での実行に必須
#   options.add_argument('--window-size=1920,1080')

#   Capybara::Selenium::Driver.new(app, browser: :chrome, options:)
# end

# Capybara.javascript_driver = :selenium_chrome_headless