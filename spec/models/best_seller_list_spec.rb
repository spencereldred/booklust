require 'spec_helper'

describe BestSellerList do
  let(:best_seller_list) {BestSellerList.create(week: '2013-10-20', category: 'trade-fiction-paperback', list_source: 'New York Times')}

  describe 'should have a:' do
    it 'week' do
      best_seller_list.respond_to?(:week).should == true
    end

    it 'category' do
      best_seller_list.respond_to?(:category).should == true
    end

    it 'list_source' do
      best_seller_list.respond_to?(:list_source).should == true
    end

  end

  describe 'should NOT have a:' do
    it 'week of nil' do
      best_seller_list.week.should_not == nil
    end

    it 'category of nil' do
      best_seller_list.category.should_not == nil
    end

    it 'a list_source of nil' do
      best_seller_list.list_source.should_not == nil
    end
  end

  describe 'should validate:' do
    it 'presence of :list_source' do
      should validate_presence_of :list_source
    end

    it 'presence of :category' do
      should validate_presence_of :category
    end

    it 'presence of :week' do
      should validate_presence_of :week
    end
  end


  describe 'relationship to other models:' do
    it "should have many books" do
      b = BestSellerList.reflect_on_association(:books)
      b.macro.should == :has_many
    end

    # this test doesn't work:
  # it "should have many books through best_seller_list_book" do
  #  should have_many(:books).through(:best_seller_list_book)
  # end
  end


end
