class LotesController < ApplicationController
  def index
    @lotes = Lote.all
  end

  def new
    @lote = Lote.new
  end

  def create
    @lote = Lote.new(lote_params)

    if @lote.save
      redirect_to lotes_path, notice: "#{@lote.name} creado exitosamente"
    else
      flash[:error] = "Un error ha ocurrido al crear un lote"
      render :new
    end
  end

  def show
    @lote = Lote.find(params[:id])
  end

  protected
    def lote_params
      params.require(:lote).permit(:name, :sown_at, :material, :section, :hectares, :proyect_id)
    end
end
