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
      render :index
    end
  end

  def destroy
    @variable = Variable.find(params[:id])

    @variable.destroy
      redirect_to variables_path, notice: "Variable #{@variable.name} eliminada correctamente!"
  end

  protected
    def variable_params
      params.require(:variable).permit(:name, :category_id, :measurement_unit, :unit_cost)
    end

end
