class ProjectsController < ApplicationController

  before_filter :login_required, :only => [:create, :update_description, :destroy, :sort]

  def index
    if User.count == 0
      redirect_to signup_url
      return
    end
    @user = User.first
    @projects = Project.order('position, created_at')
  end

  def show
    @project = Project.find(params[:id])
    @asset = Asset.new
  end

  def show_paintings
    @project = Project.find 1
    render :template => "show"
  end

  def show_photography
    @project = Project.find 2
    render :template => "show"
  end

  def create
    @project = Project.new params[:project]
    @project.user_id = current_user.id
    if @project.save
      redirect_to projects_url
    else
      render :action => 'error'
    end
  end

  def update_description
    @project = Project.find params[:id]
    @project.description = params[:value]
    if @project.save
      render :text => textilize(@project.description)
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
  end

  def sort
    project_ids = params[:project_list]
    project_ids.each_with_index do |project_id, index|
      project = Project.find(project_id)
      project.update_attribute(:position, index)
    end
    render :nothing => true
  end

  def feed
    @projects = Project.order('id DESC')
    p @projects
    request.format = "xml"
    respond_to do |format|
      format.xml {render :layout => false, :content_type => 'application/xml'}
    end
  end

  def rss
    @project = Project.find(params[:id])
    request.format = "xml"
    respond_to do |format|
      format.xml {render :layout => false, :content_type => 'application/xml'}
    end
  end
end
