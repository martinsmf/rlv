require "httparty"
require "digest/md5"

require_relative "routes/signup.rb"
require_relative "routes/session.rb"
require_relative "routes/equipos.rb"
require_relative "routes/base_api.rb"

require_relative "libs/mongo.rb"
require_relative "helpers.rb"

def to_md5(pass)
    return Digest::MD5.hexdigest(pass)
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:suite) do
    users = [
      {name: "Zoro", email: "zoro@onepiece.com", password: to_md5("teste123")},
      {name: "Luffy", email: "luffy@onepiece.com", password: to_md5("teste123")},
      {name: "Usop", email: "usop@onepiece.com", password: to_md5("teste123")},
      {name: "Nami", email: "nami@onepiece.com", password: to_md5("teste123")},
    ]

    MongoDB.new.drop_danger
    MongoDB.new.insert_users(users)
  end

end
