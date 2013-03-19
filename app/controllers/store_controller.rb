class StoreController < ApplicationController
  skip_before_filter :authorize
  def index
    @products=Product.all
    @cart=current_cart
    @time=Time.now.to_s(:db)
  
    if params[:set_locale]
      redirect_to store_path(:locale => params[:set_locale])
    else
      @products = Product.all
      @cart = current_cart
    end
    
    if session[:counter].nil?
      session[:counter]=1
      #licznik odwiedzin
      else
        session[:counter]+=1        
    end
    
  end
end
