require 'spec_helper'

describe Neighborhood do
  it { should have_many(:artifacts) }
  it {should validate_presence_of(:name)}
end
