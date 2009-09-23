require 'spec/expectations'


# Comment out the next line if you don't want Cucumber Unicode support
require 'cucumber/formatter/unicode'
require 'webrat'
require 'webrat/core/matchers'
require 'cucumber/webrat/element_locator' # Lets you do table.diff!(element_at('#my_table_or_dl_or_ul_or_ol').to_table)


Webrat.configure do |config|

  config.mode = :mechanize
#  config.mode = :selenium
#  config.selenium_server_address = 'localhost'
  config.application_framework = :external

end

#World do
#  session = Webrat::SeleniumSession.new
#  session.extend(Webrat::Methods)
#  session.extend(Webrat::Selenium::Methods)
#  session.extend(Webrat::Matchers)
#  session.extend(Webrat::Selenium::Matchers)
#  session
#end

World do
  session = Webrat::MechanizeAdapter.new
  session.extend(Webrat::Methods)
  session.extend(Webrat::Matchers)
  session.extend(Webrat::HaveTagMatcher)
  session
end

#class MechanizeWorld < Webrat::MechanizeAdapter
#  include Webrat::Matchers
#  include Webrat::Methods
#end
#
#World do
#  MechanizeWorld.new
#end
#
require File.expand_path(File.dirname(__FILE__) + '/jira_links_formatter')

#require 'bumps'
#
#Bumps.configure { use_server 'http://localhost:1981'
##  format_results_with(JiraLinksFormatter)
#}
