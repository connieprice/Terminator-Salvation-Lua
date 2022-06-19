if not ScriptCoverUtils then
	ScriptCoverUtils = class()
end
ScriptCoverUtils.ground_position = function(l_1_0, l_1_1)
	assert(l_1_1)
	local l_1_2 = l_1_0:position() + math.UP * tweak_data.player.cover.QM_TARGET_POINT_GROUND_RAY_LENGTH
	local l_1_3 = l_1_0:position() - math.UP * tweak_data.player.cover.QM_TARGET_POINT_GROUND_RAY_LENGTH
	local l_1_7 = World:raycast
	local l_1_8 = World
	local l_1_9 = "ray"
	local l_1_10 = l_1_2
	local l_1_11 = l_1_3
	local l_1_12 = "ray_type"
	local l_1_13 = "body"
	local l_1_14, l_1_15, l_1_16 = "sphere_cast_radius", l_1_1, "slot_mask"
	l_1_7 = l_1_7(l_1_8, l_1_9, l_1_10, l_1_11, l_1_12, l_1_13, l_1_14, l_1_15, l_1_16, managers.slot:get_mask("footstep_decals"))
	local l_1_4 = nil
	if l_1_7 then
		l_1_8 = l_1_7.position
		l_1_9 = math
		l_1_9 = l_1_9.UP
		l_1_9 = l_1_9 * l_1_1
		l_1_8 = l_1_8 - l_1_9
		return l_1_8
	end
	l_1_8, l_1_9 = l_1_0:position, l_1_0
	local l_1_5, l_1_6 = nil
	return l_1_8(l_1_9)
end

ScriptCoverUtils.can_leave_cover = function(l_2_0, l_2_1, l_2_2, l_2_3)
	local l_2_4 = 30
	if l_2_3 == "left_forward" or l_2_3 == "right_forward" then
		local l_2_5 = 60
		local l_2_6 = 120
		local l_2_7 = 100
		local l_2_8 = iff
		l_2_8 = l_2_8(l_2_3 == "left_forward", -l_2_2, l_2_2)
		local l_2_11 = l_2_0:position() + math.UP * l_2_5
		local l_2_12 = l_2_11 + l_2_8 * l_2_6
		local l_2_13 = ScriptCoverUtils._raycast(l_2_11, l_2_12, l_2_4, "solid_objects", l_2_0)
		if l_2_13 then
			return false
		end
		local l_2_14 = l_2_12 - l_2_1 * l_2_7
		l_2_13 = ScriptCoverUtils._raycast(l_2_12, l_2_14, l_2_4, "solid_objects", l_2_0)
	if l_2_13 then
		end
		return false
	end
	return true
end

ScriptCoverUtils.can_peek_around_cover_edge = function(l_3_0, l_3_1, l_3_2, l_3_3)
	local l_3_4 = 30
	local l_3_5 = 60
	local l_3_6 = 100
	local l_3_7 = 100
	local l_3_8 = iff
	l_3_8 = l_3_8(l_3_3 == "left", -l_3_2, l_3_2)
	local l_3_11 = l_3_0 + math.UP * l_3_5
	local l_3_12 = l_3_11 + l_3_8 * l_3_6
	local l_3_13 = ScriptCoverUtils._raycast(l_3_11, l_3_12, l_3_4, "solid_non_ai_objects")
	if l_3_13 then
		return false
	end
	local l_3_14 = l_3_12 - l_3_1 * l_3_7
	l_3_13 = ScriptCoverUtils._raycast(l_3_12, l_3_14, l_3_4, "solid_non_ai_objects")
	if l_3_13 then
		return false
	end
	return true
end

ScriptCoverUtils._raycast = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4)
	do
		return l_4_4 or World:raycast("ray", l_4_0, l_4_1, "sphere_cast_radius", l_4_2, "ray_type", "low_quality_collision", "slot_mask", managers.slot:get_mask(l_4_3))
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


