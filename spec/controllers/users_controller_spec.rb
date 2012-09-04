require 'spec_helper'
describe UsersController do
  render_views

  describe "GET index" do
    it "should get the index page" do
      get :index
      response.should be_success
    end
  end
end
