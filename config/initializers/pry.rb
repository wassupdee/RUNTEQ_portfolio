if Rails.env.development?
  Pry.config.input = STDIN
  Pry.config.output = STDOUT
end