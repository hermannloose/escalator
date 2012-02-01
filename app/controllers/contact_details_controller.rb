class ContactDetailsController < ApplicationController
  filter_access_to :all

  # GET /contact_details
  # GET /contact_details.json
  def index
    @contact_details = ContactDetail.where(:user_id => current_user.to_param)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @contact_details }
    end
  end

  # GET /contact_details/1
  # GET /contact_details/1.json
  # TODO(hermannloose): At the moment, this is not limited to the current
  # user's details. Have to look up 404 generation in Rails.
  def show
    @contact_detail = ContactDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @contact_detail }
    end
  end

  # GET /contact_details/new
  # GET /contact_details/new.json
  def new
    @contact_detail = current_user.contact_details.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @contact_detail }
    end
  end

  # GET /contact_details/1/edit
  def edit
    @contact_detail = ContactDetail.find(params[:id])
  end

  # POST /contact_details
  # POST /contact_details.json
  def create
    @contact_detail = ContactDetail.new(params[:contact_detail])

    respond_to do |format|
      if @contact_detail.save
        format.html { redirect_to [:profile, @contact_detail], :notice => 'Contact detail was successfully created.' }
        format.json { render :json => @contact_detail, :status => :created, :location => @contact_detail }
      else
        format.html { render :action => "new" }
        format.json { render :json => @contact_detail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contact_details/1
  # PUT /contact_details/1.json
  def update
    @contact_detail = ContactDetail.find(params[:id])

    respond_to do |format|
      if @contact_detail.update_attributes(params[:contact_detail])
        format.html { redirect_to [:profile, @contact_detail], :notice => 'Contact detail was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @contact_detail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contact_details/1
  # DELETE /contact_details/1.json
  def destroy
    @contact_detail = ContactDetail.find(params[:id])
    @contact_detail.destroy

    respond_to do |format|
      format.html { redirect_to [:profile, :contact_details], :notice => "Contact detail was successfully deleted." }
      format.json { head :ok }
    end
  end
end
