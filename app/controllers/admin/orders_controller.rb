class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def order_params
    params.require(:order).permit(:delivery_postal_code, :delivery_address, :delivery_name, :payment_method, :postage, :customer_id, :payment_amount)
  end

end
