require("units/beings/machines/walker/states/WalkerState")
require("units/beings/machines/walker/states/WalkerOnGround")
require("units/beings/machines/walker/states/WalkerConnected")
if not WalkerIkTest then
	WalkerIkTest = class()
end
WalkerIkTest.init = function(l_1_0, l_1_1)
	local l_1_2 = l_1_1:anim_state_machine()
	l_1_0._ik = l_1_2:get_modifier("ik_left_hand")
end

WalkerIkTest.update = function(l_2_0, l_2_1, l_2_2, l_2_3)
	local l_2_4 = World:find_units_quick("all", managers.slot:get_mask("players"))
	if #l_2_4 == 0 then
		return 
	end
	local l_2_5, l_2_6 = next(l_2_4, nil)
	local l_2_7 = l_2_6:get_object("a_neck_grip")
	assert(l_2_7)
	local l_2_8 = l_2_7:position()
	local l_2_9 = l_2_7:rotation()
	l_2_0._ik:set_target_position(l_2_8)
	Draw:brush():sphere(l_2_8, 10)
	l_2_0._ik:set_target_rotation(l_2_9)
end


