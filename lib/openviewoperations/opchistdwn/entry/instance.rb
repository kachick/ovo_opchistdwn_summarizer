# Copyright (c) 2010-2012  Kenichi Kamiya

module OpenViewOperations; module OpcHistDwn 

class Entry

  member :message_id, Symbol
  member :condition_id, Symbol
  member :node, String
  member :agent_time, Time
  member :first_manager_time, Time
  member :severity, Symbol
  member :auto_action_node, String
  member :accept_time, Time
  member :accepter, String
  member :template_name, Symbol
  member :application, String
  member :message_group, String
  member :object, String
  member :auto_action_command, String
  member :message_text, String
  member :original, String
  member :message_type, String
  member :service_name, String
  member :last_manager_time, Time
  member :unknowns, Hash
  member :annotations, OR(nil, GENERICS(Annotation))
  close_member
  
  raise unless members == VALID_FIELD_NAMES

end
  
end; end
