class ProductsController < ApplicationController
  @@sum_of_items = 0
  @@list_of_items = []

  def index
    @product = Product.all

  if params[:barcode]
      @products = Product.where(:barcodeID => params[:barcode])
      if (@products && @products[0].barcodeID > 0)
        @@list_of_items.push(@products[0])
        @@sum_of_items = (@@sum_of_items === 0 ? @products[0].price : @@sum_of_items + @products[0].price)                  
      else 
        @msg = "Product not found!"
      end
    end

  if params[:exit]
      @exit = true
      @products = @@list_of_items
      @total = @@sum_of_items
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
      redirect_to @product
    else
      render :new
    end
  end

  private
    def product_params
      params.require(:product).permit(:name, :price, :barcodeID)
    end
end
