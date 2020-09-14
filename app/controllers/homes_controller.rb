class HomesController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = 
    if params[:q]
      Post.ransack(title_cont: params[:q]).result(distinct: true)
    else
      Post.approval
    end
  end
end