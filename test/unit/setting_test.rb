require 'test_helper'

class SettingTest < ActiveSupport::TestCase
  should_validate_presence_of :name, :value
  
  context "validating uniqueness" do
    setup do
      Factory :setting
    end
    
    should_validate_uniqueness_of :name
  end
end
