Rails.application.config.after_initialize do
  $homepage_copy = YAML.load_file(File.join(Rails.root, 'config', 'homepage.yml'))
end