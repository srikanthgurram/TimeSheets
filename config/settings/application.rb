SimpleConfig.for :application do
  group :auth do
    set :client_id, nil
    set :client_secret, nil
    set :secret_token, nil
  end
end
