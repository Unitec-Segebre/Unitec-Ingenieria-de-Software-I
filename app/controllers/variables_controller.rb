class VariablesController < ApplicationController
  def index
    @variables = Variable.all
  end
end
