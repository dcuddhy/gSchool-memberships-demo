class MembershipsController < ApplicationController

  def index
    @membership = Membership.new
    @project = Project.find(params[:project_id])
  end

  def create
    @membership = Membership.new(allowed_params)
    if @membership.save
      redirect_to project_memberships_path
    else
      @project = Project.find(params[:project_id])
      render :index
    end
  end

  def update
    @membership = Membership.find(params[:id])
    @membership.update(allowed_params)
    if @membership.save
      redirect_to project_memberships_path
    else
      @project = Project.find(params[:project_id])
      render :index
    end
  end

  def destroy
    membership = Membership.find(params[:id])
    membership.destroy
    redirect_to project_memberships_path
  end

  private

  def allowed_params
    params.require(:membership).permit(:user_id, :role,).merge(:project_id => params[:project_id])
  end
end
