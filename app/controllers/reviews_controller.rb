class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def create
    if Book.exists?(params[:review][:book_id].to_i)
      @review = current_user.reviews.build(review_params).save
      flash[:notice] = t('reviews.createsuccess') if @review
    end

    flash[:alert] = t('reviews.createfail') if flash[:notice].blank?

    redirect_back(fallback_location: root_path)
  end

  private

  def review_params
    params.require(:review).permit(:book_id, :text, :title, :rating)
  end
end
