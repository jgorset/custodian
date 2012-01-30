require "custodian"

describe Custodian::Samplers do

  before do
    Custodian::Samplers.clear
  end
  
  after do
    Custodian::Samplers.stock
  end
  
  it "can list samplers" do
    Custodian::Samplers.list.must_be_instance_of Array
  end

  it "can list compatible samplers" do
    Custodian::Samplers.compatible.must_be_instance_of Array
  end

  it "can list incompatible samplers" do
    Custodian::Samplers.incompatible.must_be_instance_of Array
  end

  it "can register new samplers" do
    Custodian::Samplers::register Custodian::Samplers::CPU

    Custodian::Samplers.list.must_include Custodian::Samplers::CPU
  end

  it "can remove samplers" do
    Custodian::Samplers::remove Custodian::Samplers::CPU

    Custodian::Samplers.list.wont_include Custodian::Samplers::CPU
  end

  it "can replace samplers" do
    Custodian::Samplers.register Custodian::Samplers::CPU
    Custodian::Samplers.replace Custodian::Samplers::CPU, Custodian::Samplers::RAM

    Custodian::Samplers.list.must_include Custodian::Samplers::RAM
    Custodian::Samplers.list.wont_include Custodian::Samplers::CPU
  end

end
