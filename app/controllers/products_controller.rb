class ProductsController < ApplicationController
  def index
    @products = Product.all

    respond_to do |format|
      format.html
      format.json { render json: @products }
      format.xml { render xml: @products }
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
