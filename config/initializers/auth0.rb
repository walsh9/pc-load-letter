Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    'mV3LbBNO393VYjWHySzgONZT2t7kjqDh',
    '_ZnKuKfv17Vf_o_DA_KA7Ck5Nzzy-QvXi7U8GxBObHZkWuPAUwpMaDzTX_ZrzAzM',
    'pc-load-letter.auth0.com',
    callback_path: "/auth/auth0/callback"
  )
end