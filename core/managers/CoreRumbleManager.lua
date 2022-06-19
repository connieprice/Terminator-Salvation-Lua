CoreRumbleManager = CoreRumbleManager or class()
function CoreRumbleManager.init(A0_0)
	A0_0._last_played_ids = {}
	A0_0._preset_rumbles = {}
	A0_0._rumbling_controller_types = {}
	A0_0:initialize_controller_types()
	A0_0._registered_controllers = {}
	A0_0._controller_to_unit_map = {}
	A0_0._enabled = true
end
function CoreRumbleManager.add_preset_rumbles(A0_1, A1_2, A2_3)
	A0_1._preset_rumbles[A1_2] = A2_3
end
function CoreRumbleManager.initialize_controller_types(A0_4)
	local L1_5
	L1_5 = A0_4._rumbling_controller_types
	L1_5.xbox360 = true
	L1_5 = A0_4._rumbling_controller_types
	L1_5.ps3 = true
end
function CoreRumbleManager.paused_update(A0_6, A1_7, A2_8)
	A0_6:update(A1_7, A2_8)
end
function CoreRumbleManager.update(A0_9, A1_10, A2_11)
end
function CoreRumbleManager.stop(A0_12, A1_13)
	if A1_13 then
		if A1_13 == "all" then
			for 