require 'httparty'
require 'json'

module Nunchaku
  class Checker
    attr_reader :url, :checker_uri

    def initialize(url, options = {})
      options = defaults.merge(options)

      @url         = url
      @checker_uri = options[:checker_uri]
    end

    def raw
      @raw ||= JSON.parse HTTParty.get("#{checker_uri}?out=json&doc=#{@url}").body
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

    def defaults
      { checker_uri: 'https://html5.validator.nu/' }
    end
  end
end
