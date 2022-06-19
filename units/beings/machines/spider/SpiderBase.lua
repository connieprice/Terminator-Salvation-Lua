require("ai/common/NavigationGraphUtilities")
require("projectile/InstantBulletSpawner")
require("units/beings/machines/spider/states/SpiderNormalState")
require("units/beings/machines/spider/states/SpiderDeadState")
require("units/beings/machines/spider/states/SpiderFullyDamagedState")
require("shared/updatescheduler/UpdateSchedulerDtMethod")
if not SpiderBase then
	SpiderBase = class()
end
SpiderBase._CHEST_ROTATION = Rotation(math.UP, 90)
SpiderBase._HORIZONTAL_GUN_ROTATION = SpiderBase._CHEST_ROTATION
SpiderBase._VERTICAL_GUN_ROTATION = SpiderBase._CHEST_ROTATION
SpiderBase._PREPARING_ATTACK_SOUND_NAME = "spider_detect"
SpiderBase._PREPARING_ATTACK_SOUND_OUTPUT_OBJECT_NAME = "head"
local l_0_0 = SpiderBase
local l_0_1 = {}
l_0_1.leg_front_left4 = "front_left_leg_height"
l_0_1.leg_front_right4 = "front_right_leg_height"
l_0_1.leg_back_left4 = "rear_left_leg_height"
l_0_1.leg_back_right4 = "rear_right_leg_height"
l_0_0._FEET_OBJECT_TO_GLOBAL_MACHINE_HEIGHTS = l_0_1
l_0_0 = SpiderBase
l_0_1 = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_1:set_driving("animation")
	l_1_1:set_separate_weight(l_1_0._separate_weight)
	l_1_0._state_machine = l_1_0._unit:anim_state_machine()
	l_1_0._debug_brush = Draw:brush()
	l_1_0._debug_text_brush = Draw:brush()
	l_1_0._debug_text_brush:set_font("editor_font", 60)
	l_1_0._enemy_data = l_1_1:enemy_data()
	l_1_0:_enter_state(SpiderNormalState:new(l_1_1))
	l_1_0._left_weapon = World:spawn_unit(l_1_0._left_weapon_class, l_1_0._unit:position(), l_1_0._unit:rotation())
	l_1_0._unit:link("a_fire_left", l_1_0._left_weapon, l_1_0._left_weapon:orientation_object():name())
	l_1_0._left_weapon:base():setup(l_1_1)
	l_1_0._left_weapon:base():set_equiped(true)
	l_1_0._left_weapon:base():enable()
	l_1_0._right_weapon = World:spawn_unit(l_1_0._right_weapon_class, l_1_0._unit:position(), l_1_0._unit:rotation())
	l_1_0._unit:link("a_fire_right", l_1_0._right_weapon, l_1_0._right_weapon:orientation_object():name())
	l_1_0._right_weapon:base():setup(l_1_1)
	l_1_0._right_weapon:base():set_equiped(true)
	l_1_0._right_weapon:base():enable()
	l_1_0._ik_chest = l_1_0._state_machine:get_modifier("ik_chest")
	l_1_0._ik_gun_left = l_1_0._state_machine:get_modifier("ik_gun_left")
	l_1_0._ik_gun_right = l_1_0._state_machine:get_modifier("ik_gun_right")
	l_1_0._preparing_attack_sound = Sound:make_bank(l_1_0._soundbank_name, SpiderBase._PREPARING_ATTACK_SOUND_NAME)
	local l_1_2 = l_1_1:get_object(SpiderBase._PREPARING_ATTACK_SOUND_OUTPUT_OBJECT_NAME)
	l_1_0._preparing_attack_sound:set_output(l_1_2)
	local l_1_3 = {}
	local l_1_4 = {}
	l_1_4.weapon_object = l_1_0._unit:get_object("gun_left")
	l_1_4.weapon = l_1_0._left_weapon
	l_1_4.ik = l_1_0._state_machine:get_modifier("ik_gun_left")
	l_1_4.recoil_anim = "recoil_left"
	l_1_4.weapon_data = l_1_0._left_weapon:weapon_data()
	local l_1_5 = {}
	l_1_5.weapon_object = l_1_0._unit:get_object("gun_right")
	l_1_5.weapon = l_1_0._right_weapon
	l_1_5.ik = l_1_0._state_machine:get_modifier("ik_gun_right")
	l_1_5.recoil_anim = "recoil_right"
	local l_1_7 = l_1_0._right_weapon:weapon_data
	l_1_7 = l_1_7(l_1_0._right_weapon)
	local l_1_6 = nil
	l_1_5.weapon_data = l_1_7
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	l_1_0._weapon_infos = l_1_3
	l_1_3 = l_1_0._unit
	l_1_3, l_1_4 = l_1_3:rotation, l_1_3
	l_1_3 = l_1_3(l_1_4)
	l_1_0._curr_ik_rotation = l_1_3
	l_1_0._feet_heights, l_1_3 = l_1_3, {}
	l_1_3 = pairs
	l_1_4 = SpiderBase
	l_1_4 = l_1_4._FEET_OBJECT_TO_GLOBAL_MACHINE_HEIGHTS
	l_1_3 = l_1_3(l_1_4)
	for l_1_7,l_1_6 in l_1_3 do
		assert(l_1_0._unit:get_object(l_1_7))
		local l_1_8 = l_1_0._feet_heights
		local l_1_9 = l_1_0._unit:get_object(l_1_7)
		local l_1_10 = {}
		l_1_10.global_name = l_1_6
		l_1_10.target_height = 0
		l_1_10.current_height = 0
		l_1_8[l_1_9] = l_1_10
	end
	l_1_0._ground_modifier = l_1_0._state_machine:get_modifier("ik_ground")
	l_1_0._ground_modifier:set_target_z(l_1_0._curr_ik_rotation:z())
	l_1_0:_reset_idle_timer()
	l_1_0._emitter = managers.action_event:create_emitter(l_1_1)
	l_1_0._feet_height_slot_mask = managers.slot:get_mask("footstep_decals")
	l_1_0._chest = l_1_1:get_object("spine2")
	assert(l_1_0._chest)
	l_1_0._input = l_1_1:input()
	l_1_0._damage_data = l_1_1:damage_data()
	l_1_0._low_frequency_updater = UpdateSchedulerDtMethod:new(managers.update_scheduler:add_function(l_1_0._low_frequency_update, "spider_base_low_frequency"))
	l_1_0._high_frequency_updater = UpdateSchedulerDtMethod:new(managers.update_scheduler:add_function(l_1_0._high_frequency_update, "spider_base_high_frequency"))
	l_1_0._movement_speed = 1
	l_1_0:_debug_update_scan()
	l_1_0._fwd = 1
	l_1_0._bwd = 0
	l_1_0._right = 0
	l_1_0._left = 0
	l_1_0._camera_data = l_1_1:camera_data()
	l_1_0._damage = l_1_1:damage()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.init = l_0_1
