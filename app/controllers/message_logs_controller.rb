class MessageLogsController < ApplicationController
  # GET /message_logs
  # GET /message_logs.json
  def index
    @message_logs = MessageLog.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @message_logs }
    end
  end

  # GET /message_logs/1
  # GET /message_logs/1.json
  def show
    @message_log = MessageLog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message_log }
    end
  end

  # GET /message_logs/new
  # GET /message_logs/new.json
  def new
    @message_log = MessageLog.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message_log }
    end
  end

  # GET /message_logs/1/edit
  def edit
    @message_log = MessageLog.find(params[:id])
  end

  # POST /message_logs
  # POST /message_logs.json
  def create
    @message_log = MessageLog.new(params[:message_log])

    respond_to do |format|
      if @message_log.save
        format.html { redirect_to @message_log, notice: 'Message log was successfully created.' }
        format.json { render json: @message_log, status: :created, location: @message_log }
      else
        format.html { render action: "new" }
        format.json { render json: @message_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /message_logs/1
  # PUT /message_logs/1.json
  def update
    @message_log = MessageLog.find(params[:id])

    respond_to do |format|
      if @message_log.update_attributes(params[:message_log])
        format.html { redirect_to @message_log, notice: 'Message log was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /message_logs/1
  # DELETE /message_logs/1.json
  def destroy
    @message_log = MessageLog.find(params[:id])
    @message_log.destroy

    respond_to do |format|
      format.html { redirect_to message_logs_url }
      format.json { head :no_content }
    end
  end
end
