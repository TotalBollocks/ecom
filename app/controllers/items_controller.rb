class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: [:show, :index]
  
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end
  
  def create 
    @item = Item.new(item_params)
    if @item.save
      # flash[:notice] = "Item has been created"
      redirect_to items_path, notice: "Item has been created"
    else
      flash[:notice] = "Item has not been created"
      render 'new'
    end
  end

  def show
  end

  def edit
  end
  
  def update
    if @item.update(item_params)
      flash[:notice] = "Item has been updated"
      redirect_to @item
    else
      flash[:alert] = "Item has not been updated"
      render 'edit'
    end
  end
  
  def destroy
    @item.destroy
    flash[:notice] = "Item has been deleted"
    redirect_to items_path
  end
  
  private
    
  def item_params
    params.require(:item).permit(:name, :price)
  end
  
  def set_item
    @item = Item.find(params[:id])
  end
  
end
