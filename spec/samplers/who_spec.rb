require "custodian"
require "samplers/helpers"

describe Custodian::Samplers::Who do

  it "samples logged in users" do
    Custodian::Samplers::Who.new.sample.should eq logged_in_users
  end

end
