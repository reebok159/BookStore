class ReviewsController < ApplicationController
  load_and_authorize_resource

  def create
    if @review.save
      flash[:notice] = t('reviews.createsuccess')
    else
      flash[:alert] = "#{t('reviews.createfail')}. "
      flash[:alert] << @review.errors.full_messages.join(', ')
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def review_params
    params.require(:review).permit(:book_id, :text, :title, :rating)
  end
end
