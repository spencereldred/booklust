require 'spec_helper'

describe BestSellerListBook do
  let(:best_seller_list_book) {BestSellerListBook.create(book_id: 3, best_seller_list_id: 5, rank: 18, number_weeks: 62)}

  describe 'should have a:' do
    it 'book id' do
      best_seller_list_book.respond_to?(:book_id).should == true
    end

    it 'book seller list id' do
      best_seller_list_book.respond_to?(:best_seller_list_id).should == true
    end

    it 'rank' do
      best_seller_list_book.respond_to?(:rank).should == true
    end

    it 'record of the number of weeks' do
      best_seller_list_book.should respond_to(:number_weeks)
    end
  end

  describe 'should NOT have a:' do
    it 'book id of nil' do
      best_seller_list_book.should_not == nil
    end

    it 'book seller list id of nil' do
      best_seller_list_book.should_not == nil
    end

    it 'rank of nil' do
      best_seller_list_book.should_not == nil
    end

    it 'nil record of the number of weeks' do
      best_seller_list_book.should_not == nil
    end
  end


  describe 'should validate the presence of:' do
    it ':book_id' do
      should validate_presence_of :book_id
    end

    it ':best_seller_list_id' do
      should validate_presence_of :best_seller_list_id
    end

    it ':rank' do
      should validate_presence_of :rank
    end
  end

  describe "relationship to other models" do
    it 'is a join table that belongs to :book' do
      should belong_to(:book)
    end

    it 'is a join table that belongs to :best_seller_list' do
      should belong_to(:best_seller_list)
    end
  end
end

