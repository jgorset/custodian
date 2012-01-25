require "custodian"
require "helpers"

describe Custodian::Report do

  before do
    @reports = Custodian::Samplers.sample
  end

  it "has a name" do
    @reports.first.name
  end

  it "has a value" do
    @reports.first.value
  end

end
