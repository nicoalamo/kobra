class BuyersController < ApplicationController
  before_action :authenticate_seller!
  before_action :set_buyer, only: [:show, :edit, :update, :destroy]

  # GET /buyers
  # GET /buyers.json
  def index
    @seller = current_seller
    @buyers = @seller.buyers
  end

  # GET /buyers/1
  # GET /buyers/1.json
  def show
    @billings = @buyer.billings
    @pending = @billings.notpaid

  end

  # GET /buyers/new
  def new
    @buyer = Buyer.new
  end

  # GET /buyers/1/edit
  def edit
  end



  # POST /buyers
  # POST /buyers.json
  def create
    @seller = current_seller
    @buyer = @seller.buyers.build(buyer_params)
    @seller.save

    respond_to do |format|
      if @buyer.save
        format.html { redirect_to @buyer, notice: 'Cliente creado con exito.' }
        format.json { render :show, status: :created, location: @buyer }
      else
        format.html { render :new }
        format.json { render json: @buyer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /buyers/1
  # PATCH/PUT /buyers/1.json
  def update
    respond_to do |format|
      if @buyer.update(buyer_params)
        format.html { redirect_to @buyer, notice: 'El cliente fue modificado con exito.' }
        format.json { render :show, status: :ok, location: @buyer }
      else
        format.html { render :edit }
        format.json { render json: @buyer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buyers/1
  # DELETE /buyers/1.json
  def destroy
    @buyer.destroy
    respond_to do |format|
      format.html { redirect_to buyers_url, notice: 'Cliente eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_buyer
      @buyer = Buyer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def buyer_params
      params.require(:buyer).permit(:seller_id, :first_name, :last_name, :photo, :phone, :email, :detail)
    end
end
