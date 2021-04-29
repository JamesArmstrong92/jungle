class Admin::DashboardController < ApplicationController
  def show
  end

  private
  
  http_basic_authenticate_with name: 'Jungle', password: 'book'
end
