class RotationsController < ApplicationController
  # GET /rotations
  # GET /rotations.json
  def index
    @rotations = Rotation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @rotations }
    end
  end

  # GET /rotations/1
  # GET /rotations/1.json
  def show
    @rotation = Rotation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @rotation }
    end
  end

  # GET /rotations/new
  # GET /rotations/new.json
  def new
    @rotation = Rotation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @rotation }
    end
  end

  # GET /rotations/1/edit
  def edit
    @rotation = Rotation.find(params[:id])
  end

  # POST /rotations
  # POST /rotations.json
  def create
    @rotation = Rotation.new(params[:rotation])

    respond_to do |format|
      if @rotation.save
        format.html { redirect_to @rotation, :notice => 'Rotation was successfully created.' }
        format.json { render :json => @rotation, :status => :created, :location => @rotation }
      else
        format.html { render :action => "new" }
        format.json { render :json => @rotation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rotations/1
  # PUT /rotations/1.json
  def update
    @rotation = Rotation.find(params[:id])

    respond_to do |format|
      if @rotation.update_attributes(params[:rotation])
        format.html { redirect_to @rotation, :notice => 'Rotation was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @rotation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rotations/1
  # DELETE /rotations/1.json
  def destroy
    @rotation = Rotation.find(params[:id])
    @rotation.destroy

    respond_to do |format|
      format.html { redirect_to rotations_url }
      format.json { head :ok }
    end
  end
end
