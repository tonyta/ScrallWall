require 'spec_helper'

describe User do
  it { should have_many(:favs) }
  it { should have_many(:favorites).through(:favs).source(:artifact_id) }

  it { should have_many(:artifact_tags) }

  it { should have_many(:pictures) }
  it { should have_many(:reflections) }

  it { should have_many(:votes) }
  it { should have_many(:flags) }

  describe 'username validations' do
    it {should validate_presence_of(:username)}
    it {should validate_uniqueness_of(:username)}
  end

  describe 'first_name and last_name validations' do
    it {should validate_presence_of(:first_name)}
    it { should ensure_length_of(:first_name).is_at_least(2).is_at_most(12) }
    it { should ensure_length_of(:last_name).is_at_least(2).is_at_most(12) }
  end

  describe 'email validations' do
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should allow_value('greg@sucks.com').for(:email)}
    it {should_not allow_value('greg.sucks.com').for(:email)}
    it {should_not allow_value('greg@@sucks.com').for(:email)}
    it {should_not allow_value('').for(:email)}
  end

  describe 'bio validations' do
    it { should ensure_length_of(:bio).is_at_most(100) }
  end
end
