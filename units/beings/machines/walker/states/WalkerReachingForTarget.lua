require("units/beings/machines/walker/states/WalkerState")
require("units/beings/machines/walker/states/WalkerOnGround")
require("units/beings/machines/walker/states/WalkerConnected")
if not WalkerReachingForTarget then
	WalkerReachingForTarget = class(WalkerState)
end
WalkerReachingForTarget.init = function(l_1_0)
	WalkerState.init(l_1_0)
	local l_1_1 = l_1_0._unit
	local l_1_2 = l_1_0._base
	local l_1_3 = l_1_2._special_kill_target
	local l_1_4 = l_1_2._special_kill_setup
	l_1_0._target_unit = l_1_3
	l_1_0._special_kill_setup = l_1_4
	local l_1_5 = l_1_1:anim_state_machine()
	l_1_0._ik_left_hand = l_1_5:get_modifier("ik_left_hand")
	local l_1_6 = l_1_4.target_object_name
	l_1_0._target_object = l_1_3:get_object(l_1_6)
	assert(l_1_0._target_object)
	local l_1_7 = l_1_1:enemy_data()
	l_1_7.reaching_for_target = true
	l_1_0._enemy_data = l_1_7
	l_1_2:_set_override_transform(l_1_2._special_kill_position, l_1_2._special_kill_rotation)
end

WalkerReachingForTarget.update = function(l_2_0, l_2_1)
	local l_2_2 = l_2_0._unit
	local l_2_3 = l_2_0._enemy_data
	if l_2_3.reached_target then
		local l_2_4 = l_2_0._special_kill_setup
		local l_2_5 = l_2_0._target_unit:play_redirect(l_2_4.target_redirect)
		if l_2_5 == "" or l_2_5 == nil then
			l_2_2:play_redirect("abort_reach")
		else
			l_2_2:play_redirect(l_2_4.redirect)
		end
	else
		if not alive(l_2_0._target_unit) or not l_2_3.reaching_for_target and not l_2_3.reached_target then
			l_2_2:play_redirect("abort_reach")
		end
	end
	local l_2_6 = l_2_0._target_object
	assert(l_2_6)
	local l_2_7 = l_2_6:position()
	local l_2_8 = l_2_6:rotation()
	local l_2_9 = l_2_0._ik_left_hand
	l_2_9:set_target_position(l_2_7)
	l_2_9:set_target_rotation(l_2_8)
end

WalkerReachingForTarget.exit = function(l_3_0)
	local l_3_1 = l_3_0._enemy_data
	l_3_1.reaching_for_target = false
	l_3_0._base:_set_override_transform(nil, nil)
end

WalkerReachingForTarget.transition = function(l_4_0)
	local l_4_1 = l_4_0._base:check_fully_damaged()
	if l_4_1 then
		return l_4_1
	end
	local l_4_2 = l_4_0._enemy_data
	if l_4_2.connected then
		return WalkerConnected
	elseif not l_4_2.special_kill then
		return WalkerOnGround
	end
end


