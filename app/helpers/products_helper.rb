module ProductsHelper
  def sale_class(product)
    product.sale ? 'green' : ''
  end
end
