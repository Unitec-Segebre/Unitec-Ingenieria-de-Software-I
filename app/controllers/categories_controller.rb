class CategoriesController < ApplicationController
  
  def index
  	@categories = Category.all
  	@new_category = Category.new
  end

   def destroy
    @category = Category.find(params[:id])
    
    @category.destroy
    redirect_to categories_path, notice: "#{@category.name} eliminado correctamente!"
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path, notice: "#{@category.name} creado exitosamente!"
    else
      flash[:error] = "Un error ha ocurrido al crear una categoria."
      # Can't be render or @categories loses its value
      redirect_to categories_path
    end
  end

  protected

  def category_params
  	params.require(:category).permit(:name)
  end
end