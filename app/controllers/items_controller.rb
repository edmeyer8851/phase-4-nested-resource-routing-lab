class ItemsController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    render json: Item.find(params[:id])
  end

  def create
      user = User.find(params[:user_id])
      new_item = Item.create(item_params)
      user.items << new_item
      render json: new_item, status: :created
  end

  private

  def render_not_found
    render json: { error: "User not found" }, status: :not_found
  end

  def item_params
    params.permit(:name, :description, :price)
  end

end
