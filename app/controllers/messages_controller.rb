class MessagesController < ApplicationController
  before_action :set_company
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  def index
    # get IDs of last 1000 messages (find_each doesn't support limit)
    ids = @company.messages.order(:id => :desc).limit(1000).pluck(:id) 
    @messages = @company.messages.where(:id => ids.min..ids.max)

    respond_to do |format|
      format.html # index.html.erb
      format.json # use own render because of faster loading by find_each method
    end
  end

  # GET /messages/1
  def show
  end

  # GET /messages/new
  def new
    @message = @company.messages.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  def create
    @message = @company.messages.new(message_params)

    if @message.save
      redirect_to company_message_url(@company, @message), notice: 'Message was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      redirect_to company_message_url(@company, @message), notice: 'Message was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
    redirect_to company_messages_url(@company)
  end

  def import
    @company.import_messages
    redirect_to :back, notice: "Messages for #{@company.name} was successfully imported."
  rescue
    redirect_to :back, notice: "Import was not successful"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find_by(code: params[:company_id])
    end

    def set_message
      @message = @company.messages.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:company_id, :title, :link, :date, :content_html, :content_text)
    end
end
