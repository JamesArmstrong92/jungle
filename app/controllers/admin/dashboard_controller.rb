class Admin::DashboardController < ApplicationController
  def show
    @total_products = Product.count
    @total_categories = Category.count
  end
  
  private

  http_basic_authenticate_with name: 'Jungle', password: 'book'
end
