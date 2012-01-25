require "custodian"
require "helpers"

describe Custodian::Report do

  before do
    @reports = Custodian::Samplers.sample
  end

  it "serializes to a hash" do
    @reports.first.to_hash
  end

end