l_0_0 = SpiderBase
l_0_1 = function(l_2_0)
	managers.unit_scripting:unit_destroyed(l_2_0._unit)
	if l_2_0._state and l_2_0._state.leave then
		l_2_0._state:leave()
	end
	l_2_0._preparing_attack_sound:stop()
	if alive(l_2_0._left_weapon) then
		l_2_0._left_weapon:set_slot(0)
	end
	l_2_0._left_weapon = nil
	if alive(l_2_0._right_weapon) then
		l_2_0._right_weapon:set_slot(0)
	end
	l_2_0._right_weapon = nil
	l_2_0._emitter:destroy()
	l_2_0._low_frequency_updater:remove()
	l_2_0._high_frequency_updater:remove()
end

l_0_0.destroy = l_0_1
l_0_0 = SpiderBase
l_0_1 = function(l_3_0, l_3_1)
	if l_3_1 == "left" then
		if alive(l_3_0._left_weapon) then
			l_3_0._left_weapon:set_slot(0)
		if alive(l_3_0._right_weapon) then
			end
			l_3_0._right_weapon:base():set_sound_enabled(true)
		end
		l_3_0._left_weapon = nil
	end
	if l_3_1 == "right" then
		if alive(l_3_0._right_weapon) then
			l_3_0._right_weapon:set_slot(0)
		if alive(l_3_0._left_weapon) then
			end
			l_3_0._left_weapon:base():set_sound_enabled(true)
		end
		l_3_0._right_weapon = nil
	end
end

