class RotationMembershipsController < ApplicationController
  filter_access_to :all

  def show
    @membership = RotationMembership.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @membership }
    end
  end
end
