require 'spec_helper'

describe Vote do
  it { should belong_to(:user) }
  it { should belong_to(:votable) }
end
