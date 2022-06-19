require("units/beings/CharacterControllerInterpreter/DebugBasicAimStateCI")
require("units/beings/CharacterControllerInterpreter/DebugPrecisionAimableAimSM")
require("shared/aimer/BallisticProjectileAimer")
if not WalkerControllerInterpreter then
	WalkerControllerInterpreter = class(DebugBasicAimStateControllerInterpreter)
end
WalkerControllerInterpreter.init = function(l_1_0, l_1_1)
	DebugBasicAimStateControllerInterpreter.init(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._input = l_1_1:input()
	assert(l_1_0._input)
	local l_1_2, l_1_3 = BallisticProjectileAimer:new, BallisticProjectileAimer
	local l_1_4 = {}
	l_1_4.initial_speed = 2000
	l_1_2 = l_1_2(l_1_3, l_1_4)
	l_1_0._secondary_aimer = l_1_2
	l_1_2, l_1_3 = l_1_1:get_object, l_1_1
	l_1_4 = "a_weapon_left_back"
	l_1_2 = l_1_2(l_1_3, l_1_4)
	l_1_0._secondary_fire_object = l_1_2
end

WalkerControllerInterpreter.enable = function(l_2_0, l_2_1)
	l_2_0._controller_wrapper = l_2_1
	DebugPrecisionAimableAimSettingsModifier.update(l_2_0, false)
end

WalkerControllerInterpreter.disable = function(l_3_0)
	l_3_0._controller_wrapper = nil
end

local l_0_0 = function(l_4_0, l_4_1, l_4_2, l_4_3)
	local l_4_4 = managers.slot:get_mask("shootable_wo_adr_shield")
	local l_4_5 = (l_4_0:raycast("ray", l_4_2, l_4_3, "slot_mask", l_4_4))
	local l_4_6 = nil
	if l_4_5 then
		l_4_6 = l_4_5.position
	else
		l_4_6 = l_4_3
	end
	l_4_1:set_primary_aim_target_position(l_4_6)
end

WalkerControllerInterpreter._update_world_space_controller = function(l_5_0, l_5_1, l_5_2, l_5_3)
	local l_5_4 = l_5_2:get_input_axis("move")
	l_5_3:set_movement(l_5_4)
	local l_5_5 = (l_5_2:get_input_axis("look"))
	local l_5_6 = nil
	if l_5_5:length() < 0.1 then
		l_5_6 = l_5_1:position() + l_5_1:rotation():y() * 10000
	else
		l_5_6 = l_5_1:position() + l_5_5:normalized() * 10000
	end
	l_5_3:set_eye_target_position(l_5_6)
	l_5_3:set_primary_aim_target_position(l_5_6)
	l_5_3:set_secondary_aim_target_position(l_5_6)
	if l_5_2:get_input_bool("fire") then
		l_5_3:set_primary_fire()
		l_5_3:set_secondary_fire()
	end
	if l_5_2:get_input_bool("zoom") then
		l_5_3:set_prepare_primary_fire()
		l_5_3:set_prepare_secondary_fire()
	end
end

WalkerControllerInterpreter.update = function(l_6_0, l_6_1, l_6_2, l_6_3)
	-- upvalues: l_0_0
	DebugPrecisionAimableAimSettingsModifier.update(l_6_0, false)
	local l_6_4 = l_6_0._controller_wrapper
	assert(l_6_4)
	local l_6_5 = l_6_0._input
	local l_6_6 = l_6_1:camera_data()
	assert(l_6_6)
	l_6_5:clear()
	do return end
	l_6_0:_update_world_space_controller(l_6_1, l_6_4, l_6_5)
	return 
	DebugBasicAimStateControllerInterpreter.update(l_6_0, l_6_4, l_6_3)
	local l_6_7 = l_6_5:eye_target_position()
	local l_6_8 = l_6_4:get_input_axis("move")
	local l_6_9 = l_6_6.camera_rotation:x()
	local l_6_10 = l_6_6.camera_rotation:y()
	local l_6_11 = l_6_9:flat(math.UP):normalized()
	local l_6_12 = l_6_10:flat(math.UP):normalized()
	local l_6_13 = l_6_8.x * l_6_11
	local l_6_14 = l_6_8.y * l_6_12
	local l_6_15 = l_6_13 + l_6_14
	l_6_5:set_movement(l_6_15)
	local l_6_16 = l_6_6.camera_position
	l_0_0(l_6_1, l_6_5, l_6_16, l_6_16 + l_6_10 * 1000)
	local l_6_24, l_6_25 = World:find_units, World
	l_6_24 = (l_6_24(l_6_25, "sphere", l_6_1:position(), 1000, managers.slot:get_mask("players")))
	local l_6_17 = nil
	l_6_17, l_6_25 = nil
	local l_6_18, l_6_19 = nil
	l_6_18 = #l_6_24
	if l_6_18 > 0 then
		l_6_18 = nil
		local l_6_20 = nil
		l_6_19 = pairs
		l_6_20 = l_6_24
		l_6_19 = l_6_19(l_6_20)
		for i_0,i_1 in l_6_19 do
			local l_6_26 = l_6_1:position() - l_6_23:position():length()
			if not l_6_18 or l_6_26 < l_6_18 then
				l_6_17 = l_6_23
				l_6_18 = l_6_26
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_6_17 then
		l_6_25 = l_6_18
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_6_18 then
			assert(R23_PC126)
			l_6_5:set_special_kill(l_6_17, l_6_0._unit:enemy_data().special_kill_setups.id)
		end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		if l_6_1:raycast("ray", l_6_16, l_6_7 - l_6_16:normalized() * 10000, "slot_mask", l_6_18) then
			l_6_25 = l_6_1:raycast("ray", l_6_16, l_6_7 - l_6_16:normalized() * 10000, "slot_mask", l_6_18).position
		end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	else
		l_6_25 = l_6_7 - l_6_16:normalized() * 10000
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_6_25 then
		l_6_25 = l_6_18
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_6_18(l_6_5, l_6_25)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_6_18 then
		l_6_18(l_6_5)
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_6_18(l_6_5)
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_6_18 and l_6_4:get_input_pressed(R23_PC126) then
		l_6_5:set_remove_magcharge(R23_PC126)
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_6_4:get_input_bool(R23_PC126) then
		l_6_5:set_prepare_primary_fire()
		l_6_5:set_prepare_secondary_fire()
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_6_4:get_input_pressed(R23_PC126) then
		if l_6_4:get_input_axis(R23_PC126):length() > 0 then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Confused about usage of registers!

		R23_PC126(l_6_5, l_6_4:get_input_axis(R23_PC126) / l_6_4:get_input_axis(R23_PC126):length().x * l_6_11 + l_6_4:get_input_axis(R23_PC126) / l_6_4:get_input_axis(R23_PC126):length().y * l_6_12)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

WalkerControllerInterpreter._magcharge_attachment_point_name = function(l_7_0)
	local l_7_6, l_7_7, l_7_8, l_7_9 = nil
	local l_7_1 = l_7_0._unit:attachment()
	assert(l_7_1)
	local l_7_2 = l_7_1:attachment_points()
	for i_0,i_1 in pairs(l_7_2) do
		if #i_1:attached_units() > 0 then
			local l_7_12 = nil
			local l_7_13, l_7_14 = next(i_1:attached_units(), nil)
			return l_7_11:name()
		end
	end
end


