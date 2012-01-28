require "custodian"

describe Custodian::Samplers::Sampler do

  before do
    @sampler = Custodian::Samplers::Sampler
  end

  it "can be described" do
    @sampler.description.should equal nil
  end
  
  it "can determine whether its compatible" do
    @sampler.should be_compatible
  end

end
