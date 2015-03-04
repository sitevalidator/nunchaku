module Nunchaku
  class Message
    attr_reader :type, :subtype, :first_line, :last_line,
                :first_column, :last_column, :message,
                :extract, :hilite_start, :hilite_length

    def initialize(data)
      @type           = data['type']
      @subtype        = data['subType']
      @first_line     = data['firstLine']
      @last_line      = data['lastLine']
      @first_column   = data['firstColumn']
      @last_column    = data['lastColumn']
      @message        = data['message']
      @extract        = data['extract']
      @hilite_start   = data['hiliteStart']
      @hilite_length  = data['hiliteLength']
    end
  end
end
