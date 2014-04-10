require 'spec_helper'

describe Neighborhood do
  it { should have_many(:artifacts) }
end
