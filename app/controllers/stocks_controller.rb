class StocksController < ApplicationController
  before_action :set_company
  before_action :set_stock, only: [:show, :edit, :update, :destroy]

  # GET /stocks
  def index
    @stocks = @company.stocks.where("date > '2000/1/1'")
    
    respond_to do |format|
      format.html # index.html.erb
      format.json # use own render because of faster loading by find_each method
    end
  end

  # GET /stocks/1
  def show
  end

  # GET /stocks/new
  def new
    @stock = @company.stocks.new
  end

  # GET /stocks/1/edit
  def edit
  end

  # POST /stocks
  def create
    @stock = @company.stocks.new(stock_params)

    if @stock.save
      redirect_to company_stock_url(@company, @stock), notice: 'Stock was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /stocks/1
  def update
    if @stock.update(stock_params)
      redirect_to company_stock_url(@company, @stock), notice: 'Stock was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /stocks/1
  def destroy
    @stock.destroy
    redirect_to company_stocks_url(@company)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find_by(code: params[:company_id])
    end

    def set_stock
      @stock = @company.stocks.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_params
      params.require(:stock).permit(:company_id, :date, :open, :high, :low, :close)
    end
end
