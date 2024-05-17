class CartsController < ApplicationController
  def show
    @cart_items = Cart.all
  end

  def add_to_cart
    puts "Params: #{params.inspect}"
    @product = Product.find(params[:id])
    @cart_item = current_cart.cart_items.build(product: @product)
    if @cart_item.save
      redirect_to cart_path, notice: 'Product added to cart successfully.'
    else
      redirect_back fallback_location: root_path, alert: 'Failed to add product to cart.'
    end
  end

  def update
    @cart_item = Cart.find(params[:id])
    if @cart_item.update(cart_params)
      redirect_to cart_path, notice: "Cart updated successfully."
    else
      render :show
    end
  end

  def destroy
    @cart_item = Cart.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path, notice: "Product removed from cart."
  end

  private

  def cart_params
    params.require(:cart).permit(:quantity)
  end

  def current_cart
    if session[:cart_id].present?
      cart = Cart.find_by(id: session[:cart_id])
      puts "Existing Cart ID: #{cart.id if cart}"
      cart || Cart.new
    else
      cart = Cart.create
      session[:cart_id] = cart.id
      puts "New Cart ID: #{cart.id}"
      cart
    end

  end
end
