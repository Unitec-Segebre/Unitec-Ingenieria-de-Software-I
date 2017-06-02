class VariablesController < ApplicationController
  def index
    @variables = Variable.all
    @variable = Variable.new
  end

  def create
    @variable = Variable.new(variable_params)

    respond_to do |format|
      if @variable.save
        format.html { redirect_to variables_path, notice: "Variable #{@variable.name} creada exitosamente!" }
      else
        flash[:error] = @variable.errors.full_messages
        format.js { render action: "index" }
      end
    end

  end

  def edit
    @variable = Variable.find(params[:id])
  end

  def update
    @variable = Variable.find(params[:id])

    if @variable.update_attributes(variable_params)
      redirect_to variables_path, notice: "La variable #{@variable.name} se ha actualizado exitosamente"
    else
      render :edit
    end
  end

  def destroy
    @variable = Variable.find(params[:id])

    @variable.destroy
      redirect_to variables_path, notice: "Variable #{@variable.name} eliminada correctamente!"
  end

  def history

    respond_to do |format|
      format.html {}
      format.js { render "history", locals: { graph: params[:history][:graph],
            variable: Lot.find(params[:history][:lot_id]).variables.find(params[:history][:variable_id]).valorizations.where('valorizations.assigned_at BETWEEN ? AND ?', Date.parse(params[:history][:from]), Date.parse(params[:history][:to])),
            category_id: Variable.find(params[:variable_id]).category.id,
            check_box: params[:history][:check_box]}}
    end
    @lot = Lot.find(params[:lot_id])
    @variable = Variable.find(params[:variable_id])
  end

  protected
    def variable_params
      params.require(:variable).permit(:name, :category_id, :measurement_unit, :unit_cost_mano, :unit_cost_insumo)
    end

    def variable_cosecha_params
      params.require(:variable).permit(:name, :category_id, :amount, :metric_tons, :clusters, :bags)
    end

    def variable_fer_params
      params.require(:variable).permit(:name, :category_id, :amount, :unit_cost_insumo, :cost_mano, :cost_total)
    end
end