class Api::V1::PostsController < ApplicationController
  before_action :set_api_v1_post, only: [:show, :update, :destroy]
  

  # GET /api/v1/posts
  def index
    @api_v1_posts = Api::V1::Post.all

    render json: @api_v1_posts
  end

  # GET /api/v1/posts/1
  def show
    render json: @api_v1_post
  end

  # POST /api/v1/posts
  def create
    @api_v1_post = Api::V1::Post.new(api_v1_post_params)

    if @api_v1_post.save
      render json: @api_v1_post, status: :created, location: @api_v1_post
    else
      render json: @api_v1_post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/posts/1
  def update
    if @api_v1_post.update(api_v1_post_params)
      render json: @api_v1_post
    else
      render json: @api_v1_post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/posts/1
  def destroy
    @api_v1_post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_post
      @api_v1_post = Api::V1::Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_post_params
      params.require(:api_v1_post).permit(:title, :content)
    end
end
