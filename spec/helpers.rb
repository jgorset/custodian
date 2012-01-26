class Truth < Custodian::Samplers::Sampler
  describe "The truth"

  def sample
    true
  end

end

class Falsehood < Custodian::Samplers::Sampler
  describe "Not the truth"

  def sample
    false
  end

end
