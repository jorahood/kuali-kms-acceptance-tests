require 'spec'


# Comment out the next line if you don't want Cucumber Unicode support
require 'cucumber/formatter/unicode'

#require 'cucumber/webrat/element_locator' # Lets you do table.diff!(element_at('#my_table_or_dl_or_ul_or_ol').to_table)
#
#require 'webrat/selenium'
#Webrat.configure do |config|
#
#  config.mode = :selenium
#  config.selenium_server_address = 'localhost'
#  config.application_framework = :external
#
#end
#
##this is necessary to have webrat “wait_for” the response body to be available
#
##when writing steps that match against the response body returned by selenium
#
#World(Webrat::Selenium::Matchers)
#
#require 'webrat/core/matchers'
#
require File.expand_path(File.dirname(__FILE__) + '/jira_links_formatter')

#require 'bumps'
#
#Bumps.configure { use_server 'http://localhost:1981'
#  format_results_with(JiraLinksFormatter)
#}

#for selenium support w/o webrat until I can figure out what's going on with
#https://webrat.lighthouseapp.com/projects/10503/tickets/214-cucumber-selenium_webrat-example-completely-failing
#copied the below out of cucumber/examples/selenium/features/support/env.rb

require 'spec/expectations'
require 'selenium'

# "before all"
browser = Selenium::SeleniumDriver.new("localhost", 4444, "*chrome", "http://localhost", 15000)

Before do
  @browser = browser
  @browser.start
end

After do
  @browser.stop
end

# "after all"
at_exit do
  browser.close rescue nil
end