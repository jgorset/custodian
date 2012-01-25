class Truth < Custodian::Samplers::Sampler
  caption = "The truth"

  def sample
    true
  end

end

class Falsehood < Custodian::Samplers::Sampler
  caption = "Not the truth"

  def sample
    false
  end

end
