require "custodian"

describe Custodian do
  
  it "has a version" do
    Custodian::VERSION.should be_an_instance_of String
  end
  
end