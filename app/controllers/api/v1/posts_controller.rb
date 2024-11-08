class Api::V1::PostsController < Api::V1::ApplicationApiController
  before_action :set_post, only: %i[show update destroy]

  def index
    posts = Post.searchPost(params[:title]).order("id DESC").page(params[:page]).per(15)
    totalPages = posts.total_pages
    newPosts = posts.map do |post|
    {  
      id: post.id,
      title: post.title,
      description: post.description,
      is_public: post.is_public,
      category: post.category,
    }
    end
    render json: {total: totalPages ,data: newPosts }, status: :ok
  end

  def show
    render json: {data: @post }, status: :ok
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      render json: {data: @post }, status: :created, location: @post
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: {data: @post }, status: :ok
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!
    render json: { message: "Post successfully deleted" }, status: :ok
  end

  private

  def set_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Post not found" }, status: :not_found
  end

  def post_params
    params.require(:post).permit(:title, :description, :is_public, :category_id)
  end
end