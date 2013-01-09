class InvalidEmailsController < ApplicationController
  # GET /invalid_emails
  # GET /invalid_emails.json
  def index
    @invalid_emails = InvalidEmail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @invalid_emails }
    end
  end

  # GET /invalid_emails/1
  # GET /invalid_emails/1.json
  def show
    @invalid_email = InvalidEmail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @invalid_email }
    end
  end

  # GET /invalid_emails/new
  # GET /invalid_emails/new.json
  def new
    @invalid_email = InvalidEmail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @invalid_email }
    end
  end

  # GET /invalid_emails/1/edit
  def edit
    @invalid_email = InvalidEmail.find(params[:id])
  end

  # POST /invalid_emails
  # POST /invalid_emails.json
  def create
    @invalid_email = InvalidEmail.new(params[:invalid_email])

    respond_to do |format|
      if @invalid_email.save
        format.html { redirect_to @invalid_email, notice: 'Invalid email was successfully created.' }
        format.json { render json: @invalid_email, status: :created, location: @invalid_email }
      else
        format.html { render action: "new" }
        format.json { render json: @invalid_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /invalid_emails/1
  # PUT /invalid_emails/1.json
  def update
    @invalid_email = InvalidEmail.find(params[:id])

    respond_to do |format|
      if @invalid_email.update_attributes(params[:invalid_email])
        format.html { redirect_to @invalid_email, notice: 'Invalid email was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @invalid_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invalid_emails/1
  # DELETE /invalid_emails/1.json
  def destroy
    @invalid_email = InvalidEmail.find(params[:id])
    @invalid_email.destroy

    respond_to do |format|
      format.html { redirect_to invalid_emails_url }
      format.json { head :no_content }
    end
  end
end
