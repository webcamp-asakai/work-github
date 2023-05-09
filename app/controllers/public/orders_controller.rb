class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm_information
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    redirect_to '/orders/complete'
  end

  def index
  end

  def show
  end

  def order_params
    params.require(:order).permit(:delivery_postal_code, :delivery_address, :delibery_name, :payment_method)
  end
end