l_0_0.arm_destroyed = l_0_1
l_0_0 = SpiderBase
l_0_1 = function(l_4_0, l_4_1)
	if l_4_1 == "left" then
		local l_4_2 = alive
		local l_4_3 = l_4_0._left_weapon
		return l_4_2(l_4_3)
	end
	if l_4_1 == "right" then
		local l_4_4 = alive
		local l_4_5 = l_4_0._right_weapon
		return l_4_4(l_4_5)
	end
	return false
end

l_0_0.is_weapon_enabled = l_0_1
l_0_0 = SpiderBase
l_0_1 = function(l_5_0)
	local l_5_1 = l_5_0._input:aim_target_unit()
	if l_5_1 and l_5_1:local_player() then
		l_5_0._preparing_attack_sound:play()
	end
end

l_0_0.preparing_attack = l_0_1
l_0_0 = SpiderBase
l_0_1 = function(l_6_0, l_6_1, l_6_2, l_6_3)
	l_6_0._position = l_6_1:position()
	l_6_0._rotation = l_6_1:rotation()
	local l_6_4 = l_6_0._input
	l_6_0._damage:update_damage(l_6_1, l_6_2, l_6_3)
	l_6_0:_update_state(l_6_3)
	if not l_6_0._enemy_data.dead then
		local l_6_5 = l_6_4:movement()
		mvector3.multiply(l_6_5, tweak_data.enemy.spider.MAX_MOVEMENT_SPEED)
		local l_6_6 = l_6_4:aim_target_position()
		local l_6_7 = l_6_0._curr_ik_rotation:z()
		l_6_0:_update_movement(l_6_1, l_6_3, l_6_5, l_6_6, l_6_7)
		l_6_0._low_frequency_updater:update(l_6_0, l_6_3, l_6_1, l_6_6, l_6_7)
		l_6_0._high_frequency_updater:update(l_6_0, l_6_3, l_6_1, l_6_6)
	end
	l_6_0._camera_data.eye_target_position = l_6_4:eye_target_position()
end

l_0_0.update = l_0_1
l_0_0 = SpiderBase
l_0_1 = function(l_7_0, l_7_1, l_7_2, l_7_3)
	l_7_0:_update_aiming(l_7_2, l_7_1, l_7_3)
end

l_0_0._high_frequency_update = l_0_1
l_0_0 = SpiderBase
l_0_1 = function(l_8_0, l_8_1, l_8_2, l_8_3, l_8_4)
	l_8_0:_update_feet_height(l_8_2, l_8_1, l_8_4)
	l_8_0:_update_up_direction(l_8_2, l_8_1)
	l_8_0:_update_idle(l_8_2)
end

l_0_0._low_frequency_update = l_0_1
l_0_0 = SpiderBase
l_0_1 = function(l_9_0)
	local l_9_1 = l_9_0._state_machine
	l_9_1:set_global("scan_speed", tweak_data.enemy.spider.SCAN_SPEED)
	l_9_1:set_global("scan_span", math.clamp((tweak_data.enemy.spider.SCAN_ANGLE - 45) / 135, 0, 1))
end

l_0_0._debug_update_scan = l_0_1
l_0_0 = SpiderBase
l_0_1 = function(l_10_0, l_10_1)
	local l_10_2 = l_10_0._state:update(l_10_1)
	if l_10_2 then
		l_10_0:_enter_state(l_10_2)
	end
end

l_0_0._update_state = l_0_1
l_0_0 = SpiderBase
l_0_1 = function(l_11_0, l_11_1)
	if l_11_0._state and l_11_0._state.leave then
		l_11_0._state:leave()
	end
	l_11_0:_reset_idle_timer()
	l_11_0._state = l_11_1
	if l_11_0._state.enter then
		l_11_0._state:enter()
	end
end

