class Public::CustomersController < ApplicationController
  def show
  end

  def edit
  end

  def update
  end

  def withdraw
    @customer = Customer.find(current_customer.id)
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to '/'
  end

end
