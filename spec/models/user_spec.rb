require 'spec_helper'

describe User do
  let(:user) { User.create(name: "Spencer", uid: "1", provider: "identity") }

  describe "should have a:" do

    it 'name' do
      user.respond_to?(:name).should == true
    end

    it 'provider' do
      user.respond_to?(:provider).should == true
    end

    it 'uid' do
      user.respond_to?(:uid).should == true
    end

  end

  it 'should not be nil' do
    user.should_not == nil
  end

  describe "should have specific:" do

    it 'name' do
      user.name.should == "Spencer"
    end

    it 'uid' do
      user.uid.should == "1"
    end

    it 'provider' do
      user.provider.should == "identity"
    end

  end

  describe "should not be valid when:" do

    it "name is not present" do
      user.name = " "
      user.should_not be_valid
    end

    it "uid is not present" do
      user.uid = " "
      user.should_not be_valid
    end

    it "provider is not present" do
      user.provider = " "
      user.should_not be_valid
    end

    it 'all attributes are not provided' do
      new_user = User.new
      new_user.should_not be_valid
    end
  end

  describe "should validate presence of:" do
    it "name" do
      should validate_presence_of :name
    end
    it "uid" do
      should validate_presence_of :uid
    end
    it "provider" do
      should validate_presence_of :provider
    end
  end

end

