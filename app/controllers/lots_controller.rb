class LotsController < ApplicationController

  def new
    @project = Project.find(params[:project_id])
    @lot = @project.lots.build
  end

  def create
    @project = Project.find(params[:project_id])
    @lot = @project.lots.build(lot_params)

    if @lot.save
      redirect_to @project, notice: "#{@lot.id} creado exitosamente"
    else
      puts @lot.errors.full_messages
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
      params.require(:lot).permit(:sown_at, :material, :section, :hectares, :project_id)
    end
end