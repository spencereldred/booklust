require 'spec_helper'

describe Book do
  let(:book) {Book.create(title: "ORPHAN TRAIN", author: "Christina Baker Kline", isbn10: "0061950726", isbn13: "9780061950728", asin: "0061950726", amazon_ref: "http://www.amazon.com/Orphan-Train-Christina-Baker-...", amazon_img: "http://ecx.images-amazon.com/images/I/419r94K6oCL.j...", img_height: "500", img_width: "332", price: "$14.99", description: "A historical novel about orphans swept off the stre...", publisher: "William Morrow Paperbacks")}

  describe 'should have a:' do
    it 'title' do
      book.respond_to?(:title).should == true
    end

    it 'author' do
      book.respond_to?(:author).should == true
    end

    it 'isbn10' do
      book.respond_to?(:isbn10).should == true
    end

    it 'isbn13' do
      book.should respond_to(:isbn13)
    end

    it 'asin' do
      book.respond_to?(:asin).should == true
    end

    it 'amazon_ref' do
      book.respond_to?(:amazon_ref).should == true
    end

    it 'amazon_img' do
      book.respond_to?(:amazon_img).should == true
    end

    it 'img_height' do
      book.should respond_to(:img_height)
    end

    it 'img_height' do
      book.respond_to?(:img_height).should == true
    end

    it 'price' do
      book.respond_to?(:price).should == true
    end

    it 'description' do
      book.respond_to?(:description).should == true
    end

    it 'publisher' do
      book.should respond_to(:publisher)
    end
  end


  describe 'relationship to other models:' do
    it "should have many users" do
      should have_many(:users)
    end

    it "should have many users through book_users" do
      should have_many(:users).through(:book_users)
    end

    it "should have many book_users" do
      should have_many(:book_users)
    end

    it "should have many best_seller_lists" do
      should have_many(:best_seller_lists)
    end

    it "should have many best_seller_lists through best_seller_list_book" do
      should have_many(:best_seller_lists).through(:best_seller_list_book)
    end

    it "should have many best_seller_list_book" do
      should have_many(:best_seller_list_book)
    end
  end


    # it { should validate_uniqueness_of(:isbn10, :isbn13) }

end

