# Copyright (c) 2010-2012  Kenichi Kamiya

require 'forwardable'

module OpenViewOperations

  module OpcHistDwn

    FORMAT_VERSION = '4'.freeze

    SEPARATOR = "\n====> ".freeze

    class << self
  
      extend Forwardable
      def_delegators :'self::DumpFile', :open, :foreach
  
    end
  
  end
  
  OpcHistoryDownload = OpcHistDwn

end

require_relative 'opchistdwn/entry'
require_relative 'opchistdwn/dumpfile'
