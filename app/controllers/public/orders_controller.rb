class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm_information
    @order = Order.new(order_params)
    if params[:order] [:address_option] == "0"
      @order.delivery_postal_code = current_customer.postal_code
      @order.delivery_address = current_customer.address
      @order.delivery_name = current_customer.last_name + current_customer.first_name
    elsif params[:order] [:address_option] = "2"
      @order.delivery_postal_code = params[:order] [:delivery_postal_code]
      @order.delivery_address = params[:order] [:delivery_address]
      @order.delivery_name = params[:order] [:delivery_name]
    else
      render new
    end
    @order.customer_id = current_customer.id
  end

  def index
  end

  def show
  end

 private

  def order_params
    params.require(:order).permit(:delivery_postal_code, :delivery_address, :delibery_name, :payment_method, :postage, :customer_id, :payment_amount)
  end
end
