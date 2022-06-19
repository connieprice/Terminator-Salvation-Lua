require("units/beings/VisibilityQuery")
if not PlayerVisibilityQuery then
	PlayerVisibilityQuery = class(VisibilityQuery)
end
PlayerVisibilityQuery.init = function(l_1_0, l_1_1)
	VisibilityQuery.init(l_1_0, l_1_1)
	l_1_0._player_data = l_1_0._unit:player_data()
	assert(l_1_0._player_data)
end

PlayerVisibilityQuery.visible_from_position = function(l_2_0, l_2_1)
	if not l_2_0._player_data.cover then
		return true
	end
	if l_2_0._player_data.peeking_up or l_2_0._player_data.peeking_side or l_2_0._player_data.blind_firing_up or l_2_0._player_data.blind_firing_side then
		return true
	end
	return not managers.cover_util:point_within_cover_frustum(l_2_0._player_data.cover, l_2_1)
end

PlayerVisibilityQuery.hittable_from_position = function(l_3_0, l_3_1)
	if not l_3_0._player_data.cover then
		return true
	end
	if l_3_0._player_data.peeking_up or l_3_0._player_data.peeking_side then
		return true
	end
	return not managers.cover_util:point_within_cover_frustum(l_3_0._player_data.cover, l_3_1)
end


