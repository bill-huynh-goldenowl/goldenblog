class HomesController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.approval
  end
end
