class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_user_identity, :set_current_user

  protected
  def set_user_identity
    unless cookies[:user_identity]
      cookies[:user_identity] = {
        value: generate_user_identity,
        expires: 1.year.from_now,
      }
    end
  end

  def current_user
    @current_user
  end

  def current_user_identity
    cookies[:user_identity]
  end

  def set_current_user
    if current_user_identity
      @current_user = User.find_or_create_by(user_identity: current_user_identity)
    end
    @saved_nickname = cookies[:nickname]
  end

  private
  def generate_user_identity
    Digest::MD5.hexdigest "#{Time.now().to_i}#{rand}"
  end
end
