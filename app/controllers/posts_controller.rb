class PostsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create
  before_action :set_post, only: [:show, :edit, :update, :destroy, :vote]
  before_action :authenticate_user!, except: [:index, :show]
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.includes(:user)
    respond_to do |format|
      format.html
      format.json do
        render json: @posts,
               except: [:updated_at, :user_id],
               include: { user: { only: [:name] } }
      end
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = @post.comments
    respond_to do |format|
      format.html
      format.json do
        render json: @posts,
               except: [:updated_at, :user_id],
               include: { user: { only: [:name] } }
      end
    end
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        format.html do
          redirect_to @post,
                      notice: 'Post was successfully created.'
        end
        format.json do render :show,
                              status: :created,
                              location: @post
        end
        format.js
      else
        format.html { render :new }
        format.json do
          render json: @post.errors,
                 status: :unprocessable_entity
        end
        format.js
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html do
          redirect_to @post,
                      notice: 'Post was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json do
          render json: @post.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html do
        redirect_to posts_url,
                    notice: 'Post was successfully destroyed.'
      end
      format.json { head :no_content }
      format.js
    end
  end

  def vote
    value = params[:type] == 'up' ? 1 : -1
    @post.add_or_update_evaluation(:votes, value, current_user)
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find_by_slug!(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :content, :image)
  end
end
