require "custodian"
require "samplers/helpers"

describe Custodian::Samplers::Who do

  it "samples load average" do
    Custodian::Samplers::Load.new.sample.should eq load_average
  end

end
