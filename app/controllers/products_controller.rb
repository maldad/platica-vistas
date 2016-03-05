class ProductsController < ApplicationController
  before_action :set_producto, only: [:show, :edit, :update, :destroy]

  def index
    @products = load_products

    respond_to do |format|
      format.html
      format.json { render json: @products }
      format.xml { render xml: @products }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @product }
      format.xml { render xml: @product }
    end
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

  def edit
  end

  def update
    if @product.update product_params
      redirect_to products_path, notice: 'Producto editado correctamente'
    else
      render :edit
    end
  end  

  def destroy
    @product.destroy
    redirect_to products_path, notice: 'Producto eliminado correctamente'
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

  def set_producto
    @product = Product.find(params[:id])
  end

end
