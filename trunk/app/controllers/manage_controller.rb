class ManageController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @poem_pages, @poems = paginate :poems, :per_page => 10
  end

  def show
    @poem = Poem.find(params[:id])
  end

  def new
    @poem = Poem.new
  end

  def create
    @poem = Poem.new(params[:poem])
    @poem.tag(params[:poem_tags][:tag])
    if @poem.save
      flash[:notice] = 'Poem was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @poem = Poem.find(params[:id])
    # @poem_tags = @poem.tag_names.join ' '
  end

  def update
    @poem = Poem.find(params[:id])
    if (@poem.update_attributes(params[:poem]) && @poem.tag (params[:poem_tags][:tag]) )
      flash[:notice] = 'Poem was successfully updated.'
      redirect_to :action => 'show', :id => @poem
    else
      render :action => 'edit'
    end
  end

  def destroy
    Poem.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
