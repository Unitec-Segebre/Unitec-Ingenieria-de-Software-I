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

    respond_to do |format|
      if @category.save
        format.html{ redirect_to categories_path, notice: "#{@category.name} creado exitosamente!" }
      else
        flash[:error] = @category.errors.full_messages
        format.js{ render action: "index" }
      end
    end
  end

  protected

  def category_params
  	params.require(:category).permit(:name)
  end
end
