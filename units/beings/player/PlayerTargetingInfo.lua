require("units/beings/TargetingInfo")
PlayerTargetingInfo = PlayerTargetingInfo or class(TargetingInfo)
function PlayerTargetingInfo.init(A0_0, A1_1)
	TargetingInfo.init(A0_0, A1_1)
	assert(A0_0.in_cover)
	A0_0._in_cover_objects = A0_0:_get_objects(A0_0.in_cover)
	A0_0._player_data = A0_0._unit:player_data()
	A0_0._in_cover = false
end
function PlayerTargetingInfo.is_visible(A0_2, A1_3, A2_4)
	A0_2._in_cover = A0_2:_is_in_cover()
	if A0_2._in_cover then
		return A0_2._target_object(A0_2, A1_3, A2_4, A0_2._in_cover_objects) ~= nil
	end
	return TargetingInfo.is_visible(A0_2, A1_3, A2_4)
end
function PlayerTargetingInfo.target_position(A0_5, A1_6, A2_7, A3_8)
	A0_5._in_cover = A0_5:_is_in_cover()
	if A0_5._in_cover then
		if not A0_5._target_object(A0_5, A1_6, A2_7, A0_5._in_cover_objects, A3_8) then
			return nil
		end
		return A0_5._target_object(A0_5, A1_6, A2_7, A0_5._in_cover_objects, A3_8):position()
	end
	return TargetingInfo.target_position(A0_5, A1_6, A2_7, A3_8)
end
function PlayerTargetingInfo.primary_target_position(A0_9)
	if A0_9._in_cover then
		return A0_9._in_cover_objects[1]:position()
	end
	return TargetingInfo.primary_target_position(A0_9)
end
function PlayerTargetingInfo.target_objects(A0_10)
	if A0_10._in_cover then
		return A0_10._in_cover_objects
	end
	return TargetingInfo.target_objects(A0_10)
end
function PlayerTargetingInfo._is_in_cover(A0_11)
	local L1_12
	L1_12 = A0_11._player_data
	L1_12 = L1_12.cover
	if L1_12 then
		L1_12 = A0_11._player_data
		L1_12 = L1_12.cover_point
	end
	return L1_12
end
