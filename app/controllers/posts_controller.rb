class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /posts
  # GET /posts.json
  def index
    if current_user.isAdmin
      @posts = Post.all
    else
      @posts = current_user.posts.all
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @categories = Category.all
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @categories = Category.all
  end

  # POST /posts
  # POST /posts.json
  def create
    if post_params[:images].blank?
      flash[:error] = "Please, choose image"
      return
    end

    @url_image = convert_to_url_cloudinary(post_params[:images].original_filename)

    if @url_image.blank?
      flash[:error] = "Error, 500!"
      return
    end
    
    if current_user
      @user =  User.find(current_user.id)
    end

    @post = @user.posts.new(post_params.merge(images: @url_image))
    # get specific category
    @category = Category.find(params[:category_id])
    # add post to category
    @category.posts << @post
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update

    @url_image = convert_to_url_cloudinary(post_params[:images].original_filename)

    if @url_image.blank?
      flash[:error] = "Error, 500!"
      return
    end

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def approve
    @post = Post.find(params[:id])
    @post.update_attributes(status: 1)
    respond_to do |format|
      format.js
    end
  end

  def disapprove
    @post = Post.find(params[:id])
    @post.update_attributes(status: 2)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :images)
    end

    # Convert format with cloudinary
    def convert_to_url_cloudinary(path_image)
      Cloudinary::Uploader.upload(Rails.root.join("uploads", path_image).to_s, :tags => "lanscape_stories")['url'] 
    end
end
