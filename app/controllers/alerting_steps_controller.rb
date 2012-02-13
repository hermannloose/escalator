class AlertingStepsController < ApplicationController
  filter_access_to :all
  before_filter :find_rotation_membership, :contact_detail_options

  def index
  end

  def show
    @alerting_step = @alerting_steps.find(params[:id])
  end

  def new
    @alerting_step = @rotation_membership.alerting_steps.build
  end

  def create
    @alerting_step = AlertingStep.new(params[:alerting_step])

    respond_to do |format|
      if @alerting_step.save
        format.html do
          redirect_to [@rotation_membership, @alerting_step],
              :notice => "Alerting step was successfully created!"
        end
      else
        format.html { render :action => "new" }
      end
    end
  end

  def edit
    @alerting_step = @alerting_steps.find(params[:id])
  end

  def update
    @alerting_step = @alerting_steps.find(params[:id])

    respond_to do |format|
      if @alerting_step.update_attributes(params[:alerting_step])
        format.html do
          redirect_to [@rotation_membership, @alerting_step],
              :notice => "Alerting step was updated successfully!"
        end
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @alerting_step = @alerting_steps.find(params[:id])
    @alerting_step.destroy

    respond_to do |format|
      format.html { redirect_to [@rotation_membership, :alerting_steps] }
    end
  end

  private

  def find_rotation_membership
    if params[:rotation_membership_id]
      @rotation_membership = RotationMembership.find(params[:rotation_membership_id])
    else
      rotation_memberships = Rotation.find(params[:rotation_id]).rotation_memberships
      @rotation_membership = rotation_memberships.where(:user_id => current_user.id).first
    end

    @alerting_steps = AlertingStep.where(:rotation_membership_id => @rotation_membership.id)
  end

  def contact_detail_options
    @contact_detail_options = ContactDetail.where(:user_id => current_user.id).all.map do |contact_detail|
      [contact_detail.name, contact_detail.id]
    end
  end
end
