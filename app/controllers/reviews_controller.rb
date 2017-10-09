class ReviewsController < ApplicationController

  def new
    # we need @restaurant in our `simple_form_for`
    @recipe = Recipe.find(params[:recipe_id])
    # @user = User.find(params[:user_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    # we need `restaurant_id` to asssociate review with corresponding restaurant
    @recipe = Recipe.find(params[:recipe_id])
    # @user = User.find(params[:user_id])
    @review.recipe = @recipe
    @review.user = current_user

    if @review.save
      redirect_to recipe_path(@recipe)
    else
      fail
      render :new
    end
  end

   def destroy
     @recipe = Recipe.find(params[:recipe_id])
      @review.recipe = @recipe
     @review = Review.find(params[:review_id])
     @review.destroy
     redirect_to recipe_path(@recipe)
   end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :picture, :picture_cache )
  end


end