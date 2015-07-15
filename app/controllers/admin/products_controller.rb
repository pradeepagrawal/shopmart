class Admin::ProductsController < ApplicationController
  before_action :require_admin_login
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @category = Category.find(params[:product][:category])
    @product = @category.products.create(product_params)
    if @product.save
      flash[:success] = "Product has successfully added"
      redirect_to new_admin_product_path
    else
      flash[:danger] = "Fields can't be empty."
      @categories = Category.all
      render 'new'
    end
  end

  def edit
    @categories = Category.all
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:success] = "Product has successfully Updated"
      redirect_to admin_products_path
    else
      flash[:danger] = "There is some error in edit process"
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:success] = "Product is successfully removed"
    redirect_to admin_products_path
  end

  private
  def product_params
    params.require(:product).permit(:name, :price, :description)
  end

  def require_admin_login
    if user_signed_in?
      is_admin
    else
      redirect_to new_user_session_path
    end
  end
end
