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
    @lot = Lot.find(params[:lot_id])
    @variable = Variable.find(params[:variable_id])
    @days = @lot.range_values(@variable.category, @variable.id)
    @total = @lot.sum_values(@variable.category, @variable.id)
  end

  protected
    def variable_params
      params.require(:variable).permit(:name, :category_id, :measurement_unit, :unit_cost)
    end

end
