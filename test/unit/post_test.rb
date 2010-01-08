require 'test_helper'

class PostTest < ActiveSupport::TestCase
  should_validate_presence_of :name, :content
end
