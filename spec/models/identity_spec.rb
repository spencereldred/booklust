require 'spec_helper'

describe Identity do
  it 'should have a name' do
    identity = Identity.create(name: 'Tobey Henderson')
    identity.respond_to?(:name).should == true
    identity.name.should_not == nil
  end
  it 'should have an email' do
    identity = Identity.create(email: "test@test.com")
    identity.respond_to?(:email).should == true
    identity.email.should_not == nil
  end

  it { should validate_uniqueness_of(:email) }
end