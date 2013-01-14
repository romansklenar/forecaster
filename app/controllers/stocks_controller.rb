class StocksController < ApplicationController
  before_action :set_company

  # GET /stocks
  def index
    @stocks = @company.stocks.where("date > '2000/1/1'")
    
    respond_to do |format|
      format.html # index.html.erb
      format.json # use own render because of faster loading by find_each method
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find_by(code: params[:company_id])
    end
end
