class PostsController < ApplicationController
  before_filter :login_required
  require_role 'admin'
  
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      flash[:notice] = 'Post was successfully created.'
      redirect_to post_path(@post)
    else
      render :action => "new"
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(params[:post])
      flash[:notice] = 'Post was successfully updated.'
      redirect_to post_path(@post)
    else
      render :action => "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

   redirect_to(posts_url)
  end

  protected

  def authorized?
    flash[:error] = "You need to login to do this." unless current_user
    current_user
  end
end

