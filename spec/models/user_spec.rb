require 'spec_helper'

describe User do
  it { should have_many(:favs) }

  it { should have_many(:artifact_tags) }

  it { should have_many(:pictures) }
  it { should have_many(:reflections) }

  it { should have_many(:votes) }
  it { should have_many(:flags) }
end
