require 'spec_helper'

describe "StaticPages" do

  describe "Landing page" do

    it "should have the content 'sessions#new'" do
      visit root_path
      expect(page).to have_content('sessions#new')
    end
  end

  describe "BookLust page" do
    it "should have the content 'Booklust!'" do
      visit booklusts_path
      expect(page).to have_content('Booklust!')
    end

  end
end
