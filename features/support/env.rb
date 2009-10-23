require 'spec/expectations'

# Comment out the next line if you don't want Cucumber Unicode support
require 'cucumber/formatter/unicode'
require 'webrat'
require 'cucumber/webrat/element_locator' # Lets you do table.diff!(element_at('#my_table_or_dl_or_ul_or_ol').to_table)


Webrat.configure do |config|

  config.mode = :mechanize
  #  config.mode = :selenium
  #  config.selenium_server_address = 'localhost'
  config.application_framework = :external

end

# create World for Selenium:
#World do
#  session = Webrat::SeleniumSession.new
#  session.extend(Webrat::Methods)
#  session.extend(Webrat::Selenium::Methods)
#  session.extend(Webrat::Matchers)
#  session.extend(Webrat::Selenium::Matchers)
#  session
#end

# create World for Mechanize
World do
  session = Webrat::MechanizeAdapter.new
  session.extend(Webrat::Methods)
  session.extend(Webrat::Matchers)
  session.extend(CustomMatchers)
  session
end

#require File.expand_path(File.dirname(__FILE__) + '/jira_links_formatter')

require 'bumps'

Bumps.configure do
  pull_from 'https://uisapp2.iu.edu/confluence-prd//createrssfeed.action?types=page&sort=modified'+ 
    '&showContent=true&spaces=Sage&labelString=acceptancetest&rssType=atom&maxResults=1000' + 
    '&timeSpan=1000&publicFeed=true&title=Sage+Features+Automated+Acceptance+Tests&showDiff=false'
end

# monkey-patches to Bumps to let it parse features from Confluence and to make it not push results
module Bumps
  class RemoteFeature
  # hacked to parse Confluence-formatted user stories
    def self.parse xml
      document = Nokogiri::XML xml
      document.search('summary').collect do |feature_element|
        feature = Feature.new
        feature.content = feature_element.text.gsub(/<\/?[^>]*>/, "").gsub(
          /&nbsp;/, " ").gsub(/\!/,"|").gsub(/&#91;/, "[").gsub(/&#93;/, "]").sub(
          /^.*?Feature:/m,"Feature:").sub(/^\s*View Online/,"")
        feature.name = /Feature:\s*([\w ]+)/.match(feature.content)[1].gsub(/\s+/, "_") + '.feature' || '???'
        feature
      end
    end
  end

  class CucumberConfig

    def process!
      validate
      update_bumps_config
      # register_formatter # commenting this out stops the push formatter from
      # being appended to cucumbers' options array, so no pushing
    end
  end
end
