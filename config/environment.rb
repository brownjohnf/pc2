# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
OmniauthDemo::Application.initialize!

ActiveSupport::Inflector.inflections do |inflect|
#  inflect.irregular 'foo', 'fooze'
  inflect.uncountable ['feedback', 'staff', 'static']
end
