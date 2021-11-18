CONFIG = YAML.load_file("#{Rails.root.to_s}/config/artists_list.yml")[Rails.env]
