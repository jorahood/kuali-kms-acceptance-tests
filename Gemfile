source :gemcutter

gem "capybara"
gem  "cucumber"
gem "celerity", :group => :jruby
gem "culerity"
gem "rspec"

#the next step is to run bundle install, and then put this at the top of env.rb:

begin
  # Try to require the preresolved locked set of gems.
  require File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  # Fall back on doing an unlocked resolve at runtime.
  require "rubygems"
  require "bundler"
  Bundler.setup
end

# see http://github.com/carlhuda/bundler