require("shared/event/EventManager")
require("shared/action_event/ActionEventEmitter")
require("shared/action_event/ActionEventListener")
require("shared/action_event/ActionEventInfo")
require("shared/TableAlgorithms")
ActionEventManager = ActionEventManager or class(EventManager)
function ActionEventManager.init(A0_0)
	EventManager.init(A0_0)
	A0_0._callback_to_listener = {}
	A0_0._action_name_to_listeners = {}
	A0_0._action_name_to_listeners_without_unit_filter = {}
	A0_0._action_name_to_listeners_with_and_without_unit_filter = {}
	A0_0._deferred_dispatch_enabled = true
	A0_0._deferred_dispatch_wanted = true
	A0_0._deferred_event_channels = {}
	A0_0._deferred_event_channels[1] = {}
	A0_0._deferred_event_channels[2] = {}
	A0_0._current_deferred_event_channel = 1
end
function ActionEventManager.enable_deferred_dispatch(A0_1, A1_2)
	A0_1._deferred_dispatch_wanted = A1_2
end
function ActionEventManager.define_actions(A0_3, A1_4)
	A0_3._action_names = {}
	for 