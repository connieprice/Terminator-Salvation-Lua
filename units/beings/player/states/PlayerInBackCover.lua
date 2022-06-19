require("units/beings/player/states/PlayerMovementState.lua")
require("shared/InterpolatorLinear")
require("shared/Angle")
if not PlayerInBackCover then
	PlayerInBackCover = class(PlayerMovementState)
end
PlayerInBackCover.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4)
	PlayerMovementState.init(l_1_0, l_1_1, "PlayerInBackCover")
	l_1_0._initial_position = l_1_3:position() + l_1_4 * l_1_2:normal()
	l_1_0._cover = l_1_2
	l_1_0._cover_point = l_1_3
	l_1_0._input = l_1_1:input()
end

PlayerInBackCover.enter = function(l_2_0)
	PlayerMovementState.enter(l_2_0)
	l_2_0._unit:set_position(l_2_0._initial_position)
	l_2_0._base:activate_mover("in_cover")
	l_2_0._player_data.cover = l_2_0._cover
	l_2_0._player_data.cover_normal = l_2_0._cover:normal()
	l_2_0._player_data.cover_point = l_2_0._cover_point
	l_2_0:_clear_input()
end

PlayerInBackCover.leave = function(l_3_0)
	PlayerMovementState.leave(l_3_0)
	l_3_0._player_data.cover_normal = nil
	l_3_0._player_data.cover_point = nil
	l_3_0._player_data.cover = nil
end

PlayerInBackCover.transition = function(l_4_0)
	local l_4_1 = l_4_0._base:check_fully_damaged()
	if l_4_1 then
		return l_4_1
	end
	if l_4_0._player_data.in_cover and not l_4_0._player_data.cover_outer_position then
		local l_4_2, l_4_3 = PlayerInCover:new, PlayerInCover
		local l_4_4 = l_4_0._unit
		local l_4_5, l_4_10 = l_4_0._cover
		l_4_10 = l_4_0._cover_point
		local l_4_6, l_4_11 = nil
		return l_4_2(l_4_3, l_4_4, l_4_5, l_4_10)
	end
	if l_4_0._player_data.on_ground then
		local l_4_7, l_4_8 = PlayerOnGround:new, PlayerOnGround
		local l_4_9 = l_4_0._unit
		return l_4_7(l_4_8, l_4_9)
	end
end

PlayerInBackCover.update = function(l_5_0, l_5_1, l_5_2)
	local l_5_3 = l_5_0:transition()
	if l_5_3 then
		return l_5_3
	end
	PlayerMovementState.update(l_5_0, l_5_1, l_5_2)
	l_5_0:_update_input()
end

PlayerInBackCover._update_input = function(l_6_0)
	local l_6_1 = l_6_0._input
	if not l_6_0._leave_cover_input then
		l_6_0._leave_cover_input = l_6_1:leave_cover()
	end
	if not l_6_0._enter_inner_cover_position_input then
		l_6_0._enter_inner_cover_position_input = l_6_1:enter_inner_cover_position()
	end
end

PlayerInBackCover._clear_input = function(l_7_0)
	l_7_0._leave_cover_input = nil
	l_7_0._enter_inner_cover_position_input = nil
end

PlayerInBackCover.variable_frequency_post_update = function(l_8_0, l_8_1)
	PlayerMovementState.variable_frequency_post_update(l_8_0, l_8_1)
	if l_8_0:_wants_to_enter_cover() then
		local l_8_2 = managers.cover_util:high_cover(l_8_0._cover)
		local l_8_3 = iff(l_8_2, "enter_inner_cover_stand", "enter_inner_cover_crouch")
		l_8_0._unit:play_redirect(l_8_3)
		l_8_0._base._cover_data_retriever:enter_cover(l_8_0._cover)
	end
	if l_8_0:_wants_to_leave_cover() then
		l_8_0._unit:play_redirect("leave_cover")
	end
	l_8_0:_clear_input()
end

PlayerInBackCover._wants_to_leave_cover = function(l_9_0)
	return l_9_0._leave_cover_input
end

PlayerInBackCover._wants_to_enter_cover = function(l_10_0)
	return l_10_0._enter_inner_cover_position_input
end


