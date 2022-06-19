if not DebugUserJoinStateFindController then
	DebugUserJoinStateFindController = class(FiniteStateMachineState)
end
DebugUserJoinStateFindController.update = function(l_1_0)
	local l_1_7, l_1_8, l_1_9, l_1_10 = nil
	local l_1_1 = managers.local_user:users()
	local l_1_2 = l_1_0._default_controller_type
	local l_1_3 = nil
	for i_0,i_1 in pairs(l_1_1) do
		if i_1:controller_wrapper():get_type() == l_1_0.joiner.default_controller_type then
			l_1_0.joiner._user = l_1_12
		elseif not l_1_0._user then
			l_1_0.joiner._user = l_1_12
		end
	end
end

DebugUserJoinStateFindController.transition = function(l_2_0)
	if managers.save:has_primary_user() then
		return DebugUserJoinStateDone
	end
	if l_2_0.joiner._user then
		return DebugUserJoinStateWaitForStabilization
	end
end

if not DebugUserJoinStateWaitForStabilization then
	DebugUserJoinStateWaitForStabilization = class(FiniteStateMachineState)
end
DebugUserJoinStateWaitForStabilization.init = function(l_3_0)
	l_3_0._time = 0
end

DebugUserJoinStateWaitForStabilization.update = function(l_4_0, l_4_1)
	l_4_0._time = l_4_0._time + l_4_1
end

DebugUserJoinStateWaitForStabilization.transition = function(l_5_0)
	if l_5_0._time < 5 then
		return 
	end
	return DebugUserJoinStateWaitForProfile
end

if not DebugUserJoinStateWaitForProfile then
	DebugUserJoinStateWaitForProfile = class(FiniteStateMachineState)
end
DebugUserJoinStateWaitForProfile.init = function(l_6_0)
	managers.save:select_primary_user(l_6_0.joiner._user)
	l_6_0.joiner._user:debug_join()
end

DebugUserJoinStateWaitForProfile.transition = function(l_7_0)
	if l_7_0.joiner._user:is_profile_ready() then
		return DebugUserJoinStateDone
	end
end

DebugUserJoinStateWaitForProfile.exit = function(l_8_0)
	local l_8_1 = 1
	l_8_0.joiner._user:set_wanted_player_slot_id(l_8_1)
	l_8_0.joiner._user:profile().difficulty_level = 1
	managers.menu_input:set_bound_user(l_8_0.joiner._user)
end

if not DebugUserJoinStateDone then
	DebugUserJoinStateDone = class(FiniteStateMachineState)
end
DebugUserJoinStateDone.transition = function(l_9_0)
end

if not DebugUserJoin then
	DebugUserJoin = class()
end
DebugUserJoin.init = function(l_10_0, l_10_1)
	l_10_0._default_controller_type = l_10_1
	cat_print("debug", "DebugUserJoin created!")
	l_10_0._state = FiniteStateMachine:new(l_10_0, "joiner", DebugUserJoinStateFindController)
	l_10_0._state:set_debug(true)
end

DebugUserJoin.update = function(l_11_0, l_11_1)
	l_11_0._state:update(l_11_1)
end


