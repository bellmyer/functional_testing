Factory.define :setting do |s|
  s.sequence(:name) {|i| "Name #{i}"}
  s.value           "Value"
end
