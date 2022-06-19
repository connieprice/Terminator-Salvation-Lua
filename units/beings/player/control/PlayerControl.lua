require("network/control/UnitControl")
require("shared/TableAlgorithms")
PlayerControl = PlayerControl or class(UnitControl)
PlayerControl._ANIM_MOVEMENT_SPEED_GLOBALS = {
	"walking_speed",
	"running_speed"
}
function not_functions(A0_0)
	return type(A0_0) ~= "function"
end
function PlayerControl.init(A0_1, A1_2)
	UnitControl.init(A0_1, A1_2)
	managers.player:register_player_unit(A1_2)
end
function PlayerControl.destroy(A0_3, A1_4)
	UnitControl.destroy(A0_3, A1_4)
	managers.player:unregister_player_unit(A1_4)
end
function PlayerControl.send_input(A0_5, A1_6)
	local L2_7, L3_8
	L2_7 = assert
	L3_8 = A1_6
	L2_7(L3_8)
	L2_7 = A0_5._unit
	L3_8 = L2_7
	L2_7 = L2_7.input
	L2_7 = L2_7(L3_8)
	L3_8 = TableAlgorithms
	L3_8 = L3_8.copy_if
	L3_8 = L3_8(L2_7, not_functions)
	A1_6:player_input(A0_5:unit_id(), L3_8)
	L2_7:clear()
end
function PlayerControl.receive_input(A0_9, A1_10)
	A0_9._unit:input():set(A1_10)
end
function PlayerControl.player_input(A0_11, A1_12)
	A0_11:push_input(A1_12)
end
PlayerControl.user_controlled_extensions = {
	"hud",
	"hud_sound",
	"mission_objective",
	"dynamic_dialog",
	"pickup_outline",
	"enemy_weakspot_outline",
	"teammate_outline"
}
function PlayerControl.set_user_controlled_extensions_enabled(A0_13, A1_14)
	local L2_15, L3_16, L4_17, L5_18, L6_19, L7_20, L8_21
	L2_15 = A0_13._unit
	L3_16 = L2_15.extensions
	L3_16 = L3_16(L4_17)
	for L7_20, L8_21 in L4_17(L5_18) do
		if TableAlgorithms.find_value(L8_21, L3_16) then
			L2_15:set_extension_update_enabled(L8_21, A1_14)
			if L2_15:extensions_infos()[L8_21].set_extension_enabled then
				L2_15:extensions_infos()[L8_21]:set_extension_enabled(A1_14)
			end
		end
	end
end
function PlayerControl.set_ai_controlled(A0_22)
	local L1_23
	L1_23 = UnitControl
	L1_23 = L1_23.set_ai_controlled
	L1_23(A0_22)
	L1_23 = A0_22._unit
	L1_23:damage_data():scale_health(tweak_data.ai.humans.ai_player.damage.HEALTH)
	L1_23:damage():set_health_regen(tweak_data.ai.humans.ai_player.damage.HEALTH_REGEN_PER_SECOND, tweak_data.ai.humans.ai_player.damage.HEALTH_REGEN_DELAY)
	L1_23:base():set_rotation_speed(tweak_data.ai.humans.ai_player.ROTATION_SPEED)
	L1_23:base():set_mover_high_quality(false)
	L1_23:base():set_low_frequency_update_enabled(true)
	A0_22:set_user_controlled_extensions_enabled(false)
	L1_23:player_data().peek_side_obstacle = false
	L1_23:player_data().cover_obstacle = false
	L1_23:player_data().under_fire_reactions_enabled = true
	L1_23:player_data().large_idles_enabled = true
	A0_22:_set_movement_speed(L1_23, tweak_data.ai.humans.ai_player.MOVEMENT_SPEED_MULTPLIER)
	if L1_23:pickup_outline() then
		L1_23:pickup_outline():clean_up()
	end
	if L1_23:enemy_weakspot_outline() then
		L1_23:enemy_weakspot_outline():clean_up()
	end
	if L1_23:teammate_outline() then
		L1_23:teammate_outline():clean_up()
	end
