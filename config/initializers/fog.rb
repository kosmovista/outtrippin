CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test?
    config.storage = :file
  else
    config.fog_credentials = {
      :provider           => 'Rackspace',
      :rackspace_username => 'jvalente',
      :rackspace_api_key  => '5a16bcc941014b9acd6c7b612fc042b6'
    }
    config.fog_directory = 'avatars'
    config.asset_host = "http://fe5f910fe9492af904f7-d923a624db3b3940ce48298d73fff237.r75.cf1.rackcdn.com"
  end
end