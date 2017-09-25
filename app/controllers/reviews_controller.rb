class ReviewsController < ApplicationController
  def index
  end

  def create
    if Book.exists?(params[:review][:book_id])
      current_user.reviews.build(review_params).save
      flash[:notice] = "Thanks for Review. It will be published as soon as Admin will approve it."
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Cannot create review"
      redirect_back(fallback_location: root_path)
    end
  end

  private
    def review_params
      params.require(:review).permit( :text, :title, :rating )
    end
end
