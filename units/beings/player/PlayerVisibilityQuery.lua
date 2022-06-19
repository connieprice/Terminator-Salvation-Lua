require("units/beings/VisibilityQuery")
PlayerVisibilityQuery = PlayerVisibilityQuery or class(VisibilityQuery)
function PlayerVisibilityQuery.init(A0_0, A1_1)
	VisibilityQuery.init(A0_0, A1_1)
	A0_0._player_data = A0_0._unit:player_data()
	assert(A0_0._player_data)
end
function PlayerVisibilityQuery.visible_from_position(A0_2, A1_3)
	if not A0_2._player_data.cover then
		return true
	end
	if A0_2._player_data.peeking_up or A0_2._player_data.peeking_side or A0_2._player_data.blind_firing_up or A0_2._player_data.blind_firing_side then
		return true
	end
	return not managers.cover_util:point_within_cover_frustum(A0_2._player_data.cover, A1_3)
end
function PlayerVisibilityQuery.hittable_from_position(A0_4, A1_5)
	if not A0_4._player_data.cover then
		return true
	end
	if A0_4._player_data.peeking_up or A0_4._player_data.peeking_side then
		return true
	end
	return not managers.cover_util:point_within_cover_frustum(A0_4._player_data.cover, A1_5)
end
