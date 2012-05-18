class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_user_identity

  protected
  def set_user_identity
    unless cookies[:user_identity]
      cookies[:user_identity] = {
        value: generate_user_identity,
        expires: 1.year.from_now,
      }
    end
  end

  private
  def generate_user_identity
    Digest::MD5.hexdigest "#{Time.now().to_i}#{rand}"
  end
end
