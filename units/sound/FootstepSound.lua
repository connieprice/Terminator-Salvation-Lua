if not FootstepSound then
	FootstepSound = class()
end
FootstepSound.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4)
	local l_1_8, l_1_9, l_1_10, l_1_11 = nil
	l_1_0._unit = l_1_1
	l_1_0._feet = l_1_2
	l_1_0._feet_objects = {}
	for i_0,i_1 in pairs(l_1_0._feet) do
		l_1_0._feet_objects[i_0] = l_1_0._unit:get_object(i_1)
	end
	l_1_0._decal = l_1_3 or "footstep_sound"
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

FootstepSound.destroy = function(l_2_0)
end

FootstepSound.footstep = function(l_3_0, l_3_1, l_3_2)
	if l_3_0._unit:mover() and not l_3_0._unit:mover():standing() then
		return 
	end
	local l_3_3 = assert
	l_3_3(not l_3_1 or l_3_2)
	l_3_3 = l_3_0._feet_objects
	l_3_3 = l_3_3[l_3_1]
	local l_3_5 = l_3_3:position()
	local l_3_6 = nil
	local l_3_7, l_3_8, l_3_9 = , World:pick_decal_effect(l_3_0._decal, l_3_5, l_3_5 - math.UP * 70, managers.slot:get_mask("footstep_decals"))
	do
		if l_3_8 and l_3_8 ~= "" then
			local l_3_10 = nil
			l_3_0._unit:play("footstep_" .. l_3_8 .. "_" .. l_3_2)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end


