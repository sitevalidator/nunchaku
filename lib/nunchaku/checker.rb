require 'httparty'
require 'json'

module Nunchaku
  class Checker
    attr_reader :url, :checker_uri, :user_agent

    def initialize(url, options = {})
      options = defaults.merge(options)

      @url         = url
      @checker_uri = options[:checker_uri]
      @user_agent  = options[:user_agent]
    end

    def raw
      @raw ||= JSON.parse vnu_request
    end

    def messages
      @messages ||= raw['messages'].map { |message| Nunchaku::Message.new(message) }
    end

    def errors
      messages.select { |message| message.type == 'error' }
    end

    def warnings
      messages.select { |message| message.subtype == 'warning' }
    end

    private

    def vnu_request
      HTTParty.get(vnu_request_querystring).body
    end

    def vnu_request_querystring
      s  = "#{checker_uri}?out=json&doc=#{escaped @url}"
      s += "&useragent=#{escaped @user_agent}" if @user_agent
      s
    end

    def escaped(str)
      CGI::escape str
    end

    def defaults
      { checker_uri: 'http://validator.w3.org/nu/' }
    end
  end
end
