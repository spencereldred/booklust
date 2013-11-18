require 'spec_helper'

describe BookUsersController do

  describe "if not a current user, it will redirect" do
    it "responds successfully with an HTTP 302 status code" do
      get :index
      expect(response.status).to eq(302)
    end
  end

end
