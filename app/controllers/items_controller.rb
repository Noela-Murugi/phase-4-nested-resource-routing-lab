class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_response_record_not_found

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
    item = Item.find(params[:id])
    render json: item, include: :user
  end

  def create
    if params[:user_id]
      user = User.find(params[:user_id])
      item =
      user.items << Item.create(item_params)
    end
    render json: item, status: :created
  end

  private

  def render_response_record_not_found
    render json: { error: "item not found" }, status: :not_found
  end

  def item_params
    params.permit(:name, :description, :price)
  end

end
