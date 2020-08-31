class HomesController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.where(status: 1)
  end
end