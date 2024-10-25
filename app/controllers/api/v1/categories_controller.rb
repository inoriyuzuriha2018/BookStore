class Api::V1::CategoriesController < Api::V1::ApplicationApiController
  before_action :set_category, only: %i[show update destroy]

  def index
    categories = Category.includes(:posts)
    .order("id DESC")
    .page(params[:page])
    .per(15)
    .map do |category|
      {
        id: category.id,
        title: category.title,
        description: category.description,
        posts_count: category.posts.size # Hoặc category.products.count
      }
    end

    render json: { data: categories }, status: :ok
  end

  def show
    render json: {data: @category}, status: :ok
  end

  def create
    @category = Category.new(category_params)

    ActiveRecord::Base.transaction do
      if @category.save
        render json: {data: @category}, status: :created
      else
        render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def update
    ActiveRecord::Base.transaction do
      if @category.update(category_params)
        render json:{data: @category}, status: :ok
      else
        render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @category.destroy!
    head :no_content
  end

  private

  def set_category
    @category = Category.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Category not found" }, status: :not_found
  end

  def category_params
    params.require(:category).permit(:title, :description, :image, posts_attributes: [:id, :title, :description, :is_public, :_destroy])
  end
end
