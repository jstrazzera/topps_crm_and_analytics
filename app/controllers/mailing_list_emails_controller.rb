class MailingListEmailsController < ApplicationController
  # GET /mailing_list_emails
  # GET /mailing_list_emails.json
  def index
    @mailing_list_emails = MailingListEmail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mailing_list_emails }
    end
  end

  # GET /mailing_list_emails/1
  # GET /mailing_list_emails/1.json
  def show
    @mailing_list_email = MailingListEmail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mailing_list_email }
    end
  end

  # GET /mailing_list_emails/new
  # GET /mailing_list_emails/new.json
  def new
    @mailing_list_email = MailingListEmail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mailing_list_email }
    end
  end

  # GET /mailing_list_emails/1/edit
  def edit
    @mailing_list_email = MailingListEmail.find(params[:id])
  end

  # POST /mailing_list_emails
  # POST /mailing_list_emails.json
  def create
    puts params
    @mailing_list_email = MailingListEmail.new
    @mailing_list_email.address = params[:address]
    @mailing_list_email.team = Team.find params[:team]

    # respond_to do |format|
      if !@mailing_list_email.save
        # format.html { redirect_to @mailing_list_email, notice: 'Mailing list email was successfully created.' }
        # format.json { 
        render json: @mailing_list_email, status: :created
      else
        # format.html { render action: "new" }
        # format.json { 
        render json: @mailing_list_email.errors, status: :unprocessable_entity 
      end
    # end
  end

  # PUT /mailing_list_emails/1
  # PUT /mailing_list_emails/1.json
  def update
    @mailing_list_email = MailingListEmail.find(params[:id])

    respond_to do |format|
      if @mailing_list_email.update_attributes(params[:mailing_list_email])
        format.html { redirect_to @mailing_list_email, notice: 'Mailing list email was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mailing_list_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mailing_list_emails/1
  # DELETE /mailing_list_emails/1.json
  def destroy
    @mailing_list_email = MailingListEmail.find(params[:id])
    @mailing_list_email.destroy

    respond_to do |format|
      format.html { redirect_to mailing_list_emails_url }
      format.json { head :no_content }
    end
  end
end
