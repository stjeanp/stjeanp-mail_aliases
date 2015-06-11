require 'rubygems'
require 'puppetlabs_spec_helper/module_spec_helper'
require 'coveralls'

Coveralls.wear!

RSpec.configure do |config|
  config.hiera_config = 'spec/fixtures/hiera/hiera.yaml'

  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end
