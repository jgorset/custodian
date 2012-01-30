require "custodian"
require "minitest/spec"
require "minitest/autorun"

describe Custodian::Samplers::Sampler do

  before do
    @sampler = Custodian::Samplers::Sampler
  end

  it "can sample" do
    @sampler.sample
  end

  it "can be described" do
    @sampler.description.must_equal nil
  end

  it "can determine whether its compatible" do
    @sampler.compatible?.must_equal true
  end

end
