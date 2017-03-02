source ENV['GEM_SOURCE'] || "https://rubygems.org"

puppet_version = ENV.key?('PUPPET_VERSION') ? ENV['PUPPET_VERSION'] : '~> 4.4'

group :development, :test do
  gem 'rake', '>= 12.0.0'
  gem 'rspec-puppet',            :require => false
  gem 'puppetlabs_spec_helper',  :require => false
  gem 'metadata-json-lint',      :require => false
  gem 'puppet-lint',             :require => false
end

if facterversion = ENV['FACTER_GEM_VERSION']
  gem 'facter', facterversion, :require => false
else
  gem 'facter', :require => false
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end

if hieraversion = ENV['HIERA_GEM_VERSION']
  gem 'hiera', hieraversion, :require => false
else
  gem 'hiera', :require => false
end

# vim:ft=ruby
