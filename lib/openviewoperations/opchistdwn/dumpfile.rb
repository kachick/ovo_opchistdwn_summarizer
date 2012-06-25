# Copyright (c) 2010-2012  Kenichi Kamiya

require 'strscan'

module OpenViewOperations; module OpcHistDwn
  
class DumpFile < ::File

  class << self

    def foreach(path, encoding)
      open path, "r:#{encoding}" do |input|
        input.each_entry do |entry|
          yield entry
        end
      end
    end

  end

  attr_reader :version

  def initialize(*args)
    super(*args)
    @version = seek_version
    warn "Version #{@version} is illegal." unless FORMAT_VERSION == @version
  end

  def get_section
    gets SEPARATOR
  end

  def each_section
    each_line SEPARATOR do |section|
      yield section
    end
  end

  def seek_version
    gets(SEPARATOR).slice(/Version (\S+)/, 1)
  end

  def get_entry
    Entry.parse get_section
  end
  
  def each_entry
    each_section do |section|
      yield Entry.parse(section)
    end
  end

end
  
end; end