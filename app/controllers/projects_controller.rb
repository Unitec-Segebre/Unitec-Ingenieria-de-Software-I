class ProjectsController < ApplicationController

  def index
    @projects = Project.all
    @new_project = Project.new
    @users = User.all.pluck("username");
  end

  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html{ redirect_to projects_path, notice: "#{@project.title} creado exitosamente" }
      else
        flash[:error] = @project.errors.full_messages
        format.js{ render action: "index" }
      end
    end
  end

  def show
    @project = Project.find(params[:id])
    @new_lot = Lot.new(project_id: @project.id) #small hack
  end

  protected
    def project_params
      params.require(:project).permit(:title, :manager, :image)
    end
end
