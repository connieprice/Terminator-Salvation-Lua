if not InstantBullet then
	InstantBullet = class()
end
local l_0_0 = mvector3.add
local l_0_1 = mvector3.subtract
local l_0_2 = mvector3.dot
local l_0_3 = function(l_1_0, l_1_1, l_1_2, l_1_3)
	if l_1_3 < l_1_0 then
		return l_1_1
	end
	do return end
	if l_1_2 < l_1_0 then
		local l_1_4 = 1 - l_1_1
		local l_1_5 = assert
		l_1_5(l_1_4 >= 0)
		l_1_5 = l_1_3 - l_1_2
		local l_1_8 = assert
		l_1_8(l_1_5 >= 0)
		l_1_8 = l_1_0 - l_1_2
		l_1_8 = (l_1_8) / (l_1_5)
		l_1_8 = l_1_4 * (l_1_8)
		l_1_8 = 1 - l_1_8
		return l_1_8
	else
		return 1
	end
end

local l_0_4 = function(l_2_0, l_2_1)
	local l_2_2 = l_2_0:physics()
	if l_2_2 then
		l_2_2:push(0.01, 10000 * l_2_1)
	end
end

local l_0_5 = function(l_3_0, l_3_1, l_3_2)
	local l_3_3 = l_3_0.normal
	local l_3_4 = l_3_0.position
	local l_3_5 = l_3_0.ray
	local l_3_6 = l_3_0.ray - l_3_3 * l_3_5:dot(l_3_3) * 2
	managers.decal_manager:project_decal(l_3_1, l_3_4, l_3_5, l_3_6, l_3_3, l_3_0.unit)
end

end
 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

 -- WARNING: undefined locals caused missing assignments!

