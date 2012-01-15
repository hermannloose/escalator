class RotationMembershipsController < ApplicationController
  def show
    membership = RotationMembership.scoped
    membership.where(:rotation_id => params[:rotation_id])
    membership.where(:user_id => params[:user_id])
    @membership = membership.first

    respond_to do |format|
      format.html
      format.json { render :json => @membership }
    end
  end
end
