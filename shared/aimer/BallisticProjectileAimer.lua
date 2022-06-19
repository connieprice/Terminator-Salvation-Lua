require("shared/aimer/Aimer")
if not BallisticProjectileAimer then
	BallisticProjectileAimer = class(Aimer)
end
BallisticProjectileAimer.init = function(l_1_0, l_1_1)
	assert(l_1_1)
	local l_1_2 = l_1_1.initial_speed
	assert(l_1_2)
	l_1_0._initial_speed = l_1_2
	l_1_0._squared_initial_speed = l_1_2 * l_1_2
	l_1_0._gravity = math.abs(World:gravity().z)
end

BallisticProjectileAimer.aim_position = function(l_2_0, l_2_1, l_2_2)
	local l_2_3 = l_2_2 - l_2_1
	local l_2_4 = l_2_3:flat(math.UP)
	local l_2_5 = l_2_3:length()
	if l_2_3.z < 0 then
		local l_2_7 = math.asin(l_2_0._gravity * l_2_5 / l_2_0._squared_initial_speed) / 2
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_2_6 = l_2_7 + -math.acos(math.dot(l_2_3:normalized(), l_2_4:normalized()))
	local l_2_8 = nil
	local l_2_9 = nil
	return l_2_1 + l_2_4:rotate_with(Rotation(math.cross(l_2_4, math.UP):normalized(), l_2_6))
end


