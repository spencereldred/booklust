require 'spec_helper'

describe BestSellerListBook do
  let(:best_seller_list_book) {BestSellerListBook.create(book_id: 3, best_seller_list_id: 5, rank: 18, number_weeks: 62)}
  it 'should have a book id' do
    best_seller_list_book.respond_to?(:book_id).should == true
  end
  it 'should not have a book id of nil' do
    best_seller_list_book.should_not == nil
  end
  it 'should have a book seller list id' do
    best_seller_list_book.respond_to?(:best_seller_list_id).should == true
  end
  it 'should not have a book seller list id of nil' do
    best_seller_list_book.should_not == nil
  end
  it 'should have a rank' do
    best_seller_list_book.respond_to?(:rank).should == true
  end
  it 'should not have a rank of nil' do
    best_seller_list_book.should_not == nil
  end
  it 'should have a record of the number of weeks' do
    best_seller_list_book.should respond_to(:number_weeks)
  end
  it 'should not have a nil record of the number of weeks' do
    best_seller_list_book.should_not == nil
  end

  it 'should validate presence of :book_id' do
    should validate_presence_of :book_id
  end

  it 'should validate presence of :best_seller_list_id' do
    should validate_presence_of :best_seller_list_id
  end

  it 'should validate presence of :rank' do
    should validate_presence_of :rank
  end

end

describe "BestSellerListBook as a join table" do
  it 'is a join table that belongs to :book' do
    b = BestSellerListBook.reflect_on_association(:book)
    b.macro.should == :belongs_to
  end

  it 'is a join table that belongs to :best_seller_list' do
    b = BestSellerListBook.reflect_on_association(:best_seller_list)
    b.macro.should == :belongs_to
  end
end