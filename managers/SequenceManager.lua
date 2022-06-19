if not SequenceManager then
	SequenceManager = class(CoreSequenceManager)
end
SequenceManager.init = function(l_1_0)
	CoreSequenceManager.init(l_1_0, managers.slot:get_mask("area_damage"), managers.slot:get_mask("target_world"), managers.slot:get_mask("beings"))
	l_1_0:register_event_element_class(get_core_or_local("ActionEventElement"))
	l_1_0._proximity_masks.players = managers.slot:get_mask("players")
end

SequenceEnvironment.tweak_data = tweak_data
if not ActionEventElement then
	ActionEventElement = class(CoreBaseElement)
end
ActionEventElement.NAME = "action_event"
ActionEventElement.init = function(l_2_0, l_2_1, l_2_2)
	CoreBaseElement.init(l_2_0, l_2_1, l_2_2)
	l_2_0._text = l_2_0:get("text")
	l_2_0._position = l_2_0:get("position")
end

ActionEventElement.activate_callback = function(l_3_0, l_3_1)
	 -- WARNING: undefined locals caused missing assignments!
end


