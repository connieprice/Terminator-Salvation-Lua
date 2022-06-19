local L0_0
L0_0 = require
L0_0("units/data/AiData")
L0_0 = require
L0_0("ai/common/BufferedDamage")
L0_0 = require
L0_0("shared/TableAlgorithms.lua")
L0_0 = 1000
AiNerveSystem = AiNerveSystem or class()
function AiNerveSystem.init(A0_1, A1_2)
	A0_1._unit = A1_2
	A0_1._ai_data = A1_2:ai_data()
	A0_1._braindead = false
	A0_1._registered = false
	A0_1._hibernating = true
	A0_1._event_source_type_filter = A0_1._ai_data.EVENT_SOURCE_TYPES
	A0_1._ai_data.input.enemy_slot_mask = A0_1._ai_data.default_enemy_slot_mask
	assert(A0_1._ai_data.input.enemy_slot_mask)
	A0_1._ai_data.input.is_stunned = false
	A0_1._unit_position = A1_2:position()
	A0_1._current_path_index = 0
	A0_1:_set_move_to_position(nil)
	A0_1._start_position = nil
	A0_1._animation_driven_movement = false
	A0_1._ai_data:request_new_path()
	A0_1._last_graph_update_position = nil
	A0_1._last_graph_position = nil
	A0_1._has_dynamic_graph = NavigationGraphUtilities.is_dynamic_graph(A0_1._ai_data.graph)
	A0_1._debug_brush = Draw:brush()
	A0_1._name = A1_2:name()
	A0_1._movement_blocked = false
	A0_1._movement_blocked_time = 0
	A0_1._movement_blocked_by_unit = nil
	A0_1._weapon_targets = {}
	A0_1._weapon_target_timers = {}
	A0_1._last_path_check_time = 0
	A0_1._last_shortcut_check_time = 0
	A0_1._is_enabled = true
	A0_1:_update_movement_blocked_max_time()
end
function AiNerveSystem._update_movement_blocked_max_time(A0_3)
	local L1_4, L2_5, L3_6
	L1_4 = tweak_data
	L1_4 = L1_4.ai
	L1_4 = L1_4.MOVEMENT_BLOCKED_TIME_NORMAL
	L2_5 = tweak_data
	L2_5 = L2_5.ai
	L2_5 = L2_5.MOVEMENT_BLOCKED_TIME_THREATENED
	L3_6 = {}
	L3_6.normal = math.random(L1_4.rand_min, L1_4.rand_max)
	L3_6.threatened = math.random(L2_5.rand_min, L2_5.rand_max)
	A0_3._movement_blocked_max_time = L3_6
end
function AiNerveSystem.destroy(A0_7)
	if A0_7._registered then
		A0_7:_unregister()
	end
	A0_7:_destroy_ai_data()
	if A0_7._ai_data.graph then
		A0_7._ai_data.graph:remove_dynamic(A0_7._unit)
	end
	A0_7._unit = nil
end
function AiNerveSystem.init_default_ai_data(A0_8)
	local L1_9
end
function AiNerveSystem.warp_to(A0_10, A1_11, A2_12)
	A0_10:reset()
end
function AiNerveSystem.reset(A0_13)
	A0_13._ai_data.input.buffered_damages = {}
	A0_13._ai_data.input.buffered_events = {}
	A0_13:init_default_ai_data()
	A0_13:_setup_brain(A0_13._brain_info)
	A0_13._current_path_index = 0
	A0_13:_set_move_to_position(nil)
	A0_13._start_position = nil
	A0_13._animation_driven_movement = false
	A0_13._ai_data:request_new_path()
	A0_13._movement_blocked = false
	A0_13._movement_blocked_time = 0
	A0_13._movement_blocked_by_unit = nil
	A0_13._weapon_targets = {}
	A0_13._weapon_target_timers = {}
end
function AiNerveSystem.setup(A0_14, A1_15)
	A0_14:init_default_ai_data()
	A0_14._brain_info = A0_14._ai_data.brain_infos[A1_15]
	assert(A0_14._brain_info, "Unknown brain: '" .. A1_15 .. "'")
	A0_14:_setup_brain(A0_14._brain_info)
end
function AiNerveSystem.disable(A0_16)
	if A0_16._ai_data.brain then
		A0_16._ai_data.brain:enable(false)
	end
	A0_16._ai_data.input.buffered_damages = {}
	A0_16._ai_data.input.buffered_events = {}
	A0_16._is_enabled = false
end
function AiNerveSystem.enable(A0_17)
	if A0_17._ai_data.brain then
		A0_17._ai_data.brain:enable(true)
	end
	A0_17._is_enabled = true
