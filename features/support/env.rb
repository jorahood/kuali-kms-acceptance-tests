require 'spec/expectations'


# Comment out the next line if you don't want Cucumber Unicode support
require 'cucumber/formatter/unicode'

require 'webrat'
require 'webrat/core/matchers'
require 'cucumber/webrat/element_locator' # Lets you do table.diff!(element_at('#my_table_or_dl_or_ul_or_ol').to_table)


Webrat.configure do |config|

  config.mode = :selenium
  config.selenium_server_address = 'localhost'
  config.application_framework = :external

end
World(Webrat::Methods)
World(Webrat::Selenium::Methods)

#this is necessary to have webrat “wait_for” the response body to be available
#when writing steps that match against the response body returned by selenium
World(Webrat::Selenium::Matchers) #mix into Cucumber's World obj

require File.expand_path(File.dirname(__FILE__) + '/jira_links_formatter')

#require 'bumps'
#
#Bumps.configure { use_server 'http://localhost:1981'
##  format_results_with(JiraLinksFormatter)
#}
