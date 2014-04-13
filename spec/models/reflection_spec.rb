require 'spec_helper'

describe Reflection do
  it { should belong_to(:user) }
  it { should belong_to(:artifact) }

  it { should have_many(:flags) }
end