l_0_0._enter_state = l_0_1
l_0_0 = SpiderBase
l_0_1 = function(l_12_0, l_12_1, l_12_2)
	local l_12_3 = l_12_1:mover():standing_normal()
	local l_12_4 = math.acos(mvector3.dot(l_12_3, math.UP))
	local l_12_5 = l_12_0._max_ground_rotation_angle
	if l_12_5 < l_12_4 then
		local l_12_6 = Vector3(0, 0, 0)
		mvector3.cross(l_12_6, math.UP, l_12_3)
		mvector3.normalize(l_12_6)
		local l_12_7 = Rotation()
		local l_12_8 = l_12_7 + Rotation(l_12_6, l_12_5)
		l_12_3 = l_12_8:z()
	end
	local l_12_9 = l_12_0._rotation:y():flat(l_12_3):normalized()
	local l_12_10 = Rotation(l_12_9, l_12_3)
	l_12_0._curr_ik_rotation = l_12_0._curr_ik_rotation:slerp(l_12_10, l_12_0._ground_rotation_dampening * l_12_2)
	l_12_0._ground_modifier:set_target_z(l_12_0._curr_ik_rotation:z())
end

l_0_0._update_up_direction = l_0_1
l_0_0 = SpiderBase
l_0_1 = function(l_13_0, l_13_1, l_13_2, l_13_3)
	local l_13_4 = l_13_0._max_foot_lift_drop
	local l_13_5 = l_13_2:position()
	local l_13_6 = mvector3.copy(l_13_5)
	mvector3.subtract(l_13_6, l_13_0._position)
	local l_13_7 = mvector3.dot(l_13_1, l_13_6)
	mvector3.set(l_13_6, l_13_1)
	mvector3.multiply(l_13_6, -l_13_7 - l_13_4)
	mvector3.add(l_13_6, l_13_5)
	local l_13_8 = mvector3.copy(l_13_1)
	mvector3.multiply(l_13_8, 3 * l_13_4)
	mvector3.add(l_13_8, l_13_6)
	local l_13_9 = l_13_0._unit:raycast("ray", l_13_8, l_13_6, "slot_mask", l_13_0._feet_height_slot_mask)
	local l_13_10 = -1
	if l_13_9 then
		l_13_10 = 1 - 2 * (math.clamp(l_13_9.distance - l_13_4, 0, 2 * l_13_4) / (2 * l_13_4))
	end
	l_13_3.target_height = l_13_10
end

l_0_0._update_foot_target_height = l_0_1
l_0_0 = SpiderBase
l_0_1 = function(l_14_0, l_14_1, l_14_2, l_14_3)
	local l_14_11, l_14_12, l_14_13, l_14_14, l_14_15, l_14_16, l_14_17, l_14_18 = nil
	local l_14_4, l_14_5 = next(l_14_0._feet_heights, l_14_0._curr_foot_object)
	if not l_14_4 then
		l_14_4 = next(l_14_0._feet_heights, nil)
	end
	assert(l_14_4)
	assert(l_14_5)
	l_14_0:_update_foot_target_height(l_14_3, l_14_4, l_14_5)
	l_14_0._curr_foot_object = l_14_4
	local l_14_6 = l_14_0._state_machine
	local l_14_7 = math.clamp(l_14_0._foot_dampening * l_14_2, 0, 1)
	for i_0,i_1 in pairs(l_14_0._feet_heights) do
		 -- DECOMPILER ERROR: Confused about usage of registers!

		local l_14_21 = nil
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if i_1.current_height + l_14_7 * (l_14_20.target_height - i_1.current_height) ~= l_14_21 then
			l_14_6:set_global(i_1.global_name, i_1.current_height + l_14_7 * (l_14_20.target_height - i_1.current_height))
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_14_20.current_height = i_1.current_height + l_14_7 * (l_14_20.target_height - i_1.current_height)
		end
	end
end

