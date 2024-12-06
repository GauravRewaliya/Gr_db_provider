Hashid::Rails.configure do |config|
  # config.salt = ""
  # config.pepper = table_name

  config.min_hash_length = 8
  # config.alphabet = "abcdefghijklmnopqrstuvwxyz" \
  #                   "ABCDEFGHIJKLMNOPQRSTUVWXYZ" \
  #                   "1234567890"
  # config.override_find = true
  # config.override_to_param = true
  # config.sign_hashids = true
end