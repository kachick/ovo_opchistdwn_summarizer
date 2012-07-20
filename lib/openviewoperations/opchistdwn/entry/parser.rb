# Copyright (c) 2010-2012  Kenichi Kamiya

require 'forwardable'

module OpenViewOperations; module OpcHistDwn; class Entry

  class Parser

    extend Forwardable

    class MalformedError < RuntimeError; end

    FIELDS = Entry::FIELDS

    VALID_FIELD_NAMES = Entry::VALID_FIELD_NAMES

    SEVERITIES = {
      2  => :Normal,
      4  => :Warning, 
      8  => :Critical, 
      16 => :Minor,
      32 => :Major
    }.freeze

    def initialize(str)
      @scanner = StringScanner.new str
      @field_pointer = 0
    end

    def parse
      Entry.define do |entry|
        trim_separator
        unknowns = {}

        FIELDS.each_with_index do |field, idx|
          @field_pointer = idx
          error 'Already finished.' if eos?
          value = __send__(:"parse_#{field.type}", __send__(:"scan_#{field.format}"))

          case field.name
          when :unknown
            unknowns[idx] =  value
          else
            entry[field.name] = value
          end
        end

        entry.cma = parse_cma
        entry.annotations = parse_annotations   
        entry.unknowns = unknowns
        trim_separator
        trim_line_end
        
        error 'Rest-string is.' unless eos?
      end
    end

    def values
      valids.map{|name|__send__ name}
    end

    private

    def_delegators :@scanner, :scan, :peek, :rest, :eos?
    
    def valids
      self.class::VALID_FIELD_NAMES
    end

    def parse_severity(str)
      SEVERITIES[Integer str] || error
    end

    def parse_String(str)
      str
    end

    def parse_Symbol(str)
      str.to_sym
    end

    def parse_Time(str)
      Time.at Integer(str)
    end

    def scan_space_separated
      if scan(/(.+?) /)
        @scanner[1]
      else
        error 'Unmatch space-separated field.'
      end
    end

    def scan_prior_notice_byte
      if scan(/(\d+) /)
        size = Integer @scanner[1]
        
        field = peek size
        
        begin
          @scanner.pointer += size
        rescue RangeError
          error 'Check scanner-pointer'
        end
        
        if size == 0
          trim_space
        end

        trim_space
        
        field
      else
        error 'Unmatch pre-byte field.'
      end
    end

    def trim_space
      scan(/ /)
    end

    def trim_line_end
      scan(/\n/)
    end

    def trim_separator
      scan(/\n?====> /)
    end

    def summary_table
      ''.tap do |result|
        fields = self.class::FIELDS
        fields.each_with_index do |field, index|
          result << [index, fields[index]].join("\t")
          result << "\n"
        end
      end
    end

    def error(message='Check pointer and rest-text.')
      raise(MalformedError, 
        ["Message: #{message}", "Pointer: #{@field_pointer}", "Rest: \n#{rest}",
        "Scanner: #{@scanner.inspect}", "Fields: #{summary_table}"].join("\n")
      )
    end
    
    def parse_cma_flag(str)
      case str
      when '0'
        false
      when '1'
        true
      else
        error
      end
    end

    def trim_cma_header
      scan(/CMA /)
    end
    
    def parse_cma
      if trim_cma_header
        {scan_prior_notice_byte.to_sym => scan_prior_notice_byte}
      end
    end
    
    def parse_annotations
      while annotation = parse_annotation
        (annotations ||= []) << annotation
      end
      annotations
    end
    
    def parse_annotation
      trim_annotation_header && Annotation.define do |annotation|
        unknowns = {}

        Annotation::FIELDS.each_with_index do |field, idx|
          @field_pointer += 1
          error 'Already finished.' if eos?
          value = __send__(:"parse_#{field.type}", __send__(:"scan_#{field.format}"))

          case field.name
          when :unknown
            unknowns[idx] =  value
          else
            annotation[field.name] = value
          end
        end
        
        annotation.unknowns = unknowns
        trim_line_end
      end
    end
    
    def trim_annotation_header
      scan(/ANNO /)
    end

  end
  
end; end; end