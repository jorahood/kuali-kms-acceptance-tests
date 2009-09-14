require 'spec'

# Comment out the next line if you don't want Cucumber Unicode support
require 'cucumber/formatter/unicode'

require 'webrat/selenium'
require 'cucumber/webrat/element_locator' # Lets you do table.diff!(element_at('#my_table_or_dl_or_ul_or_ol').to_table)

Webrat.configure do |config|

  config.mode = :selenium

end

require 'webrat/core/matchers'

require 'bumps'

require File.expand_path(File.dirname(__FILE__) + '/jira_links_formatter')

Bumps.configure { use_server 'http://localhost:1981'
                  format_results_with(JiraLinksFormatter)
                  }
