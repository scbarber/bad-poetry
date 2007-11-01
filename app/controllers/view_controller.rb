class ViewController < ApplicationController

  before_filter :get_tags, :get_users, :set_defaults, :get_themes

  def set_defaults
    @show_pagination = true
  end

  def get_tags
    @tags = Tag.find_most_popular
  end

  def get_users
    @users = User.find(:all, :order => 'username ASC')
  end

  def get_themes
    @themes = ['grey', 'orange', 'green', 'other', 'seth']
  end

  def set_theme
    if user = session[:user]
      p user
      user.theme = params[:id]
      user.save
    end
    session[:theme] = params[:id]
    redirect_to :back
  end

  def index
    @poems = Poem.paginate(:all, :order => 'created_at DESC', :page => params[:page])
  end

  def bytag
    @show_pagination = false
    @poems = Poem.find_tagged_with(params[:tag])
    @poems.sort! {  |x,y| x.created_at <=> y.created_at }
    @poems.reverse! unless params[:order] && params[:order] == 'ASC'
    render :action => 'index'
  end

  def byauthor
    @poems = User.find(params[:id]).poems.paginate(:all, :order => 'created_at DESC', :page => params[:page])
    render :action => 'index'
  end

  def poem
    thispoem = Poem.find(params[:id])
    @poems = Array.new
    @poems << thispoem
    render :action => 'index'
  end

  def edit
    if request.post?
      @poem = Poem.find(params[:id])
      if @poem.update_attributes(params[:poem])
        @poem.tag_with(params[:poem_tags][:tag])
        flash[:notice] = 'Poem updated'
        redirect_to :action => 'index'
        return
      end
    end
    @poem = Poem.find(params[:id])
  end

  def create
    @poem = Poem.new(params[:poem])
    @poem.tag_with(params[:poem_tags][:tag])
    @poem.user = session[:user]
    if @poem.save
      flash[:notice] = 'Poem was successfully created.'
      redirect_to :action => 'index'
    else
      flash[:notice] = 'Sorry, there was an error. I have no idea what happened.'
      render :action => 'index'
    end
  end

  def feed
    @rss_items = Poem.find_all
    render_without_layout
  end

  def moddown
    vote = Vote.new
    vote.poem = Poem.find(params[:id])
    vote.user = session[:user]
    vote.points = -1
    vote.save
    session[:user].votes.reload
        redirect_to :action => 'index'
  end

  def modup
    vote = Vote.new
    vote.poem = Poem.find(params[:id])
    vote.user = session[:user]
    vote.points = 1
    vote.save
    session[:user].votes.reload
        redirect_to :action => 'index'
  end
end
