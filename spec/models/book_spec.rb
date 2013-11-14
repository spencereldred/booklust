require 'spec_helper'

describe Book do
  describe 'relationship to other models:' do
    it "should have many users" do
      b = Book.reflect_on_association(:users)
      b.macro.should == :has_many
    end
    it "should have many lists" do
      b = Book.reflect_on_association(:lists)
      b.macro.should == :has_many
    end
  end

    # it { should validate_uniqueness_of(:isbn10, :isbn13) }

end
