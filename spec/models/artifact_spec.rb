require 'spec_helper'

describe Artifact do
  it { should have_many(:artifact_tags) }
  it { should have_many(:tags).through(:artifact_tags) }

  it { should have_many(:favs) }
  it { should have_many(:favoritors).through(:favs).source(:user_id) }

  it { should have_many(:pictures) }
  it { should have_many(:reflections) }

  it { should belong_to(:neighborhood) }
end
