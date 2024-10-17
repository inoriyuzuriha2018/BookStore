class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]
  def index 
    @categories = Category.all.order("id DESC").page(params[:page]).per(15)
  end

  def show

  end

  def new
    @category = Category.new
    #@category.posts.build unless @category.posts.present?
  end

  def create
    @category = Category.new(category_params)
   
    respond_to do |format|
      ActiveRecord::Base.transaction do
        @category.save!
        flash[:success] = "Category was successfully created."
        format.html { redirect_to categories_url }
        format.json { render json: @category.to_json, status: :ok }
      rescue ActiveRecord::RecordInvalid => e
        puts "Transaction failed: #{e.message}"
        flash[:error] = e.message
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: e.message, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
  end

  def update
    respond_to do |format|
      ActiveRecord::Base.transaction do  
        @category.update(category_params)
        flash[:success] = "Category was successfully updated."
        format.html { redirect_to categories_url }
        format.json { render json: @category.to_json, status: :ok }
      rescue ActiveRecord::RecordInvalid => e
        flash[:error] = e.message
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: e.message, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy!

    respond_to do |format|
      flash[:success] = "Category was successfully destroyed."
      format.html { redirect_to categories_url }
      format.json { head :no_content }
      format.js  {}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render file: "#{Rails.root}/public/404.html", status: :not_found
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:title, :description, :image, posts_attributes: [:id, :title, :description, :is_public, :_destroy])
    end
end
