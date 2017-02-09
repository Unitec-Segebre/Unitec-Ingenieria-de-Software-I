class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to projects_path, notice: "#{@project.title} creado exitosamente"
    else
      flash[:error] = "Un error ha ocurrido al crear un proyecto"
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  protected
    def project_params
      params.require(:project).permit(:title, :manager,:image_url)
    end
end
