require("units/beings/machines/walker/states/WalkerState")
require("units/beings/machines/walker/states/WalkerOnGround")
if not WalkerConnected then
	WalkerConnected = class(WalkerState)
end
WalkerConnected.init = function(l_1_0)
	WalkerState.init(l_1_0)
	local l_1_1 = l_1_0._base
	l_1_0._enemy_data = l_1_1._enemy_data
	local l_1_2 = l_1_1._special_kill_target
	local l_1_3 = l_1_1._special_kill_setup
	local l_1_4 = l_1_3.target_object_name
	l_1_2:base():dynamic_link(l_1_4, l_1_0._unit, WalkerBase._CONNECT_ALIGN_NAME)
	l_1_0._target_unit = l_1_2
	l_1_0._enemy_data.connected_to_target = true
	l_1_1:_set_override_transform(l_1_1._special_kill_position, l_1_1._special_kill_rotation)
end

WalkerConnected.exit = function(l_2_0)
	local l_2_1 = l_2_0._enemy_data
	l_2_1.connected_to_target = false
	local l_2_2 = l_2_0._target_unit
	if alive(l_2_2) then
		l_2_2:base():unlink()
	end
	l_2_0._base:_set_override_transform(nil, nil)
end

WalkerConnected.transition = function(l_3_0)
	if not l_3_0._enemy_data.connected then
		return WalkerOnGround
	end
end


