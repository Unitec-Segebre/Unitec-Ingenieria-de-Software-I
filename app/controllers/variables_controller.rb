class VariablesController < ApplicationController
  def index
    @variables = Variable.all
    @variable = Variable.new
  end

  def create
    @variable = Variable.new(variable_params)

    if @variable.save
      redirect_to variables_path, notice: "Variable #{@variable.name} creada exitosamente!"
    else
      flash[:error] = "Un error ha ocurrido al crear una categoria."
      redirect_to variables_path
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
    @variable = Variable.find(params[:variable_id])
    @days = Lot.find(params[:lot_id]).range_values(@variable.category)
  end

  protected
    def variable_params
      params.require(:variable).permit(:name, :category_id, :measurement_unit, :unit_cost)
    end

end
