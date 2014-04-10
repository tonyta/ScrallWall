require 'spec_helper'

describe Flag do
  it { should belong_to(:user) }
  it { should belong_to(:flaggable) }
end
