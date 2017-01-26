require 'yaml'
require File.join(__dir__, 'lib', 'ldapauth')

config = YAML.load_file(File.join(__dir__, 'config', "#{ENV['RACK_ENV'] || 'development'}.yml"))

use Rack::Auth::Basic, config.fetch(:realm, 'LDAP Auth'), &LdapAuth.new(config)
run ->(env) { [200, {Rack::CONTENT_TYPE => 'text/plain'}, ['OK']] }
