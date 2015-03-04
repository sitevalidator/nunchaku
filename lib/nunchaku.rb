require "nunchaku/version"
require "nunchaku/checker"
require "nunchaku/message"

module Nunchaku
  def self.check(url, options = {})
    Nunchaku::Checker.new(url, options)
  end
end
