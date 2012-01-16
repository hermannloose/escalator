class EscalationPoliciesController < ApplicationController
  filter_resource_access

  # GET /escalation_policies
  # GET /escalation_policies.json
  def index
    @escalation_policies = EscalationPolicy.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @escalation_policies }
    end
  end

  # GET /escalation_policies/1
  # GET /escalation_policies/1.json
  def show
    @escalation_policy = EscalationPolicy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @escalation_policy }
    end
  end

  # GET /escalation_policies/new
  # GET /escalation_policies/new.json
  def new
    @escalation_policy = EscalationPolicy.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @escalation_policy }
    end
  end

  # GET /escalation_policies/1/edit
  def edit
    @escalation_policy = EscalationPolicy.find(params[:id])
  end

  # POST /escalation_policies
  # POST /escalation_policies.json
  def create
    @escalation_policy = EscalationPolicy.new(params[:escalation_policy])

    respond_to do |format|
      if @escalation_policy.save
        format.html { redirect_to @escalation_policy, :notice => 'Escalation policy was successfully created.' }
        format.json { render :json => @escalation_policy, :status => :created, :location => @escalation_policy }
      else
        format.html { render :action => "new" }
        format.json { render :json => @escalation_policy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /escalation_policies/1
  # PUT /escalation_policies/1.json
  def update
    @escalation_policy = EscalationPolicy.find(params[:id])

    respond_to do |format|
      if @escalation_policy.update_attributes(params[:escalation_policy])
        format.html { redirect_to @escalation_policy, :notice => 'Escalation policy was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @escalation_policy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /escalation_policies/1
  # DELETE /escalation_policies/1.json
  def destroy
    @escalation_policy = EscalationPolicy.find(params[:id])
    @escalation_policy.destroy

    respond_to do |format|
      format.html { redirect_to escalation_policies_url }
      format.json { head :ok }
    end
  end
end
