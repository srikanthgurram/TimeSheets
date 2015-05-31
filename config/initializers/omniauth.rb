Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, APP_CONFIG.auth.client_id, APP_CONFIG.auth.client_secret,
           callback_path: '/oauth2callback',
           access_type: 'offline',
           scope: 'userinfo.email, userinfo.profile',
           # hd: 'amplify.com',
           prompt: 'select_account consent'
end

OmniAuth.config.on_failure = proc do |env|
  ip = env['REMOTE_ADDR']
  exception = env['omniauth.error']
  reason = exception.error_reason if exception.respond_to?(:error_reason)
  reason ||= exception.error if exception.respond_to?(:error)
  reason ||= env['omniauth.error.type'].to_s

  Rails.logger.error "Authentication failure: invalid credentials #{reason} (from #{ip})"

  [302, {'Location' => 'auth/failure'}, []]
end

# Log using the Rails logger, rather than STDOUT
OmniAuth.config.logger = Rails.logger

#callback_path: '/auth/google_oauth2/callback'