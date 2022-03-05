class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    order = Order.find(session[:order_id])
    item_order = ItemOrder.find_by(order_id: session[:order_id])
    item = item_order.item
    @review.order = order
    @review.item = item
    if @review.save
      redirect_to new_review_path
    else
      flash[:alert] = "Something went wrong."
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:upvote, :downvote)
  end
end
