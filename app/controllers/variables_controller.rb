class VariablesController < ApplicationController
  def index
    @variables = Variable.all
    @variable = Variable.new
  end
end
