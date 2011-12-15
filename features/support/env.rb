require 'rspec/expectations'

#define a customer matcher
RSpec::Matchers.define :contain_once do |string|
  match do |page|
      # see documentation of Capybara::Node::Matchers#has_selector?
      page.has_selector?(:xpath, '*', :text => string, :count => 1)
  end

  failure_message_for_should do |page|
    "expected to see '#{string}' exactly once"
  end
end

World(RSpec::Matchers)

# Comment out the next line if you don't want Cucumber Unicode support
require 'cucumber/formatter/unicode'

require 'capybara/cucumber'
require 'capybara/session'
# Capybara defaults to XPath selectors rather than Webrat's default of CSS3. In
# order to ease the transition to Capybara we set the default here. If you'd
# prefer to use XPath just remove this line and adjust any selectors in your
# steps to use the XPath syntax.
Capybara.default_selector = :css
Capybara.default_driver = :selenium
Capybara.default_wait_time = 10
Capybara.app_host = "https://test.uisapp2.iu.edu"
Capybara.run_server = false # to keep Capybara from starting a Rack server
require 'bumps'

Bumps.configure do
  pull_from 'https://wiki.kuali.org/createrssfeed.action?types=page&spaces=KITS&labelString=acceptancetest&maxResults=2000&timeSpan=10000&showContent=true&showDiff=false'
end

# monkey-patches to Bumps to let it parse features from Confluence and to make it not push results
module Bumps
  class RemoteFeature
    # hacked to parse Confluence-formatted user stories rather than JSON, which Bumps 0.1.1 has moved to
    def self.parse xml
      document = Nokogiri::XML xml
      document.search('entry').collect do |entry|
        name = entry.search('title').text
        dashed_name = name.gsub(/\s+/, "-")
        # gsub the living hell out of the document from Confluence
        feature = entry.search('summary').text
        content = feature.
          gsub(/<(td|th)[^>]*>/,"|").             # replace td and th with vertical bars, which cuke understands
          gsub(/<\/tr[^>]*>\n?/,"|").             # replace tr with vertical bars, i.e., cuke tables
          gsub(/<(\/td|\/th|tbody)[^>]*>\n?/,""). # remove td and th close tags and tbody
          gsub(/<\/?[^>]*>/, "").
          gsub(/&nbsp;/, " ").
          gsub(/[^<]\!/,"|").                     # I think I can delete this line since tables are handled above
          gsub(/&#91;/, "[").
          gsub(/&#93;/, "]").
          gsub(/&lt;/,"<").
          gsub(/&gt;/,">").
          gsub(/&quot;/,'"').
          sub(/^.*?Feature:/m,"Feature:").
          sub(/^\s*View Online/,"")               # remove "view online" link

        Feature.new(dashed_name, content)
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

if ENV["SELENIUM_HEADLESS"] == 'true'

  require "headless"
  Before('@selenium') do
    @headless = Headless.new
    @headless.start
  end

  After('@selenium') do
    @headless.destroy if @headless.present?
  end
end