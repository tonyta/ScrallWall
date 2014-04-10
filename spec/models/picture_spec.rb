require 'spec_helper'

describe Picture do
  it { should belong_to(:user) }
  it { should belong_to(:artifact) }

  it { should have_many(:votes) }
  it { should have_many(:flags) }
end
