class BlackListedEmailsController < ApplicationController
  # GET /black_listed_emails
  # GET /black_listed_emails.json
  def index
    @black_listed_emails = BlackListedEmail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @black_listed_emails }
    end
  end

  # GET /black_listed_emails/1
  # GET /black_listed_emails/1.json
  def show
    @black_listed_email = BlackListedEmail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @black_listed_email }
    end
  end

  # GET /black_listed_emails/new
  # GET /black_listed_emails/new.json
  def new
    @black_listed_email = BlackListedEmail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @black_listed_email }
    end
  end

  # GET /black_listed_emails/1/edit
  def edit
    @black_listed_email = BlackListedEmail.find(params[:id])
  end

  # POST /black_listed_emails
  # POST /black_listed_emails.json
  def create
    @black_listed_email = BlackListedEmail.new(params[:black_listed_email])

    respond_to do |format|
      if @black_listed_email.save
        format.html { redirect_to @black_listed_email, notice: 'Black listed email was successfully created.' }
        format.json { render json: @black_listed_email, status: :created, location: @black_listed_email }
      else
        format.html { render action: "new" }
        format.json { render json: @black_listed_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /black_listed_emails/1
  # PUT /black_listed_emails/1.json
  def update
    @black_listed_email = BlackListedEmail.find(params[:id])

    respond_to do |format|
      if @black_listed_email.update_attributes(params[:black_listed_email])
        format.html { redirect_to @black_listed_email, notice: 'Black listed email was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @black_listed_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /black_listed_emails/1
  # DELETE /black_listed_emails/1.json
  def destroy
    @black_listed_email = BlackListedEmail.find(params[:id])
    @black_listed_email.destroy

    respond_to do |format|
      format.html { redirect_to black_listed_emails_url }
      format.json { head :no_content }
    end
  end
end
