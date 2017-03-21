class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  private

  def authenticate_user
    unless session[:user_id]
      flash[:notice] = 'Please log in'
      redirect_to(home_login_path)
  end
end
