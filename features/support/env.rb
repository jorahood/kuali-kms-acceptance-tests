require 'spec/expectations'

# Comment out the next line if you don't want Cucumber Unicode support
require 'cucumber/formatter/unicode'
require 'cucumber/web/tableish' # Lets you do table.diff!(element_at('#my_table_or_dl_or_ul_or_ol').to_table)

require 'capybara/cucumber'
require 'capybara/session'
# Capybara defaults to XPath selectors rather than Webrat's default of CSS3. In
# order to ease the transition to Capybara we set the default here. If you'd
# prefer to use XPath just remove this line and adjust any selectors in your
# steps to use the XPath syntax.
Capybara.default_selector = :css
Capybara.default_driver = :culerity
Capybara.app_host = "http://cowhorn.uits.indiana.edu:8080"
Capybara.run_server = false # to keep Capybara from starting a Rack server
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

        feature.content = feature_element.text.gsub(/<(td|th)[^>]*>/,"|").gsub(
          /<\/tr[^>]*>\n?/,"|").gsub(/<(\/td|\/th|tbody)[^>]*>\n?/,"").gsub(/<\/?[^>]*>/, "").gsub(
          /&nbsp;/, " ").gsub(/\!/,"|").gsub(/&#91;/, "[").gsub(/&#93;/, "]").gsub(
          /&lt;/,"<").gsub(/&gt;/,">").gsub(/&quot;/,'"').sub(
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
