class AccountsController < ApplicationController

  def index
    redirect_to :action => 'signup'
  end

  def signup
    if request.post?
      @user = User.new(params[:user])
      if @user.save
        flash[:notice] = 'Account successfully created.'
        redirect_to :action => 'login'
        return
      end
    else
      @user = User.new
    end
  end


  def login
    if request.post?
      @user = User.find_by_username_and_password(params[:user][:username], params[:user][:password])
      if @user
        session[:user] = @user
        session[:theme] = @user.theme
        redirect_to :controller => 'view'
        return
      end
    end
  end

  def logout
    session[:user] = nil
    redirect_to :controller => 'view'
  end
end
