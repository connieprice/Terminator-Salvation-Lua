RumbleActionEventManager = RumbleActionEventManager or class()
function RumbleActionEventManager.init(A0_0)
	managers.action_event:register_listener(A0_0)
	A0_0._action_events = {}
	A0_0.load_event_effects(A0_0)
end
function RumbleActionEventManager.load_event_effects(A0_1)
	for 