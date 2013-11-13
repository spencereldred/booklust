require 'spec_helper'

describe BestSellerList do
  it 'should have a week' do
    week_test = BestSellerList.create(week: '2013-10-20')
    week_test.respond_to?(:week).should == true
    week_test.week.should_not == nil
  end
  it 'should have a category' do
    category_test = BestSellerList.create(category: 'trade-fiction-paperback')
    category_test.respond_to?(:category).should == true
    category_test.category.should_not == nil
  end
  it 'should have a list_source' do
    list_source_test = BestSellerList.create(list_source: 'New York Times')
    list_source_test.respond_to?(:list_source).should == true
    list_source_test.list_source.should_not == nil
  end

  it 'should validate presence of :list_source' do
    should validate_presence_of :list_source
  end

  it 'should validate presence of :category' do
    should validate_presence_of :category
  end

  it 'should validate presence of :week' do
    should validate_presence_of :week
  end

  # it { should have_many(:books).through(:best_seller_list_book) }


end