end
function AiNerveSystem.is_enabled(A0_18)
	local L1_19
	L1_19 = A0_18._is_enabled
	return L1_19
end
function AiNerveSystem._kill_brain(A0_20)
	assert(not A0_20._braindead)
	if A0_20._registered then
		A0_20:_unregister()
	end
	A0_20:_destroy_ai_data()
	A0_20._braindead = true
end
function AiNerveSystem._destroy_ai_data(A0_21)
	if A0_21._ai_data.brain then
		A0_21._ai_data.brain:destroy()
		A0_21._ai_data.brain = nil
	end
	A0_21._ai_data.input.buffered_damages = nil
	A0_21._ai_data.input.buffered_events = nil
end
function AiNerveSystem._wake_up(A0_22)
	A0_22:_register()
	A0_22._hibernating = false
end
function AiNerveSystem._hibernate(A0_23)
	A0_23:_unregister()
	A0_23._ai_data.input.buffered_damages = {}
	A0_23._ai_data.input.buffered_events = {}
	A0_23._hibernating = true
end
function AiNerveSystem._register(A0_24)
	local L1_25
	L1_25 = assert
	L1_25(not A0_24._registered)
	L1_25 = A0_24._unit
	managers.sensory_events:register_listener(A0_24, A0_24._event_source_type_filter)
	managers.director:add_ai_unit(L1_25)
	function A0_24._damage_callback_func(...)
		local L2_27, L3_28
		L2_27 = _UPVALUE0_
		L3_28 = L2_27
		L2_27 = L2_27._damage_callback
		L2_27(L3_28, ...)
	end
	L1_25:damage():register_damage_callback(A0_24._damage_callback_func)
	A0_24._registered = true
end
function AiNerveSystem._unregister(A0_29)
	assert(A0_29._registered)
	managers.director:remove_ai_unit(A0_29._unit)
	managers.sensory_events:unregister_listener(A0_29)
	A0_29._unit:damage():unregister_damage_callback(A0_29._damage_callback_func)
	A0_29._registered = false
end
function AiNerveSystem._setup_brain(A0_30, A1_31)
	local L2_32, L3_33, L4_34, L5_35, L6_36, L7_37
	L2_32 = A0_30._ai_data
	L2_32 = L2_32.brain
	if L2_32 then
		L2_32 = A0_30._ai_data
		L2_32 = L2_32.brain
		L2_32 = L2_32.destroy
		L2_32(L3_33)
		L2_32 = A0_30._ai_data
		L2_32.brain = nil
	end
	L2_32 = managers
	L2_32 = L2_32.aihivebrain
	L2_32 = L2_32.get_brain
	L6_36 = A1_31.group
	L2_32 = L2_32(L3_33, L4_34, L5_35, L6_36)
	for L6_36, L7_37 in L3_33(L4_34) do
		L2_32:activate_thread(L7_37)
	end
	for L6_36, L7_37 in L3_33(L4_34) do
		L7_37(nil, A0_30._ai_data)
	end
	A0_30._forced_targeting_threads = L3_33
	L3_33.brain = L2_32
	L3_33(L4_34, L5_35)
end
function AiNerveSystem.begin_continuous_sensory_event_callback(A0_38, A1_39)
	if not A0_38._is_enabled then
		return
	end
	A0_38._ai_data.input.buffered_events[A1_39:instance_id()] = A0_38:_create_buffered_event(A1_39, true)
end
function AiNerveSystem.end_continuous_sensory_event_callback(A0_40, A1_41)
	local L2_42
	L2_42 = A0_40._ai_data
	L2_42 = L2_42.input
	L2_42 = L2_42.buffered_events
	L2_42 = L2_42[A1_41:instance_id()]
	if L2_42 then
		L2_42.has_ended = true
	end
end
function AiNerveSystem.trigger_impulse_sensory_event_callback(A0_43, A1_44)
	if not A0_43._is_enabled then
		return
	end
	A0_43._ai_data.input.buffered_events[A1_44:instance_id()] = A0_43:_create_buffered_event(A1_44, false)
end
function AiNerveSystem._create_buffered_event(A0_45, A1_46, A2_47)
	local L3_48
	L3_48 = {}
	L3_48.event = A1_46
	L3_48.read = false
	L3_48.has_ended = not A2_47
	return L3_48
end
function AiNerveSystem._damage_callback(A0_49, A1_50, A2_51, A3_52, A4_53, A5_54)
	local L6_55, L7_56, L8_57
	L6_55 = A0_49._is_enabled
	if not L6_55 then
		return
	end
	if not A4_53 or A4_53 ~= "collision" then
		L6_55 = A0_49._ai_data
		L6_55 = L6_55.input
		L6_55 = L6_55.buffered_damages
		L7_56 = -A3_52
		for 