l_0_0._update_feet_height = l_0_1
l_0_0 = SpiderBase
l_0_1 = function(l_15_0, l_15_1, l_15_2, l_15_3, l_15_4, l_15_5)
	if (not l_15_0._state:can_move() and not l_15_0._state:can_rotate()) or l_15_0._enemy_data.hurt_reaction then
		return 
	end
	local l_15_6 = nil
	if l_15_4 then
		l_15_6 = mvector3.copy(l_15_4)
		mvector3.subtract(l_15_6, l_15_0._position)
		if mvector3.length(l_15_6) > 0 then
			mvector3.normalize(l_15_6)
		end
	else
		l_15_6 = nil
	end
	local l_15_7 = mvector3.length(l_15_3)
	if l_15_7 > 0 then
		local l_15_8 = l_15_0._rotation
		local l_15_9 = nil
		if l_15_6 then
			l_15_9 = Vector3(0, 0, 0)
			local l_15_10 = Vector3(0, 0, 0)
			mvector3.cross(l_15_9, l_15_5, l_15_6)
			mvector3.cross(l_15_10, l_15_9, l_15_5)
			if mvector3.length(l_15_10) > 0 then
				l_15_9 = mvector3.copy(l_15_10)
				mvector3.normalize(l_15_9)
			else
				l_15_9 = l_15_8:y()
			end
		else
			l_15_9 = mvector3.copy(l_15_3)
			mvector3.divide(l_15_9, l_15_7)
		end
		local l_15_11 = Rotation(l_15_9, l_15_5)
		l_15_8 = l_15_8:slerp(l_15_11, 2 * l_15_2)
		l_15_1:set_rotation(l_15_8)
		mvector3.normalize(l_15_3)
		local l_15_12 = l_15_8:y()
		local l_15_13 = l_15_8:x()
		local l_15_14 = math.acos(mvector3.dot(l_15_3, l_15_12))
		local l_15_15 = math.acos(mvector3.dot(l_15_3, l_15_13))
		local l_15_16 = math.clamp(1 - l_15_14 / 90, 0, 1)
		local l_15_17 = math.clamp((l_15_14 - 90) / 90, 0, 1)
		local l_15_18 = math.clamp(1 - l_15_15 / 90, 0, 1)
		local l_15_19 = math.clamp((l_15_15 - 90) / 90, 0, 1)
		if not l_15_0._enemy_data.moving then
			l_15_1:play_redirect("walk")
		end
		local l_15_20 = l_15_0._state_machine
		if math.abs(l_15_0._fwd - l_15_16) > 0.001 then
			l_15_20:set_global("fwd", l_15_16)
			l_15_0._fwd = l_15_16
		end
		if math.abs(l_15_0._bwd - l_15_17) > 0.001 then
			l_15_20:set_global("bwd", l_15_17)
			l_15_0._bwd = l_15_17
		end
		if math.abs(l_15_0._left - l_15_19) > 0.001 then
			l_15_20:set_global("lt", l_15_19)
			l_15_0._left = l_15_19
		end
		if math.abs(l_15_0._right - l_15_18) > 0.001 then
			l_15_20:set_global("rt", l_15_18)
			l_15_0._right = l_15_18
		end
		local l_15_21 = (math.sqrt((l_15_16 + l_15_17) * (l_15_16 + l_15_17) + (l_15_19 + l_15_18) * (l_15_19 + l_15_18)))
		local l_15_22 = nil
		if l_15_21 > 0 then
			l_15_22 = l_15_7 / l_15_21
		else
			l_15_22 = 0
		end
		if math.abs(l_15_22 - l_15_0._movement_speed) > 0.001 then
			l_15_20:set_global("movement_speed", l_15_22)
			l_15_0._movement_speed = l_15_22
		end
	else
		local l_15_23 = nil
		local l_15_24 = l_15_0._rotation
		local l_15_25 = l_15_24:y()
		local l_15_26 = (l_15_24:x())
		local l_15_27 = nil
		if l_15_6 then
			l_15_27 = Vector3(0, 0, 0)
			local l_15_28 = Vector3(0, 0, 0)
			mvector3.cross(l_15_27, l_15_5, l_15_6)
			mvector3.cross(l_15_28, l_15_27, l_15_5)
			if mvector3.length(l_15_28) > 0 then
				l_15_27 = l_15_28
				mvector3.normalize(l_15_27)
			else
				l_15_27 = l_15_24:y()
			end
		else
			l_15_27 = l_15_24:y()
		end
		local l_15_29 = math.acos(mvector3.dot(l_15_25, l_15_27))
		local l_15_30 = mvector3.dot(l_15_26, l_15_27)
		local l_15_37 = not l_15_0._state:can_rotate() or (tweak_data.enemy.spider.MAX_CHEST_ROTATION < l_15_29 and l_15_30 < 0)
	if l_15_37 and not l_15_0._enemy_data.rotating_left then
		end
		l_15_1:play_redirect("rotate_left")
	end
	do return end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not l_15_0._state:can_rotate() or (tweak_data.enemy.spider.MAX_CHEST_ROTATION < l_15_29 and l_15_30 > 0) and not l_15_0._enemy_data.rotating_right then
		l_15_1:play_redirect("rotate_right")
	end
	do return end
	l_15_0._idle_timer = l_15_0._idle_timer - l_15_2
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_15_0._enemy_data.moving or l_15_0._enemy_data.rotating_left or l_15_0._enemy_data.rotating_right then
		l_15_1:play_redirect("stand_still")
	end
