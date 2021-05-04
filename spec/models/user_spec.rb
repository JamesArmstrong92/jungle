require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it "creates a new user given a first & last name, email, password, and valid password confirmation" do
      @user = User.new(
        first_name: "Jim", last_name: "Bo", email: "jim@live.ca", password: "jimbo", password_confirmation: "jimbo"
      )
      expect(@user).to be_valid
    end

    it "fails to create a new user if first name is not provided" do
      @user = User.new(
        first_name: nil, last_name: "Bo", email: "jim@live.ca", password: "jimbo", password_confirmation: "jimbo"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages_for(:first_name)).to include "First name can't be blank"
    end

    it "fails to create a new user if last name is not provided" do
      @user = User.new(
        first_name: "Jim", last_name: nil, email: "jim@live.ca", password: "jimbo", password_confirmation: "jimbo"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages_for(:last_name)).to include "Last name can't be blank"
    end

    it "fails to create a new user if email is not provided" do
      @user = User.new(
        first_name: "Jim", last_name: "Bo", email: nil, password: "jimbo", password_confirmation: "jimbo"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages_for(:email)).to include "Email can't be blank"
    end

    it "fails to create a new user if the given email is already taken (exact match)" do
      @user1 = User.new(
        first_name: "Jim", last_name: "Bo", email: "jim@live.ca", password: "jimbo", password_confirmation: "jimbo"
      )
      @user1.save
      @user2 = User.new(
        first_name: "Sam", last_name: "jones", email: "jim@live.ca", password: "jimbo", password_confirmation: "jimbo"
      )
      @user2.save
      expect(@user2).to be_invalid
      expect(@user2.errors.full_messages_for(:email)).to include("Email has already been taken")
    end

    it "fails to create a new user if password is not provided" do
      @user = User.new(
        first_name: "Jim", last_name: "Bo", email: "jim@live.ca", password: nil, password_confirmation: "jimbo"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages_for(:password)).to include "Password can't be blank"
    end

    it "fails to create a new user if password_confirmation is not provided" do
      @user = User.new(
        first_name: "Jim", last_name: "Bo", email: "jim@live.ca", password: "jimbo", password_confirmation: nil
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages_for(:password_confirmation)).to include "Password confirmation can't be blank"
    end

    it "fails to create a new user if password and password_confirmation do not match" do
      @user = User.new(
        first_name: "Jim", last_name: "Bo", email: "jim@live.ca", password: "jimbo", password_confirmation: "jimbo1"
      @user.save
      expect(@user).to be_invalid
      expect(@user.errors.full_messages_for(:password_confirmation)).to include "Password confirmation doesn't match Password"
    end

  describe '.authenticate_with_credentials' do

    it "returns nil if authentication is unsuccessful" do
      @user = User.new(
        first_name: "Jim", last_name: "Bo", email: "jim@live.ca", password: "jimbo", password_confirmation: "jimbo"
      )
      @user.save
      @result = User.authenticate_with_credentials("jim@live.ca", "wrongpassword1")
      expect(@result).to eq nil
    end

    it "returns a user instance if authentication is successful (exact match)" do
      @user = User.new(
        first_name: "Jim", last_name: "Bo", email: "jim@live.ca", password: "jimbo", password_confirmation: "jimbo"
      )
      @user.save
      @result = User.authenticate_with_credentials("jim@live.ca", "jimbo")
      expect(@result).to eq @user
    end

  end

end