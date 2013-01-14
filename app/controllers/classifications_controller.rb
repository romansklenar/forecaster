class ClassificationsController < ApplicationController
  before_action :set_company
  before_action :set_classification, only: [:show, :edit, :update, :destroy]

  # GET /classifications
  def index
    @classifications = @company.classifications.all
  end

  # GET /classifications/1
  def show
  end

  # GET /classifications/new
  def new
    @classification = @company.classifications.new
  end

  # GET /classifications/1/edit
  def edit
  end

  # POST /classifications
  def create
    @classification = @company.classifications.new(classification_params)

    if @classification.save
      redirect_to company_classification_url(@company, @classification), notice: 'Classification was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /classifications/1
  def update
    if @classification.update(classification_params)
      redirect_to company_classification_url(@company, @classification), notice: 'Classification was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /classifications/1
  def destroy
    @classification.destroy
    redirect_to company_classifications_url(@company)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:company_id])
    end

    def set_classification
      @classification = @company.classifications.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def classification_params
      params.require(:classification).permit(:company_id, :text, :category)
    end
end
