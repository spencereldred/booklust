require 'spec_helper'

describe "StaticPages" do

  describe "Landing page" do
    before { visit root_path }

    it "should have the content 'sessions#new'" do
      expect(page).to have_content('sessions#new')
    end

    it "should have title 'BookLust'" do
      expect(page).to have_title('BookLust')
    end

    it "should have the content Sign In" do
      expect(page).to have_content('Sign In')
    end

    it "should have the content Sign Up" do
      expect(page).to have_content('Sign Up')
    end



  end

  # describe "BookLust page" do
  #   before { current_user == true }
  #   before { visit booklusts_path }

  #   it "should have the content 'Booklust!'" do
  #     expect(page).to have_content('Booklust!')
  #   end

  #   it "should have title 'OmniAuth Example'" do
  #     expect(page).to have_title('OmniAuth Example')
  #   end

  #   it "should have the content Log Out" do
  #     expect(page).to have_content('Log Out')
  #   end

  # end

end
