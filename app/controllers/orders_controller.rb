class OrdersController < ApplicationController
  before_action :set_order, only: [:edit, :update, :destroy]


  def index
    @seller = current_seller
    @orders = @seller.orders

  end

  def new
  end

  def create
    @buyer = Buyer.find(params[:buyer_id])
    @product = Product.find(params[:product])
    @order = Order.create(product: @product, buyer: @buyer, price: @product.price)
    @order.quantity += 1
    @order.save
    redirect_to buyer_products_path(params[:buyer_id])
  end

  def edit
    @order = Order.find(params[:id])
  end


  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'La orden fue eliminada con exito.' }
      format.json { head :no_content }
    end
  end


  def update
    @order = Order.find(params[:id])
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to request.referrer, notice: 'El precio fue modificado con exito.' }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:price)
    end


end
