class MembershipsController < ApplicationController

  def index
    @membership = Membership.new
    @project = Project.find(params[:project_id])
  end

  def create
    membership = Membership.new(allowed_params)
    if membership.save
      redirect_to project_memberships_path
    end
  end

  def update
    membership = Membership.where(project_id: params[:project_id])
    membership.update(allowed_params)
    if membership.save
      redirect_to projects_path
    end
  end


  private

  def allowed_params
    params.require(:membership).permit(:user_id, :role,).merge(:project_id => params[:project_id])
  end

end
