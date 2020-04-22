class OrdersController < ApplicationController
  before_action :load_order, only: [:show, :edit,:update, :destroy]

  def index
    @orders = Order.all
  end
  
  def show
    @items = @order.order_items.includes(:product)
  end

  def new
    @order = Order.new
    @order.order_items.build
    @order.order_items.build
    @products = Product.all
  end

  def create
    byebug
    @order = Order.new order_params
    # if @order.save
    #   redirect_to order_path(@order.id)
    # else
    #   render :new
    # end
    redirect_to new_order_path
  end

  def edit
    
  end
  
  def update
    if @order.update(order_params)
      redirect_to order_path(@order.id)
    else
      render :edit
    end
  end
  
  def destroy
    if @order.destroy
      redirect_to orders_path
    else 
      redirect_back fallback_location: root_path
    end
  end

  private
  
  def order_params
    params.require(:order).permit(
      :user_id,
      order_items_attributes: [
        :product_id,
        :amount,
        :price]
    )
  end

  def load_order
    @order = Order.find(params[:id])
  end
end
