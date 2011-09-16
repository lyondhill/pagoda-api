require 'json'
require 'rest_client'

  # Mix-In's
require 'pagoda-client/apis/app'
# require 'pagoda-client/apis/user'
# require 'pagoda-client/apis/componant'
# require 'pagoda-client/apis/billing'
# require 'pagoda-client/apis/email'
# require 'pagoda-client/apis/collaborator'

module Pagoda
  class Client
    
    include Api::App

    attr_reader :user, :password

    def initialize(user, password)
      @user       = user
      @password   = password
    end

    class << self
      def version
        VERSION
      end
      
      def gem_version_string
        "pagoda-gem/#{version}"
      end
    end

    def on_warning(&blk)
      @warning_callback = blk
    end

    def valid_credentials?
      #will poke pagoda and validate credentials
    end

    def host
      "https://api.pagodabox.com"
    end

  protected

    def resource(uri)
      RestClient.proxy = ENV['HTTP_PROXY'] || ENV['http_proxy']
      # RestClient::Resource.new("http://127.0.0.1:3000#{uri}", :user => @user, :password => @password, :content_type => 'application/json')
      RestClient::Resource.new("#{host}#{uri}", @user, @password)
    end

    def get(uri, extra_headers={})
      process(:get, uri, extra_headers)
    end

    def post(uri, payload="", extra_headers={})    
      process(:post, uri, extra_headers, payload)
    end

    def put(uri, payload="", extra_headers={})    
      process(:put, uri, extra_headers, payload)
    end

    def delete(uri, extra_headers={})    
      process(:delete, uri, extra_headers)
    end

    def process(method, uri, extra_headers={}, payload=nil)
      headers  = pagoda_headers.merge(extra_headers)
      args     = [method, payload, headers].compact
      response = resource(uri).send(*args)
    end
    
    def pagoda_headers
      {
        'User-Agent'           => self.class.gem_version_string,
        'X-Ruby-Version'       => RUBY_VERSION,
        'X-Ruby-Platform'      => RUBY_PLATFORM,
        'Accept'               => 'application/json'
      }
    end
    
    def json(content)
      JSON.parse(content, symbolize_names: true)
    end

  end  
end
