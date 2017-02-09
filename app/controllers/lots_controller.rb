class LotsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.find(params[:project_id])
    @lot = @project.lots.build
  end

  def create
    @project = Project.find(params[:project_id])
    @lot = @project.lots.build(lot_params)

    if @lot.save
      redirect_to @project, notice: "#{@lot.title} creado exitosamente"
    else
      flash[:error] = "Un error ha ocurrido al crear un lote"
      render :new
    end
  end

  def show
    @project = Project.find(params[:project_id])
    @lot = @project.lots.find(params[:id])
  end

  protected
    def lot_params
      params.require(:lot).permit(:name, :sown_at, :material, :section, :hectares, :proyect_id)
    end
end
