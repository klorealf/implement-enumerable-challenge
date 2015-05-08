require_relative "../my_enumerable"
require_relative "../my_array"

require_relative "support/my_enumerable_behaviors"
require_relative "support/my_array_enumerable_behavior_test_setup"

RSpec.configure do
  include MyArrayEnumerableBehaviorTestSetup
end
