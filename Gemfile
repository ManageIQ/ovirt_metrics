source 'https://rubygems.org'

gemspec

minimum_version =
  case ENV['TEST_RAILS_VERSION']
  when "6.0"
    "~>6.0.4"
  when "7.0"
    "~>7.0.8"
  else
    "~>6.1.4"
  end

gem "activerecord", minimum_version

# sqlite3 doesn't bundle properly with Rails 7.0 or less.
gem "sqlite3", "< 2"
