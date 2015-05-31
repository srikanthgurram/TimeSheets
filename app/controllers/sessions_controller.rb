class SessionsController < ApplicationController
  skip_before_action :authenticate_user, except: :refresh_token
  around_action :authenticate_refresh, only: :refresh_token
  layout "login"

  def new
  end

  def create    
    # Login 
    attempt_login
    # Redirect to home page
    if current_user != nil
      flash[:success] = "Login Successful"      
      redirect_back_or(home_index_path)
    else
      flash[:error] = "Login Failed"
      redirect_to root_path
    end
  end
  
  def destroy
    reset_session
    cookies.delete :oauth_token
    flash[:info] = "Successfully logged out"
    redirect_to login_path
  end

  private
    def attempt_login
      gauth_hash = google_auth
      credemtial_hash = gauth_hash['credentials'].slice('token', 'expires_at', 'refresh_token')

      create_user_from_hash gauth_hash

      create_session(credemtial_hash)
      save_auth_cookie(credemtial_hash.token)
    end

    def create_user_from_hash auth_hash
      email = auth_hash["info"]["email"]
      if User.exists?(email: email)
        puts "=====updating records======"
        user = User.find_by(email: email)
        user.update(
                    access_token:  auth_hash["credentials"]["token"],
                    expires_at: Time.at(auth_hash["credentials"]["expires_at"]).to_datetime)
      else
        puts "=====creating record======"
        User.create(
                    name: auth_hash["info"]["name"],
                    email: auth_hash["info"]["email"],
                    image: auth_hash["info"]["image"],
                    access_token: auth_hash["credentials"]["token"],
                    refresh_token: auth_hash["credentials"]["refresh_token"],
                    expires_at: Time.at(auth_hash["credentials"]["expires_at"]).to_datetime)          
      end  
       
    end

    def save_auth_cookie token    
      cookies.signed[:oauth_token] = {value: token, domain: ".#{request.domain}"}     
    end

    def auth_hash
      request.env['omniauth.auth']['credentials'].slice('token', 'expires_at', 'refresh_token')
    end

    def google_auth
      auth = request.env['omniauth.auth']
      return auth
    end  
end
