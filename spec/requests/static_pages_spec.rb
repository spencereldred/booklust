require 'spec_helper'

describe "StaticPages" do

  describe "Landing page" do
    before { visit root_path }

    it "should have the content 'Connecting you with books you'll love.'" do
      expect(page).to have_content("Connecting you with books you'll love.")
    end

    it "should have title 'Booklust'" do
      expect(page).to have_title('Booklust')
    end

    it "should have the logo 'Booklust'" do
      expect(page).to have_content('Booklust')
    end

    it "should have the content Sign In" do
      expect(page).to have_content('Sign In')
    end

    it "should NOT have the content 'Sign Up'" do
      (page).should_not have_content('Sign Up')
    end

  end

  describe "Booklust landing page" do
    # before { current_user == true }
    before { visit booklusts_path }

    it "should have the content 'Booklust'" do
      expect(page).to have_content('Booklust')
    end

  end

end