end
function PlayerControl.set_user_controlled(A0_24, A1_25)
	local L2_26
	L2_26 = UnitControl
	L2_26 = L2_26.set_user_controlled
	L2_26(A0_24, A1_25)
	L2_26 = A0_24._unit
	L2_26:damage_data():scale_health(tweak_data.player.damage.HEALTH)
	L2_26:damage():set_health_regen(tweak_data.player.damage.HEALTH_REGEN_PER_SECOND, tweak_data.player.damage.HEALTH_REGEN_DELAY)
	L2_26:base():set_rotation_speed(tweak_data.player.ROTATION_SPEED)
	L2_26:base():set_mover_high_quality(true)
	L2_26:base():set_low_frequency_update_enabled(false)
	A0_24:set_user_controlled_extensions_enabled(true)
	L2_26:player_data().peek_side_obstacle = true
	L2_26:player_data().cover_obstacle = true
	L2_26:player_data().under_fire_reactions_enabled = true
	L2_26:player_data().large_idles_enabled = false
	A0_24:_set_movement_speed(L2_26, 1)
end
function PlayerControl.set_remote_controlled(A0_27)
	UnitControl.set_remote_controlled(A0_27)
	A0_27._unit:damage_data():scale_health(tweak_data.ai.humans.ai_player.damage.HEALTH)
	A0_27._unit:damage():set_health_regen(tweak_data.ai.humans.ai_player.damage.HEALTH_REGEN_PER_SECOND, tweak_data.ai.humans.ai_player.damage.HEALTH_REGEN_DELAY)
	A0_27._unit:base():set_rotation_speed(10)
	A0_27._unit:base():set_mover_high_quality(false)
	A0_27._unit:base():set_low_frequency_update_enabled(true)
	A0_27:set_user_controlled_extensions_enabled(false)
	A0_27._unit:player_data().peek_side_obstacle = false
	A0_27._unit:player_data().cover_obstacle = false
	A0_27._unit:player_data().under_fire_reactions_enabled = true
	A0_27._unit:player_data().large_idles_enabled = true
end
function PlayerControl.set_no_control(A0_28)
	UnitControl.set_no_control(A0_28)
	A0_28._unit:damage_data():scale_health(tweak_data.ai.humans.ai_player.damage.HEALTH)
	A0_28._unit:damage():set_health_regen(tweak_data.ai.humans.ai_player.damage.HEALTH_REGEN_PER_SECOND, tweak_data.ai.humans.ai_player.damage.HEALTH_REGEN_DELAY)
	A0_28._unit:base():set_rotation_speed(10)
	A0_28._unit:base():set_mover_high_quality(false)
	A0_28._unit:base():set_low_frequency_update_enabled(true)
	A0_28:set_user_controlled_extensions_enabled(false)
	A0_28._unit:player_data().peek_side_obstacle = false
	A0_28._unit:player_data().cover_obstacle = false
	A0_28._unit:player_data().under_fire_reactions_enabled = true
	A0_28._unit:player_data().large_idles_enabled = true
end
function PlayerControl._set_movement_speed(A0_29, A1_30, A2_31)
	local L3_32, L4_33, L5_34, L6_35, L7_36, L8_37, L9_38, L10_39, L11_40
	L4_33 = A1_30
	L3_32 = A1_30.base
	L3_32 = L3_32(L4_33)
	L4_33 = L3_32
	L3_32 = L3_32.character_anims
	L3_32 = L3_32(L4_33)
	L4_33 = tweak_data
	L4_33 = L4_33.player
	L4_33 = L4_33.movement
	L4_33 = L4_33.speed
	L4_33 = L4_33[L3_32]
	for L8_37, L9_38 in L5_34(L6_35) do
		L10_39 = L4_33[L9_38]
		L11_40 = L10_39 * A2_31
		A1_30:anim_state_machine():set_global(L9_38, L11_40)
		A1_30:player_data()[L9_38] = L11_40
	end
end
