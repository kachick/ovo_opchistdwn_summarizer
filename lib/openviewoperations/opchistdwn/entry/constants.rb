# Copyright (c) 2010-2012  Kenichi Kamiya

require 'striuct'

module OpenViewOperations; module OpcHistDwn; class Entry

  Field = Striuct.define do
    undef_method :format
    
    member :name, Symbol
    member :format,Symbol
    member :type, OR(Class, Symbol)
    default :type, String
  end

  FIELDS = [
    [:message_id,          :space_separated  , Symbol],  # 0  
    [:condition_id,        :space_separated  , Symbol],  # 1  
    [:unknown,             :space_separated          ],  # 2  
    [:unknown,             :space_separated          ],  # 3  
    [:node,                :prior_notice_byte        ],  # 4  
    [:unknown,             :space_separated          ],  # 5  
    [:unknown,             :space_separated          ],  # 6  
    [:unknown,             :prior_notice_byte        ],  # 7  
    [:unknown,             :space_separated          ],  # 8  
    [:unknown,             :space_separated          ],  # 9  
    [:unknown,             :space_separated          ],  # 10 
    [:unknown,             :space_separated          ],  # 11 
    [:unknown,             :space_separated          ],  # 12 
    [:unknown,             :space_separated          ],  # 13 
    [:agent_time,          :space_separated   , Time ],  # 14 
    [:first_manager_time,  :space_separated   , Time ],  # 15 
    [:unknown,             :space_separated          ],  # 16 
    [:severity,            :space_separated, :severity], # 17 
    [:unknown,             :space_separated          ],  # 18 
    [:unknown,             :space_separated          ],  # 19 
    [:unknown,             :space_separated          ],  # 20 
    [:auto_action_node,    :prior_notice_byte        ],  # 21 
    [:unknown,             :space_separated          ],  # 22 
    [:unknown,             :space_separated          ],  # 23 
    [:unknown,             :space_separated          ],  # 24 
    [:unknown,             :space_separated          ],  # 25 
    [:unknown,             :space_separated          ],  # 26 
    [:unknown,             :prior_notice_byte        ],  # 27 
    [:unknown,             :space_separated          ],  # 28 
    [:unknown,             :space_separated          ],  # 29 
    [:accept_time,         :space_separated   , Time ],  # 30 
    [:accepter,            :prior_notice_byte        ],  # 31 
    [:template_name,       :prior_notice_byte, Symbol],  # 32 
    [:application,         :prior_notice_byte        ],  # 33 
    [:message_group,       :prior_notice_byte        ],  # 34 
    [:object,              :prior_notice_byte        ],  # 35 
    [:unknown,             :prior_notice_byte        ],  # 36 
    [:auto_action_command, :prior_notice_byte        ],  # 37 
    [:unknown,             :prior_notice_byte        ],  # 38 
    [:message_text,        :prior_notice_byte        ],  # 39 
    [:original,            :prior_notice_byte        ],  # 40 
    [:unknown,             :space_separated          ],  # 41 
    [:message_type,        :prior_notice_byte        ],  # 42 
    [:unknown,             :space_separated          ],  # 43 
    [:unknown,             :space_separated          ],  # 44 
    [:unknown,             :space_separated          ],  # 45 
    [:unknown,             :space_separated          ],  # 46 
    [:unknown,             :space_separated          ],  # 47 
    [:unknown,             :space_separated          ],  # 48 
    [:unknown,             :prior_notice_byte        ],  # 49 
    [:unknown,             :prior_notice_byte        ],  # 50 
    [:unknown,             :space_separated          ],  # 51 
    [:unknown,             :space_separated          ],  # 52 
    [:unknown,             :space_separated          ],  # 53 
    [:unknown,             :space_separated          ],  # 54 
    [:unknown,             :prior_notice_byte        ],  # 55 
    [:unknown,             :prior_notice_byte        ],  # 56 
    [:service_name,        :prior_notice_byte        ],  # 57 
    [:unknown,             :prior_notice_byte        ],  # 58 
    [:unknown,             :space_separated          ],  # 59 
    [:last_manager_time,   :space_separated   , Time ],  # 60 
    [:unknown,             :prior_notice_byte        ],  # 61 
  ].map{|row|Field.load_values(*row).freeze}.freeze

  VALID_FIELD_NAMES = (
    FIELDS.map(&:first).reject{|s|s == :unknown} + [:unknowns, :annotations]
  ).freeze
  
end; end; end
