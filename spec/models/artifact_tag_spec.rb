require 'spec_helper'

describe ArtifactTag do
  it { should belong_to(:tag) }
  it { should belong_to(:artifact) }
  it { should belong_to(:user) }
end
