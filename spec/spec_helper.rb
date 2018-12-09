require "bundler/setup"
require "pry"
require "pry-byebug"

require "integral/corrector"

RSpec.configure do |config|
  config.color = true
  config.order = "random"

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.formatter = ENV["CI"] == "true" ? :progress : :documentation
  config.disable_monkey_patching!
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "./tmp/rspec-status.txt"

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
end
