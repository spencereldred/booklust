require 'spec_helper'

describe User do
  let(:user) { User.create(name: "Spencer", uid: "1", provider: "identity") }

  it 'should have a name' do
    user.respond_to?(:name).should == true
  end

  it 'should have specified name' do
    user.name.should == "Spencer"
  end

  it 'should not be nil' do
    user.should_not == nil
  end

  it 'should have a uid' do
    user.respond_to?(:uid).should == true
  end
  it 'should have specified uid' do
    user.uid.should == "1"
  end

  it 'should have a provider' do
    user.respond_to?(:provider).should == true
  end

  it 'should have specified provider' do
    user.provider.should == "identity"
  end

  it "should validate presence of name" do
    should validate_presence_of :name
  end
  it "should validate presence of uid" do
    should validate_presence_of :uid
  end
  it "should validate presence of provider" do
    should validate_presence_of :provider
  end

end

