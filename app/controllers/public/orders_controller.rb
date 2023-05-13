class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm_information
    @order = Order.new(order_params)

    if params[:order][:address_option] == "0"
      @order.delivery_postal_code = current_customer.postal_code
      @order.delivery_address = current_customer.address
      @order.delivery_name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_option] == "1"
      @order.delivery_postal_code = params[:order][:delivery_postal_code]
      @order.delivery_address = params[:order][:delivery_address]
      @order.delivery_name = params[:order][:delivery_name]
    else
      render new
    end

    @cart_items =  current_customer.cart_items.all
    @order.customer_id = current_customer.id
    @total = 0
    @order.postage = 800
    @order.payment_amount = @total + @order.postage
  end

  def confirm_order
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save

    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.amount = cart_item.amount
      @order_detail.payment_including_tax = cart_item.item.add_tax_price
      @order_detail.save
    end

    current_customer.cart_items.destroy_all
    redirect_to '/orders/complete'
  end

  def complete
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

 private

  def order_params
    params.require(:order).permit(:delivery_postal_code, :delivery_address, :delivery_name, :payment_method, :postage, :customer_id, :payment_amount)
  end
end
