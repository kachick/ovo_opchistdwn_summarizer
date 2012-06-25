# Copyright (c) 2010-2012  Kenichi Kamiya

module OpenViewOperations; module OpcHistDwn 

class Entry

  class << self

    def parse(str)
      self::Parser.new(str).parse
    end

  end

end
  
end; end