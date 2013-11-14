require 'spec_helper'

describe BookUser do
  let(:book_user) { BookUser.create(book_id: 3, user_id: 5) }

  it 'should have a book_id' do
    book_user.respond_to?(:book_id).should == true
  end

  it 'should have a user_id' do
    book_user.respond_to?(:user_id).should == true
  end

  it 'should not be nil' do
    book_user.should_not == nil
  end

  it "should validate user_id" do
    should validate_presence_of :user_id
  end

  it "should validate user_id" do
    should validate_presence_of :book_id
  end

  it "should belong to book" do
    should belong_to(:book)
  end

  it "should belong to user" do
    should belong_to(:user)
  end


end
