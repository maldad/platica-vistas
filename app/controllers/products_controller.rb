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

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "Producto creado exitosamente"
      redirect_to products_path
    else
      render :new
    end
  end

  private

  def load_products
    products = Product.all
    products.where!("name like ?", "%#{params[:name]}%") if params[:name].present?
    products.where!(sale: true) if params[:sale].present?
    products
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :sale)
  end
end
