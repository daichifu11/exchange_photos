# unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.AWS[:aws_access_key_id],
      aws_secret_access_key: Rails.application.credentials.AWS[:aws_secret_access_key],
      region: 'ap-northeast-1'
    }

    config.fog_directory  = 'exchange-photos-avatar-images'
    config.asset_host = 'https://exchange-photos-avatar-images.s3.amazonaws.com'
    config.cache_storage = :fog
  end
# end