require 'spec_helper'

describe User do
  before { @user = User.new(first_name: "Test", 
                            last_name: "User", 
                            email: "test@test.com",
                            password: "password",
                            password_confirmation: "password") }
  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:password_digest) }

  it { should be_valid }

  describe "when a name is invalid" do
    describe "when first name is not present" do
      before { @user.first_name = " " }
      it { should_not be_valid }
    end

    describe "when first name is too long" do
      before { @user.first_name = "a" * 51 }
      it { should_not be_valid }
    end

    describe "when last name is not present" do
      before { @user.last_name = " " }
      it { should_not be_valid }
    end

    describe "when last name is too long" do
      before { @user.last_name = "a" * 51 }
      it { should_not be_valid }
    end
  end

  describe "when a password is invalid" do
    describe "when a password is not present" do
      before { @user.password = @user.password_confirmation = " " }
      it { should_not be_valid }
    end

    describe "when the password does not match the password_confirmation" do
      before { @user.password_confirmation = "mismatch" }
      it { should_not be_valid }
    end

    describe "when a password is nil" do
      before { @user.password_confirmation = "nil" }
      it { should_not be_valid }
    end

    describe "when a password is too short" do
      before { @user.password = @user.password_confirmation = "a" * 5 }
      it { should_not be_valid }
    end

    describe "return value of authenticate method" do
      before { @user.save }
      let(:found_user) { User.find_by_email(@user.email) }

      describe "with invalid password" do
        let(:user_for_invalid_password) { found_user.authenticate("invalid") }
        it { should_not == user_for_invalid_password }
        specify { user_for_invalid_password.should be_false }
      end
    end
  end

  describe "when a password is valid" do
    describe "return value of authenticate method" do
      before { @user.save }
      let(:found_user) { User.find_by_email(@user.email) }

      describe "with valid password" do
        it { should == found_user.authenticate(@user.password) }
      end
    end
  end

  describe "when an email is invalid" do
    describe "when email format is invalid" do
      it "should be invalid" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
        addresses.each do |invalid_address|
          @user.email = invalid_address
          @user.should_not be_valid
        end
      end
    end

    describe "when an email address is taken" do
      before do
        user_with_same_email = @user.dup
        user_with_same_email.email = @user.email.upcase
        user_with_same_email.save
      end

      it { should_not be_valid }
    end
   
    describe "when email is not present" do
        before { @user.email = " " }
        it { should_not be_valid }
    end  
  end

  describe "when an email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM a_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end
end