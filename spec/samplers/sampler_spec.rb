require "custodian"
require "samplers/helpers"

describe Custodian::Samplers::Sampler do

  before do
    @sampler = Custodian::Samplers::Sampler
  end

  it "can be described" do
    @sampler.description.should equal nil
  end

end
