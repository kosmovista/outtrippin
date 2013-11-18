CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test?
    config.storage = :file
  else
    config.storage = :fog
    config.fog_credentials = {
      :provider           => 'Rackspace',
      :rackspace_username => 'jvalente',
      :rackspace_api_key  => '5a16bcc941014b9acd6c7b612fc042b6'
    }
  end
end