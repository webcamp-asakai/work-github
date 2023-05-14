class Admin::HomesController < ApplicationController
  def top
    @orders = Order.page(params[:page])
    @total = 0
  end
end
