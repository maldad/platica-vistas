class ProductsController < ApplicationController
  def index
    @products = load_products

    respond_to do |format|
      format.html
      format.json { render json: @products }
      format.xml { render xml: @products }
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def load_products
    products = Product.all
    products.where!("name like ?", "%#{params[:name]}%") if params[:name].present?
    products.where!(sale: true) if params[:sale].present?
    products
  end
end
