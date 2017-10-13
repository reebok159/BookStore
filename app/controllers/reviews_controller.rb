class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
    if Book.exists?(params[:review][:book_id])
      current_user.reviews.build(review_params).save
      flash[:notice] = t('reviews.createsuccess')
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = t('reviews.createfail')
      redirect_back(fallback_location: root_path)
    end
  end

  private
    def review_params
      params.require(:review).permit( :text, :title, :rating )
    end
end
