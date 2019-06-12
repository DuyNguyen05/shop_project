class ProductsController < ApplicationController

  def index
    @q = Product.ransack(params[:q])
    @results = @q.result(distinct: true).page(params[:page]).per(10)
    unless @results.present?
      flash.now[:info] = "Không tìm thấy sản phẩm!"
    end
    @products = Product.all
    @product_order = current_order.product_orders.build
  end

  def show
    @product = Product.find params[:id]
    @related_products = Product.best_product.limit(5)
    @reviews = @product.reviews.page(params[:page]).per(10)
    @avg_rate = @product.reviews.average(:rate)&.round(2) || 0
    @product_order = current_order.product_orders.build
  end

end
