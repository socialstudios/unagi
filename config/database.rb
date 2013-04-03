database_name = case Padrino.env
  when :development then 'unagi_development'
  when :production  then 'unagi_production'
  when :test        then 'unagi_test'
end

# Use MONGOLAB_URI if it's set as an environmental variable
Mongoid::Config.sessions = case Padrino.env
  when :development then {default: {hosts: ["localhost:27017"], database: database_name}}
  when :production  then {default: {uri: ENV['MONGOLAB_URI'] }}
  when :test        then {default: {hosts: ["localhost:27017"], database: database_name}}
end

# If you want to use a YML file for config, use this instead:
#
#   Mongoid.load!(File.join(Padrino.root, 'config', 'database.yml'), Padrino.env)
#
# And add a config/database.yml file like this:
#   development:
#     sessions:
#       default:
#         database: unagi_development
#         hosts:
#           - localhost:27017
#   production:
#     sessions:
#       default:
#         database: unagi_production
#         hosts:
#           - localhost:27017
#   test:
#     sessions:
#       default:
#         database: unagi_test
#         hosts:
#           - localhost:27017
#
#
# More installation and setup notes are on http://mongoid.org/en/mongoid/docs/installation.html#configuration
