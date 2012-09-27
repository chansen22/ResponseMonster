require 'spec_helper'

describe UsersController do
  render_views
  before { @user = User.create!(first_name: "Test",
                                last_name: "User", 
                                email: "test@test.com",
                                password: "password",
                                password_confirmation: "password" ) }
  subject { @user }

  describe "GET index" do
    before { @user.admin = false }
    it "should redirect to root_path" do
      get :index
      response.should_not be_success
    end
  end

  describe "GET index as admin" do
    before(:each) do
      @user.admin = true
      test_sign_in(@user)
    end
    it "should get the index page" do
      get :index
      response.should be_success
    end
  end
end
