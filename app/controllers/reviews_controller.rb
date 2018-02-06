class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def create
    review = current_user.reviews.new(review_params).save
    if review
      flash[:notice] = t('reviews.createsuccess')
    else
      flash[:alert] = t('reviews.createfail')
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def review_params
    params.require(:review).permit(:book_id, :text, :title, :rating)
  end
end
