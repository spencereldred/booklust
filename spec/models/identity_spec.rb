require 'spec_helper'

describe Identity do
  let (:identity) {Identity.create(name: "Tobey Henderson", email: "test@tester.com") }
  describe 'should have a(n)' do
    it 'name' do
      identity.respond_to?(:name).should == true
    end

    it 'email' do
      identity.respond_to?(:email).should == true
    end
  end

  describe 'should NOT be nil' do
    it 'name' do
      identity.name.should_not == nil
    end

    it 'email' do
      identity.email.should_not == nil
    end
  end

  describe 'validation' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should_not allow_value("test@test").for(:email) }
    it { should_not allow_value("test").for(:email) }
    it { should allow_value("test@test.com").for(:email) }

  end
end