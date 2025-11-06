source 'https://rubygems.org'

gemspec

minimum_version =
  case ENV['TEST_RAILS_VERSION']
  when "7.2"
    "~>7.2.1"
  when "7.1"
    "~>7.1.4"
  else
    "~>7.0.8"
  end
gem "activerecord", minimum_version

# sqlite3 doesn't bundle properly with Rails 7.0 or less.
gem "sqlite3", "< 3"
