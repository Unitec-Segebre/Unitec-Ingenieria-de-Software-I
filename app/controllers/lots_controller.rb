class LotsController < ApplicationController

  def create
    @project = Project.find(params[:project_id])
    @lot = @project.lots.build(lot_params)

    respond_to do |format|
      if @lot.save
        format.html { redirect_to @project, notice: "#{@lot.id} creado exitosamente" }
      else
        flash[:error] = @lot.errors.full_messages
        format.js { render @project }
      end
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
      @lot.setValue(key, values[:amount], values[:cost_mano])
    end

    redirect_to project_lot_path(@project, @lot)
  end

  def report
    respond_to do |format|
      format.html
      format.js { render "report", locals: {graph: params[:report][:graph], lot: Lot.find(params[:report][:lot_id]).variables.where('valorizations.created_at BETWEEN ? AND ?', Date.parse(params[:report][:from]), Date.parse(params[:report][:to]).next_day)} }
    end

    @project = Project.find(params[:project_id])
    @lot = Lot.find(params[:lot_id])
    @lot_variables = @lot.variables.where('valorizations.created_at BETWEEN ? AND ?',  (Date.today - Date.today.wday + 1), Date.tomorrow)
    @total = nil
    @hAxis = 'variables.name'
    @hAxisLabel = "Variable"
  end

  def chart_action

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