end

l_0_0._update_movement = l_0_1
l_0_0 = function(l_16_0, l_16_1, l_16_2)
	local l_16_3 = mvector3.angle(l_16_0, l_16_1)
	if l_16_2 < l_16_3 then
		local l_16_4 = Vector3()
		mvector3.cross(l_16_4, l_16_0, l_16_1)
		mvector3.normalize(l_16_4)
		local l_16_5 = Rotation(l_16_4, l_16_2)
		return l_16_0:rotate_with(l_16_5)
	else
		return l_16_1
	end
end

limit_direction = l_0_0
l_0_0 = SpiderBase
l_0_1 = function(l_17_0, l_17_1, l_17_2, l_17_3)
	if l_17_0._enemy_data.hurt_reaction or l_17_0._enemy_data.is_stunned then
		l_17_0._enemy_data.can_fire = false
		l_17_0._enemy_data.firing = false
		return 
	end
	local l_17_4 = l_17_0._position
	local l_17_5 = l_17_0._rotation
	local l_17_6 = false
	local l_17_7 = false
	local l_17_8 = nil
	if l_17_3 then
		l_17_8 = mvector3.copy(l_17_3)
	else
		l_17_8 = mvector3.copy(l_17_5:y())
		mvector3.multiply(l_17_8, 100000)
		mvector3.add(l_17_8, l_17_4)
	end
	local l_17_9 = l_17_5:z()
	local l_17_10 = mvector3.copy(l_17_8)
	mvector3.subtract(l_17_10, l_17_4)
	local l_17_11 = mvector3.length(l_17_10)
	local l_17_12 = l_17_0._chest
	assert(l_17_12)
	local l_17_22, l_17_23 = mvector3.copy, l_17_12:rotation():z()
	l_17_22 = l_17_22(l_17_23)
	local l_17_13 = nil
	l_17_23 = mvector3
	l_17_23 = l_17_23.negate
	l_17_13 = l_17_22
	l_17_23(l_17_13)
	l_17_23, l_17_13 = l_17_10:flat, l_17_10
	l_17_23 = l_17_23(l_17_13, l_17_9)
	local l_17_14 = nil
	l_17_13 = mvector3
	l_17_13 = l_17_13.length
	l_17_14 = l_17_23
	l_17_13 = l_17_13(l_17_14)
	local l_17_15 = nil
	if l_17_13 > 0 then
		l_17_14 = mvector3
		l_17_14 = l_17_14.divide
		l_17_15 = l_17_23
		l_17_14(l_17_15, l_17_13)
		l_17_14 = limit_direction
		l_17_15 = l_17_22
		l_17_14 = l_17_14(l_17_15, l_17_23, tweak_data.enemy.spider.MAX_CHEST_ROTATION_SPEED * l_17_2)
		l_17_22 = l_17_14
		l_17_14 = limit_direction
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_17_14 = l_17_14(l_17_15, l_17_22, tweak_data.enemy.spider.MAX_CHEST_ROTATION)
		l_17_22 = l_17_14
		l_17_14 = l_17_0._ik_chest
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_17_14 = l_17_14:set_target_z
		l_17_14(l_17_15, -l_17_22)
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_17_14 = l_17_22:flat
	l_17_14 = l_17_14(l_17_15, l_17_9)
	local l_17_16 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_17_16 = l_17_14
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_17_17 = nil
	if l_17_15 > 0 then
		l_17_16 = mvector3
		l_17_16 = l_17_16.divide
		l_17_17 = l_17_14
		l_17_16(l_17_17, l_17_15)
	else
		l_17_16 = mvector3
		l_17_16 = l_17_16.set
		l_17_17 = l_17_14
		l_17_16(l_17_17, l_17_22)
	end
	l_17_16 = l_17_0._input
	l_17_16, l_17_17 = l_17_16:miss_dispersion, l_17_16
	l_17_16 = l_17_16(l_17_17)
	local l_17_18 = nil
	l_17_17 = pairs
	l_17_18 = l_17_0._weapon_infos
	l_17_17 = l_17_17(l_17_18)
	for i_0,i_1 in l_17_17 do
		local l_17_24 = l_17_21.weapon_object
		local l_17_25 = l_17_24:position()
		local l_17_26 = mvector3.copy(l_17_8)
		mvector3.subtract(l_17_26, l_17_25)
		local l_17_27 = mvector3.length(l_17_26)
		if l_17_27 > 0 then
			local l_17_28 = l_17_24:rotation():x()
			mvector3.divide(l_17_26, l_17_27)
			local l_17_29 = limit_direction(l_17_28, l_17_26, tweak_data.enemy.spider.MAX_WEAPON_ROTATION_SPEED * l_17_2)
			l_17_29 = limit_direction(l_17_14, l_17_29, tweak_data.enemy.spider.MAX_WEAPON_ROTATION)
			local l_17_30 = mvector3.copy(l_17_29)
			mvector3.multiply(l_17_30, l_17_27)
			local l_17_31 = l_17_21.weapon
			if alive(l_17_31) then
				local l_17_32 = l_17_21.weapon_data
				local l_17_33 = mvector3.copy(l_17_25)
				mvector3.add(l_17_33, l_17_30)
				mvector3.set(l_17_32.aim_target_position, l_17_33)
				l_17_32.miss_dispersion = l_17_16
				if l_17_32._on_fire then
					l_17_0._unit:play_redirect(l_17_21.recoil_anim)
				end
			if not l_17_7 then
				end
				l_17_7 = l_17_32._firing
			end
			local l_17_34 = mvector3.angle(l_17_29, l_17_26)
			if l_17_34 <= tweak_data.enemy.spider.MAX_WEAPON_FIRE_ANGLE_DIFF then
				l_17_6 = true
			end
			l_17_21.ik:set_target_x(l_17_29)
		end
	end
	l_17_0._enemy_data.firing = l_17_7
	l_17_0._enemy_data.can_fire = l_17_6
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0._update_aiming = l_0_1
l_0_0 = SpiderBase
l_0_1 = function(l_18_0, l_18_1)
	if Global.category_debug_render.ai then
		l_18_0._debug_brush:set_persistance(0.5)
		local l_18_2 = l_18_0._rotation
		local l_18_3 = l_18_0._position + 100 * math.UP
		local l_18_4 = l_18_2:y()
		l_18_0._debug_brush:set_color(Color(1, 1, 1))
		l_18_0._debug_brush:line(l_18_3, l_18_3 + 200 * l_18_4)
		l_18_0._debug_brush:set_color(Color(0, 1, 0))
		l_18_0._debug_brush:line(l_18_3, l_18_3 + 200 * l_18_1:input():movement())
	end
