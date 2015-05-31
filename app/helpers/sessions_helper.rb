module Timesheets
  class Encryptor
    attr_reader :encryption_scheme

    def initialize encryption_scheme = nil
      @encryption_scheme = encryption_scheme || default_encryptor
    end

    def encrypt unencrypted_data
      encryption_scheme.encrypt_and_sign(unencrypted_data)
    end

    def decrypt encrypted_data
      encryption_scheme.decrypt_and_verify(encrypted_data)
    end

    private

    def default_encryptor
      ActiveSupport::MessageEncryptor.new(APP_CONFIG.auth.secret_token)

    end
  end
end

module SessionsHelper

# end
# module SessionManagement
  USER_TOKEN_KEY = :user_token_encrypted
  USER_REFRESH_TOKEN_KEY = :user_refresh_token_encrypted
  EXPIRATION_TIME_KEY = :expiration_time

  def encryptor
    @_encryptor ||= Timesheets::Encryptor.new
  end

  def create_session auth_hash
    session[USER_TOKEN_KEY] = auth_hash.token
    session[USER_REFRESH_TOKEN_KEY] = encryptor.encrypt(auth_hash.refresh_token)
    session[EXPIRATION_TIME_KEY] = Time.at(auth_hash.expires_at).to_i
  end

  def user_token
    return if session[USER_TOKEN_KEY].nil? || session_expired?

    token_en = encryptor.encrypt(session[USER_TOKEN_KEY])
    token = encryptor.decrypt(token_en)
    return token
  end

  def user_refresh_token
    session[USER_REFRESH_TOKEN_KEY].try { |token| encryptor.decrypt(token) }
  end

  def session_expired?
    Time.at(session[EXPIRATION_TIME_KEY]).past?
  end

  # redirect back to the previous page
  def redirect_back_or(default)
    # redirect to previous location
    redirect_to(session[:return_to] || default)
    # delete previous location cookie
    session.delete(:return_to)
  end

  #store url
  def store_location
    # Store current requested path
    session[:return_to] = request.url if request.get?
  end

  def clear_token
    session[USER_TOKEN_KEY] = nil
  end
end
