class ProjectsController < ApplicationController
  
  def index
    @projects = Project.all
    @new_project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to projects_path, notice: "#{@project.title} creado exitosamente"
    else
      flash[:error] = "Un error ha ocurrido al crear un proyecto"
      redirect_to projects_path
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
