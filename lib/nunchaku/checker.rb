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

    private

    def defaults
      { checker_uri: 'https://html5.validator.nu/' }
    end
  end
end
