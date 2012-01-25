require "custodian"
require "samplers/helpers"

describe Custodian::Samplers::Sampler do

  before do
    @sampler = Custodian::Samplers::Sampler.new
  end

  it "can't sample" do
    expect { @sampler.sample }.to raise_error NotImplementedError
  end

end