end

l_0_0._debug_draw = l_0_1
l_0_0 = SpiderBase
l_0_1 = function(l_19_0)
	l_19_0._idle_timer = math.random(tweak_data.enemy.spider.IDLE_TIME.min, tweak_data.enemy.spider.IDLE_TIME.max)
end

l_0_0._reset_idle_timer = l_0_1
l_0_0 = SpiderBase
l_0_1 = function(l_20_0, l_20_1)
	if l_20_0._idle_timer < 0 then
		local l_20_2 = "idle_" .. math.random(2, 4)
		l_20_1:play_redirect(l_20_2)
		l_20_0:_reset_idle_timer()
	end
end

l_0_0._update_idle = l_0_1
l_0_0 = SpiderBase
l_0_1 = function(l_21_0)
	if l_21_0._damage_data:is_fully_damaged() then
		local l_21_1, l_21_2 = SpiderFullyDamagedState:new, SpiderFullyDamagedState
		local l_21_3 = l_21_0._unit
		return l_21_1(l_21_2, l_21_3)
	end
end

l_0_0.check_fully_damaged = l_0_1
l_0_0 = SpiderBase
l_0_1 = function(l_22_0, l_22_1)
	local l_22_2 = l_22_0._unit:play_redirect(l_22_1)
	if l_22_2 == "" then
		cat_print("debug", "Redirect '" .. l_22_1 .. "' not defined from current states")
	end
end

l_0_0.play_custom_animation = l_0_1

