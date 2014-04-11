require 'spec_helper'

describe Reflection do
  it { should belong_to(:user) }
  it { should belong_to(:artifact) }

  it { should have_many(:votes) }
  it { should have_many(:flags) }

  describe "reflections validations" do
     it { should validate_presence_of(:text)}
     it { should ensure_length_of(:text).is_at_least(1) }
  end

end
