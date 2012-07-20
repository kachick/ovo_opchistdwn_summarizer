# Copyright (c) 2010-2012  Kenichi Kamiya

require 'striuct'

module OpenViewOperations; module OpcHistDwn; class Entry

  class Annotation < Striuct

    FIELDS = [
      [:written_time,        :space_separated  , Time], # 0 # 
      [:unknown,             :space_separated        ], # 1 # 
      [:writer,              :prior_notice_byte      ], # 2 # 
      [:message,             :prior_notice_byte      ], # 3 # 
    ].map{|row|Entry::Field.load_values(*row).freeze}.freeze

    VALID_FIELD_NAMES = (FIELDS.map(&:first).
                        reject{|s|s == :unknown} + [:unknowns]).freeze

    member :written_time, Time
    member :writer, String
    member :message, String
    member :unknowns, Hash
    fix_structural
    raise unless members == VALID_FIELD_NAMES

  end
  
end; end; end