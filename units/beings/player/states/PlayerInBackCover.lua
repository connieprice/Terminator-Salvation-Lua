require("units/beings/player/states/PlayerMovementState.lua")
require("shared/InterpolatorLinear")
require("shared/Angle")
PlayerInBackCover = PlayerInBackCover or class(PlayerMovementState)
function PlayerInBackCover.init(A0_0, A1_1, A2_2, A3_3, A4_4)
	PlayerMovementState.init(A0_0, A1_1, "PlayerInBackCover")
	A0_0._initial_position = A3_3:position() + A4_4 * A2_2:normal()
	A0_0._cover = A2_2
	A0_0._cover_point = A3_3
	A0_0._input = A1_1:input()
end
function PlayerInBackCover.enter(A0_5)
	PlayerMovementState.enter(A0_5)
	A0_5._unit:set_position(A0_5._initial_position)
	A0_5._base:activate_mover("in_cover")
	A0_5._player_data.cover = A0_5._cover
	A0_5._player_data.cover_normal = A0_5._cover:normal()
	A0_5._player_data.cover_point = A0_5._cover_point
	A0_5:_clear_input()
end
function PlayerInBackCover.leave(A0_6)
	PlayerMovementState.leave(A0_6)
	A0_6._player_data.cover_normal = nil
	A0_6._player_data.cover_point = nil
	A0_6._player_data.cover = nil
end
function PlayerInBackCover.transition(A0_7)
	if A0_7._base:check_fully_damaged() then
		return (A0_7._base:check_fully_damaged())
	end
	if A0_7._player_data.in_cover and not A0_7._player_data.cover_outer_position then
		return PlayerInCover:new(A0_7._unit, A0_7._cover, A0_7._cover_point)
	end
	if A0_7._player_data.on_ground then
		return PlayerOnGround:new(A0_7._unit)
	end
end
function PlayerInBackCover.update(A0_8, A1_9, A2_10)
	if A0_8:transition() then
		return (A0_8:transition())
	end
	PlayerMovementState.update(A0_8, A1_9, A2_10)
	A0_8:_update_input()
end
function PlayerInBackCover._update_input(A0_11)
	local L1_12
	L1_12 = A0_11._input
	A0_11._leave_cover_input = A0_11._leave_cover_input or L1_12:leave_cover()
	A0_11._enter_inner_cover_position_input = A0_11._enter_inner_cover_position_input or L1_12:enter_inner_cover_position()
end
function PlayerInBackCover._clear_input(A0_13)
	local L1_14
	A0_13._leave_cover_input = nil
	A0_13._enter_inner_cover_position_input = nil
end
function PlayerInBackCover.variable_frequency_post_update(A0_15, A1_16)
	local L2_17, L3_18
	L2_17 = PlayerMovementState
	L2_17 = L2_17.variable_frequency_post_update
	L3_18 = A0_15
	L2_17(L3_18, A1_16)
	L3_18 = A0_15
	L2_17 = A0_15._wants_to_enter_cover
	L2_17 = L2_17(L3_18)
	if L2_17 then
		L2_17 = managers
		L2_17 = L2_17.cover_util
		L3_18 = L2_17
		L2_17 = L2_17.high_cover
		L2_17 = L2_17(L3_18, A0_15._cover)
		L3_18 = iff
		L3_18 = L3_18(L2_17, "enter_inner_cover_stand", "enter_inner_cover_crouch")
		A0_15._unit:play_redirect(L3_18)
		A0_15._base._cover_data_retriever:enter_cover(A0_15._cover)
	end
	L3_18 = A0_15
	L2_17 = A0_15._wants_to_leave_cover
	L2_17 = L2_17(L3_18)
	if L2_17 then
		L2_17 = A0_15._unit
		L3_18 = L2_17
		L2_17 = L2_17.play_redirect
		L2_17(L3_18, "leave_cover")
	end
	L3_18 = A0_15
	L2_17 = A0_15._clear_input
	L2_17(L3_18)
end
function PlayerInBackCover._wants_to_leave_cover(A0_19)
	local L1_20
	L1_20 = A0_19._leave_cover_input
	return L1_20
end
function PlayerInBackCover._wants_to_enter_cover(A0_21)
	local L1_22
	L1_22 = A0_21._enter_inner_cover_position_input
	return L1_22
end
