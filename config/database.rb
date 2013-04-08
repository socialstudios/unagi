database_name = case Padrino.env
  when :development then 'unagi_development'
  # for :production  the database name is part of MONGOLAB_URI
  when :test        then 'unagi_test'
end

# Use MONGOLAB_URI if it's set as an environmental variable
Mongoid::Config.sessions = case Padrino.env
  when :development then {default: {hosts: ["localhost:27017"], database: database_name}}
  when :production  then {default: {uri: ENV['MONGOLAB_URI'] }}
  when :test        then {default: {hosts: ["localhost:27017"], database: database_name}}
end
