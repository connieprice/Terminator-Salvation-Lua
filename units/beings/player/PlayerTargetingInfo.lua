require("units/beings/TargetingInfo")
if not PlayerTargetingInfo then
	PlayerTargetingInfo = class(TargetingInfo)
end
PlayerTargetingInfo.init = function(l_1_0, l_1_1)
	TargetingInfo.init(l_1_0, l_1_1)
	assert(l_1_0.in_cover)
	l_1_0._in_cover_objects = l_1_0:_get_objects(l_1_0.in_cover)
	l_1_0._player_data = l_1_0._unit:player_data()
	l_1_0._in_cover = false
end

PlayerTargetingInfo.is_visible = function(l_2_0, l_2_1, l_2_2)
	l_2_0._in_cover = l_2_0:_is_in_cover()
	if l_2_0._in_cover then
		local l_2_9 = l_2_0._target_object
		l_2_9 = l_2_9(l_2_0, l_2_1, l_2_2, l_2_0._in_cover_objects)
		l_2_9 = l_2_9 ~= nil
		return l_2_9
	end
	local l_2_5 = TargetingInfo.is_visible
	local l_2_6 = l_2_0
	local l_2_7 = l_2_1
	local l_2_8 = l_2_2
	return l_2_5(l_2_6, l_2_7, l_2_8)
end

PlayerTargetingInfo.target_position = function(l_3_0, l_3_1, l_3_2, l_3_3)
	l_3_0._in_cover = l_3_0:_is_in_cover()
	if l_3_0._in_cover then
		local l_3_7 = l_3_0._target_object
		local l_3_8 = l_3_0
		local l_3_9, l_3_15 = l_3_1, l_3_2
		l_3_7 = l_3_7(l_3_8, l_3_9, l_3_15, l_3_0._in_cover_objects, l_3_3)
		local l_3_4 = nil
		if not l_3_7 then
			l_3_8 = nil
			return l_3_8
		end
		l_3_8, l_3_9 = l_3_7:position, l_3_7
		local l_3_5, l_3_6 = nil
		return l_3_8(l_3_9)
	end
	local l_3_10 = TargetingInfo.target_position
	local l_3_11 = l_3_0
	local l_3_12 = l_3_1
	local l_3_13 = l_3_2
	local l_3_14 = l_3_3
	return l_3_10(l_3_11, l_3_12, l_3_13, l_3_14)
end

PlayerTargetingInfo.primary_target_position = function(l_4_0)
	if l_4_0._in_cover then
		local l_4_1 = l_4_0._in_cover_objects[1]
		local l_4_2, l_4_3, l_4_6 = l_4_1:position, l_4_1
		return l_4_2(l_4_3)
	end
	local l_4_4 = TargetingInfo.primary_target_position
	local l_4_5 = l_4_0
	return l_4_4(l_4_5)
end

PlayerTargetingInfo.target_objects = function(l_5_0)
	if l_5_0._in_cover then
		return l_5_0._in_cover_objects
	end
	local l_5_1 = TargetingInfo.target_objects
	local l_5_2 = l_5_0
	return l_5_1(l_5_2)
end

PlayerTargetingInfo._is_in_cover = function(l_6_0)
	if l_6_0._player_data.cover then
		return l_6_0._player_data.cover_point
	end
end


