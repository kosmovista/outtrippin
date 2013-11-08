Rails.application.config.after_initialize do
  $example_itineraries = YAML.load_file(File.join(Rails.root, 'config', 'example_itineraries.yml'))
end