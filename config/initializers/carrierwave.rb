CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     'AKIAJI4ULCOF3S5OIHMQ',
      aws_secret_access_key: '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'
    }
    config.fog_directory  = 'cocktailfly'
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
  else
    config.ignore_integrity_errors = false
    config.ignore_processing_errors = false
    config.ignore_download_errors = false

    config.storage = :file
  end
end
