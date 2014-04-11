require 'spec_helper'

describe Location do
  it { should have_many(:artifacts) }
end
