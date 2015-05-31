class ApplicationController < ActionController::Base
  # include SessionManagement
  include SessionsHelper
  protect_from_forgery with: :exception
  before_action :authenticate_user

  private
    # Redirect to signin page if not signed in
    def authenticate_user
      if !user_logged_in?
        # Store current url path for future reference
        store_location
        # Redirect to home page with error flash
        flash[:error] =  "Please Signin to access this page"
        redirect_to root_path
      end
    end

    def current_user?
      user_logged_in? ? current_user : nil
    end

    def current_user
      @current_user ||= User.find_by(access_token: user_token)
    end

    helper_method :current_user

    def user_logged_in?
      user_token.present?
    end

    helper_method :user_logged_in?

end
