class HomeController < ApplicationController

  before_action :authenticate_user, :except => [:login, :attempt_login, :logout]

  def index
    @camera_url = 'http://localhost:9999/'
    @username = session[:username]
  end

  def login
  end

  def attempt_login
    if params[:username].present? && params[:password].present?
      found_user = AdminUser.where(:username => params[:username]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end

    if authorized_user
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.username
      flash[:notice] = 'You are now logged in'
      redirect_to(home_index_path)
    else
      flash.now[:notice] = 'Invalid username/password'
      render('login')
    end
  end

  def logout
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = 'Logged Out'
    redirect_to(home_login_path)
  end
end
