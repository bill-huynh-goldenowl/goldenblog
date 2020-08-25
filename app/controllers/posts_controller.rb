class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  @@object_after_convert = {}

  # GET /posts
  # GET /posts.json
  def index
    if current_user.admin
      @posts = Post.all
    else
      @user = User.find(current_user.id)
      @posts = @user.posts.all
    end

  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    
    if post_params[:images].blank?
      flash[:error] = "Please, choose image"
      return
    end
    # ! Need refector code here
    convert_to_url_cloudinary(post_params[:images].original_filename)

    @url_image = @@object_after_convert[:landscape]['url']
    # ! End
    if @url_image.blank?
      flash[:error] = "Error, 500!"
      return
    end
    
    if current_user
      @user =  User.find(current_user.id)
    end

    @post = @user.posts.new(post_params.merge(images: @url_image))

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
    # ! Need refactor code here
    convert_to_url_cloudinary(post_params[:images].original_filename)

    @url_image = @@object_after_convert[:landscape]['url']
    # ! End
    respond_to do |format|
      if @post.update(post_params.merge(images: @url_image))
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :images, :love, :share, :user_id)
    end

    # Convert format with cloudinary
    def convert_to_url_cloudinary(path_image)
      @@object_after_convert[:landscape] = Cloudinary::Uploader.upload(Rails.root.join("uploads", path_image).to_s, :tags => "lanscape_stories") 
    end
end
