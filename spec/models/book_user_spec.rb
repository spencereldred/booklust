require 'spec_helper'

describe BookUser do
  let(:book_user) { BookUser.create(book_id: 3, user_id: 5, vote: 1, purchased: false, read: true, star_rating: 4, bucket: "favorites") }

  describe "shoule have a:" do

    it 'book_id' do
      book_user.respond_to?(:book_id).should == true
    end

    it 'user_id' do
      book_user.respond_to?(:user_id).should == true
    end

    it 'vote' do
      book_user.respond_to?(:vote).should == true
    end

    it 'purchased' do
      book_user.respond_to?(:purchased).should == true
    end

    it 'read' do
      book_user.respond_to?(:read).should == true
    end

    it 'star_rating' do
      book_user.respond_to?(:star_rating).should == true
    end

    it 'bucket' do
      book_user.respond_to?(:bucket).should == true
    end
  end

  it 'should not be nil' do
    book_user.should_not == nil
  end

  describe "should not be valid when:" do

    it "book_id is not present" do
      book_user.book_id = " "
      book_user.should_not be_valid
    end

    it "user_id is not present" do
      book_user.user_id = " "
      book_user.should_not be_valid
    end


    it 'all needed attributes (user_id and book_id) are not provided' do
      new_book_user = BookUser.new
      new_book_user.should_not be_valid
    end
  end

  describe "should validate: " do

    it "user_id" do
      should validate_presence_of :user_id
    end

    it "book_id" do
      should validate_presence_of :book_id
    end
  end

  describe "should have a specified: " do

    it "user_id" do
      book_user.user_id.should == 5
    end

    it "book_id" do
      book_user.book_id.should == 3
    end
  end

  describe "should belong to: " do

    it "book" do
      should belong_to(:book)
    end

    it "user" do
      should belong_to(:user)
    end
  end

  # describe "validates range for star_rating" do
    # it {should ensure_inclusion_of(:star_rating).in_array[] }
    # it { should allow_value(1).for(:star_rating) }
    # it { should allow_value(2).for(:star_rating) }
    # it { should allow_value(3).for(:star_rating) }
    # it { should allow_value(4).for(:star_rating) }
    # it { should allow_value(5).for(:star_rating) }
    # it { should ensure_inclusion_of(:star_rating).in_range(1..5) }


    # it {expect(:star_rating).to cover(2)}
    # it {expect(:star_rating).to cover(3)}
    # it {expect(:star_rating).to cover(4)}
    # it {expect(:star_rating).to cover(5)}

    # it { should_not cover(0) }
    # it { should_not cover(6
    # it { should_not cover (12) }
  # end

end
