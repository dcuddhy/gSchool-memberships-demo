class MembershipsController < ApplicationController

  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    @membership = Membership.new
    @memberships = @project.memberships
  end

  def create
    @membership = Membership.new(
      params.require(:membership).permit(:user_id, :role)
    )
    @membership.project = @project

    if @membership.save
      redirect_to(
        project_memberships_path(@project),
        notice: "#{@membership.user.full_name} was added successfully",
      )
    else
      @memberships = @project.memberships
      render :index
    end
  end

end
