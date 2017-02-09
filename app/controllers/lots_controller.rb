class LotsController < ApplicationController
  def index
    @lots = @project.lots
  end

  def new
    @project = Project.find(params[:project_id])
    @lot = @project.lots.build
  end

  def create
    @project = Project.find(params[:project_id])
    @lot = @project.lots.build(payment_params)

    if @lot.save
      redirect_to @project, notice: "#{@lote.title} creado exitosamente"
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
    def lote_params
      params.require(:lote).permit(:name, :sown_at, :material, :section, :hectares, :proyect_id)
    end
end
