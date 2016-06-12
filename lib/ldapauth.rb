require 'net/ldap'

class LdapAuth
  attr_reader :config

  def initialize(config)
    @config = config
  end

  SEARCH_SCOPES = {
    'base' => Net::LDAP::SearchScope_BaseObject,
    'onelevel' => Net::LDAP::SearchScope_SingleLevel,
    'subtree' => Net::LDAP::SearchScope_WholeSubtree,
  }

  def authenticate(username, password)
    Net::LDAP.new(
      host: config[:host],
      port: config[:port],
      encryption: config[:encryption],
    ).bind_as(
      base: config[:search_base],
      scope: SEARCH_SCOPES[config[:scope]],
      filter: config[:query_filter].gsub('%u', Net::LDAP::Filter.escape(username)),
      password: password,
    )
  end
end
