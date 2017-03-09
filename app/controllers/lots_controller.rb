class LotsController < ApplicationController

  def create
    @project = Project.find(params[:project_id])
    @lot = @project.lots.build(lot_params)

    if @lot.save
      redirect_to @project, notice: "#{@lot.id} creado exitosamente"
    else
      puts @lot.errors.full_messages
      flash[:error] = "Un error ha ocurrido al crear un lote"
      redirect_to @project
    end
  end

  def show
    @project = Project.find(params[:project_id])
    @lot = @project.lots.find(params[:id])
    @categories = Category.all
  end

  def update
    @project = Project.find(params[:project_id])
    @lot = @project.lots.find(params[:id])
    @variables = params[:variables]

    @variables.each do |key, values|
      @lot.setValue(key, values[:amount], values[:subtotal])
    end

    redirect_to project_lot_path(@project, @lot)
  end

  def report
    @project = Project.find(params[:project_id])
    @lot = Lot.find(params[:lot_id])
    @variables = Variable.all
    @total = nil
  end

  def values
    @project = Project.find(params[:project_id])
    @lot = @project.lots.find(params[:id])
  end

  protected
    def lot_params
      params.require(:lot).permit(:sown_at, :material, :hectares, :project_id)
    end
end
