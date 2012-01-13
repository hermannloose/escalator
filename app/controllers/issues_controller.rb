class IssuesController < ApplicationController
  # GET /issues
  # GET /issues.json
  def index
    @issues = Issue.scoped
    if params[:escalation_policy_id]
      @issues = @issues.where(:escalation_policy_id => params[:escalation_policy_id])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @issues }
    end
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
    @issue = Issue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @issue }
    end
  end

  # GET /issues/new
  # GET /issues/new.json
  def new
    @issue = Issue.new
    @issue.escalation_policy_id = params[:escalation_policy_id]

    @policy_options = EscalationPolicy.all.map do |policy|
      [policy.name, policy.to_param]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @issue }
    end
  end

  # GET /issues/1/edit
  def edit
    @issue = Issue.find(params[:id])
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = Issue.new(params[:issue])

    # Not sure what benefit supplied values would have. -hermannloose
    @issue.posted_at = Time.now
    @issue.status = :open

    respond_to do |format|
      if @issue.save
        Delayed::Job.enqueue(EscalationJob.new(@issue.to_param))
        format.html { redirect_to @issue, :notice => 'Issue was successfully created.' }
        format.json { render :json => @issue, :status => :created, :location => @issue }
      else
        format.html { render :action => "new" }
        format.json { render :json => @issue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /issues/1
  # PUT /issues/1.json
  def update
    @issue = Issue.find(params[:id])

    respond_to do |format|
      if @issue.update_attributes(params[:issue])
        format.html { redirect_to @issue, :notice => 'Issue was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @issue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue = Issue.find(params[:id])
    @issue.destroy

    respond_to do |format|
      format.html { redirect_to issues_url }
      format.json { head :ok }
    end
  end
end
