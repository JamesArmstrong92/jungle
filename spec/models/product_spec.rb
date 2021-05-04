require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "Will not save a product if a name is not specified" do
      @category = Category.create!(name: "Test")
      @product = Product.new(name: nil, price: 1000, quantity: 1, category: @category)
      expect(@product.errors.full_messages_for(:name)).to include "Name cannot be 0"
    end

    it "Will not product given a name, price, quantity, and category" do
      @category = Category.create!(name: "Test")
      @product = Product.new(name: "Jims guide to the galaxy", price: 100, quantity: 1, category: @category)
      expect(@product.save!).to eq true
    end

    it "Will not save a product if a price is not specified" do
      @category = Category.create!(name: "Tes")
      @product = Product.new(name: "Jims guide to the galaxy", price: nil, quantity: 1, category: @category)
      expect(@product.errors.full_messages_for(:price)).to include "Price cannot be 0"
    end

    it "Will not save a product if a quantity is not specified" do
      @category = Category.create!(name: "Test")
      @product = Product.new(name: "Jims guide to the galaxy", price: 1000, quantity: nil, category: @category)
      expect(@product.errors.full_messages_for(:quantity)).to include "Quantity cannot be 0"
    end

    it "Will not save a product if a category is not specified" do
      @category = Category.create!(name: "Test")
      @product = Product.new(name: "Jims guide to the galaxy", price: 1000, quantity: 1, category: nil)
      expect(@product.errors.full_messages_for(:category)).to include "Category cannot be 0"
    end

  end
end