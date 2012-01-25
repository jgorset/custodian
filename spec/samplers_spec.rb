require "custodian"
require "helpers"

describe Custodian::Samplers do

  it "can list samplers" do
    Custodian::Samplers.list.should be_an_instance_of Array
  end

  it "can register new samplers" do
    Custodian::Samplers::register(Truth)

    Custodian::Samplers.list.should include Truth
  end

  it "can remove samplers" do
    Custodian::Samplers::remove(Truth)

    Custodian::Samplers.list.should_not include Truth
  end

  it "can replace samplers" do
    Custodian::Samplers.register(Truth)
    Custodian::Samplers.replace(Truth, Falsehood)

    Custodian::Samplers.list.should_not include Truth
    Custodian::Samplers.list.should include Falsehood
  end

  it "can sample" do
    Custodian::Samplers.sample.each do |report|
      report.should be_an_instance_of Custodian::Report
    end
  end

end
