require("network/control/UnitControl")
require("shared/TableAlgorithms")
if not PlayerControl then
	PlayerControl = class(UnitControl)
end
local l_0_0 = PlayerControl
local l_0_1 = {}
 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.user_controlled_extensions, l_0_1 = l_0_1, {"walking_speed", "running_speed", "mission_objective", "dynamic_dialog", "pickup_outline", "enemy_weakspot_outline", "teammate_outline"}
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_7_0, l_7_1)
	local l_7_7, l_7_8, l_7_9, l_7_10, l_7_11, l_7_12, l_7_13, l_7_14, l_7_15, l_7_16 = nil
	local l_7_2 = l_7_0._unit
	local l_7_3 = l_7_2:extensions()
	for i_0,i_1 in pairs(PlayerControl.user_controlled_extensions) do
		if TableAlgorithms.find_value(i_1, l_7_3) then
			l_7_2:set_extension_update_enabled(i_1, l_7_1)
		if l_7_2:extensions_infos()[i_1].set_extension_enabled then
			end
			l_7_2:extensions_infos()[i_1]:set_extension_enabled(l_7_1)
		end
	end
end

l_0_0.set_user_controlled_extensions_enabled = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_8_0)
	UnitControl.set_ai_controlled(l_8_0)
	local l_8_1 = l_8_0._unit
	l_8_1:damage_data():scale_health(tweak_data.ai.humans.ai_player.damage.HEALTH)
	l_8_1:damage():set_health_regen(tweak_data.ai.humans.ai_player.damage.HEALTH_REGEN_PER_SECOND, tweak_data.ai.humans.ai_player.damage.HEALTH_REGEN_DELAY)
	local l_8_2 = l_8_1:base()
	l_8_2:set_rotation_speed(tweak_data.ai.humans.ai_player.ROTATION_SPEED)
	l_8_2:set_mover_high_quality(false)
	l_8_2:set_low_frequency_update_enabled(true)
	l_8_0:set_user_controlled_extensions_enabled(false)
	local l_8_3 = l_8_1:player_data()
	l_8_3.peek_side_obstacle = false
	l_8_3.cover_obstacle = false
	l_8_3.under_fire_reactions_enabled = true
	l_8_3.large_idles_enabled = true
	l_8_0:_set_movement_speed(l_8_1, tweak_data.ai.humans.ai_player.MOVEMENT_SPEED_MULTPLIER)
	if l_8_1:pickup_outline() then
		l_8_1:pickup_outline():clean_up()
	end
	if l_8_1:enemy_weakspot_outline() then
		l_8_1:enemy_weakspot_outline():clean_up()
	end
	if l_8_1:teammate_outline() then
		l_8_1:teammate_outline():clean_up()
	end
end

l_0_0.set_ai_controlled = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_9_0, l_9_1)
	UnitControl.set_user_controlled(l_9_0, l_9_1)
	local l_9_2 = l_9_0._unit
	l_9_2:damage_data():scale_health(tweak_data.player.damage.HEALTH)
	l_9_2:damage():set_health_regen(tweak_data.player.damage.HEALTH_REGEN_PER_SECOND, tweak_data.player.damage.HEALTH_REGEN_DELAY)
	local l_9_3 = l_9_2:base()
	l_9_3:set_rotation_speed(tweak_data.player.ROTATION_SPEED)
	l_9_3:set_mover_high_quality(true)
	l_9_3:set_low_frequency_update_enabled(false)
	l_9_0:set_user_controlled_extensions_enabled(true)
	local l_9_4 = l_9_2:player_data()
	l_9_4.peek_side_obstacle = true
	l_9_4.cover_obstacle = true
	l_9_4.under_fire_reactions_enabled = true
	l_9_4.large_idles_enabled = false
	l_9_0:_set_movement_speed(l_9_2, 1)
end

l_0_0.set_user_controlled = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_10_0)
	UnitControl.set_remote_controlled(l_10_0)
	local l_10_1 = l_10_0._unit
	l_10_1:damage_data():scale_health(tweak_data.ai.humans.ai_player.damage.HEALTH)
	l_10_1:damage():set_health_regen(tweak_data.ai.humans.ai_player.damage.HEALTH_REGEN_PER_SECOND, tweak_data.ai.humans.ai_player.damage.HEALTH_REGEN_DELAY)
	local l_10_2 = l_10_1:base()
	l_10_2:set_rotation_speed(10)
	l_10_2:set_mover_high_quality(false)
	l_10_2:set_low_frequency_update_enabled(true)
	l_10_0:set_user_controlled_extensions_enabled(false)
	local l_10_3 = l_10_1:player_data()
	l_10_3.peek_side_obstacle = false
	l_10_3.cover_obstacle = false
	l_10_3.under_fire_reactions_enabled = true
	l_10_3.large_idles_enabled = true
end

l_0_0.set_remote_controlled = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_11_0)
	UnitControl.set_no_control(l_11_0)
	local l_11_1 = l_11_0._unit
	l_11_1:damage_data():scale_health(tweak_data.ai.humans.ai_player.damage.HEALTH)
	l_11_1:damage():set_health_regen(tweak_data.ai.humans.ai_player.damage.HEALTH_REGEN_PER_SECOND, tweak_data.ai.humans.ai_player.damage.HEALTH_REGEN_DELAY)
	local l_11_2 = l_11_1:base()
	l_11_2:set_rotation_speed(10)
	l_11_2:set_mover_high_quality(false)
	l_11_2:set_low_frequency_update_enabled(true)
	l_11_0:set_user_controlled_extensions_enabled(false)
	local l_11_3 = l_11_1:player_data()
	l_11_3.peek_side_obstacle = false
	l_11_3.cover_obstacle = false
	l_11_3.under_fire_reactions_enabled = true
	l_11_3.large_idles_enabled = true
end

l_0_0.set_no_control = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_12_0, l_12_1, l_12_2)
	local l_12_8, l_12_9, l_12_10, l_12_11, l_12_12, l_12_13 = nil
	local l_12_3 = l_12_1:base():character_anims()
	do
		local l_12_4 = tweak_data.player.movement.speed[l_12_3]
		for i_0,i_1 in pairs(PlayerControl._ANIM_MOVEMENT_SPEED_GLOBALS) do
			l_12_1:anim_state_machine():set_global(l_12_15, l_12_4[i_1] * l_12_2)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_12_1:player_data()[l_12_15] = l_12_4[i_1] * l_12_2
		end
	end
	 -- WARNING: undefined locals caused missing assignments!
end

l_0_0._set_movement_speed = l_0_1

