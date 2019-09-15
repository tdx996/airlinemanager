RSpec.configure do |config|
    config.include FactoryBot::Syntax::Methods
    config.include Devise::TestHelpers, type: :controller
    config.include ApplicationHelper
    # config.include Devise::Test::ControllerHelpers, type: :controller
    # config.extend ControllerMacros, type: :controller
end