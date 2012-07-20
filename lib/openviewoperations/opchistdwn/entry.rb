# Copyright (c) 2010-2012  Kenichi Kamiya

require 'striuct'

module OpenViewOperations; module OpcHistDwn 

  class Entry < Striuct
  end

end; end

require_relative 'entry/constants'
require_relative 'entry/annotation'
require_relative 'entry/parser'
require_relative 'entry/singletonclass'
require_relative 'entry/instance'
