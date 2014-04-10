require 'spec_helper'

describe Fav do
  it{ should belong_to(:user) }
  it{ should belong_to(:artifact) }
end
