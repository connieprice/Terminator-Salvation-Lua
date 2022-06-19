SequenceManager = SequenceManager or class(CoreSequenceManager)
function SequenceManager.init(A0_0)
	local L1_1
	L1_1 = CoreSequenceManager
	L1_1 = L1_1.init
	L1_1(A0_0, managers.slot:get_mask("area_damage"), managers.slot:get_mask("target_world"), managers.slot:get_mask("beings"))
	L1_1 = A0_0.register_event_element_class
	L1_1(A0_0, get_core_or_local("ActionEventElement"))
	L1_1 = A0_0._proximity_masks
	L1_1.players = managers.slot:get_mask("players")
end
SequenceEnvironment.tweak_data = tweak_data
ActionEventElement = ActionEventElement or class(CoreBaseElement)
ActionEventElement.NAME = "action_event"
function ActionEventElement.init(A0_2, A1_3, A2_4)
	CoreBaseElement.init(A0_2, A1_3, A2_4)
	A0_2._text = A0_2:get("text")
	A0_2._position = A0_2:get("position")
end
function ActionEventElement.activate_callback(A0_5, A1_6)
end
