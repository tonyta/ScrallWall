require 'spec_helper'

describe Tag do
  it { should have_many(:artifact_tags) }
  it { should have_many(:artifacts).through(:artifact_tags) }

  describe "tag validations" do
    it { should validate_presence_of(:name)}
  end

end
