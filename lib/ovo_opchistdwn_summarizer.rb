# Copyright (c) 2010-2012  Kenichi Kamiya

require 'logger'
require 'csv'
require 'lettercase'
require 'lettercase/ext'
require_relative 'openviewoperations/opchistdwn'

class Time
  remove_method :to_s
  
  def to_s
    strftime "%Y/%m/%d %H:%M:%S"
  end
end

module OVO_OpcHistDwn_Summarizer

  extend OpenViewOperations
  include OpenViewOperations

  VERSION = '0.0.2.1'.freeze

  CSV_OPTIONS = {
    headers: OpcHistDwn::Entry.members.map{|sym|sym.pascalcase},
    write_headers: true
  }

  class << self

    def run(pathnames)
      pathnames.each do |path|
   
        CSV.open "#{path}.summary.csv", 'w:windows-31j', CSV_OPTIONS do |csv|
        CSV.open "#{path}.summary.oneline.csv",
                 'w:windows-31j',
                  CSV_OPTIONS do |oneline_csv|

          begin
            OpcHistDwn.foreach path, 'windows-31j' do |entry|
              csv << entry
              oneline_csv << entry.map{|v|(/\n/ === v) ? v.to_s.gsub("\n", '\n') : v}
            end
          rescue OpcHistDwn::Entry::Parser::MalformedError => e
            logger = Logger.new "#{path}.summarize-error.log"
            logger.progname = :'OVO OpcHistDwn Summarizer'
            logger.error "some errors\n#{e}"
            display(path, 'Error')
          rescue Exception => e
            logger = Logger.new "#{path}.summarize-error.log"
            logger.progname = :'OVO OpcHistDwn Summarizer'
            logger.fatal "critical errors\n#{e}"
            display(path, 'Critical Error')
          else
            display(path, 'Complete')
          end

        end
        end

      end
    end

    private

    def display(path, msg)
      $stderr.puts "#{path}: #{msg}"
    end

  end

end
