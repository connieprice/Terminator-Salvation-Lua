if not DecalManager then
	DecalManager = class()
end
local l_0_0 = mvector3.set
local l_0_1 = mvector3.set_x
local l_0_2 = mvector3.set_z
local l_0_3 = mvector3.set_zero
local l_0_4 = mvector3.normalize
local l_0_5 = function(l_1_0, l_1_1, l_1_2)
	local l_1_3 = l_1_0.n
	local l_1_4 = l_1_1.n
	local l_1_5 = l_1_2.n
	return (l_1_0.p:dot(l_1_0.n) * l_1_1.n:cross(l_1_2.n) + l_1_1.p:dot(l_1_1.n) * l_1_2.n:cross(l_1_0.n) + l_1_2.p:dot(l_1_2.n) * l_1_0.n:cross(l_1_1.n)) / (l_1_3.x * l_1_4.y * l_1_5.z + l_1_3.y * l_1_4.z * l_1_5.x + l_1_3.z * l_1_4.x * l_1_5.y - l_1_3.z * l_1_4.y * l_1_5.x - l_1_3.y * l_1_4.x * l_1_5.z - l_1_3.x * l_1_4.z * l_1_5.y)
end

do
	local l_0_8 = function(l_2_0, l_2_1, l_2_2)
	-- upvalues: l_0_5
	local l_2_3 = l_0_5(l_2_0.planes[1], l_2_0.planes[2], l_2_0.planes[6]):rotate_with(l_2_2) + l_2_1
	local l_2_4 = l_0_5(l_2_0.planes[1], l_2_0.planes[3], l_2_0.planes[6]):rotate_with(l_2_2) + l_2_1
	local l_2_5 = l_0_5(l_2_0.planes[1], l_2_0.planes[2], l_2_0.planes[5]):rotate_with(l_2_2) + l_2_1
	local l_2_6 = l_0_5(l_2_0.planes[1], l_2_0.planes[3], l_2_0.planes[5]):rotate_with(l_2_2) + l_2_1
	local l_2_7 = l_0_5(l_2_0.planes[4], l_2_0.planes[2], l_2_0.planes[6]):rotate_with(l_2_2) + l_2_1
	local l_2_8 = l_0_5(l_2_0.planes[4], l_2_0.planes[3], l_2_0.planes[6]):rotate_with(l_2_2) + l_2_1
	local l_2_9 = l_0_5(l_2_0.planes[4], l_2_0.planes[2], l_2_0.planes[5]):rotate_with(l_2_2) + l_2_1
	local l_2_10 = l_0_5(l_2_0.planes[4], l_2_0.planes[3], l_2_0.planes[5]):rotate_with(l_2_2) + l_2_1
	local l_2_11 = Draw:pen(Color(1, 0, 0))
	l_2_11:line(l_2_3, l_2_4)
	l_2_11:line(l_2_4, l_2_6)
	l_2_11:line(l_2_6, l_2_5)
	l_2_11:line(l_2_5, l_2_3)
	l_2_11:line(l_2_7, l_2_8)
	l_2_11:line(l_2_8, l_2_10)
	l_2_11:line(l_2_10, l_2_9)
	l_2_11:line(l_2_9, l_2_7)
	l_2_11:line(l_2_3, l_2_7)
	l_2_11:line(l_2_4, l_2_8)
	l_2_11:line(l_2_5, l_2_9)
	l_2_11:line(l_2_6, l_2_10)
	local l_2_12 = Draw:brush(Color(0.2, 1, 0, 0))
	l_2_12:quad(l_2_3, l_2_4, l_2_6, l_2_5)
	l_2_12:quad(l_2_7, l_2_9, l_2_10, l_2_8)
	l_2_12:quad(l_2_7, l_2_3, l_2_5, l_2_9)
	l_2_12:quad(l_2_4, l_2_8, l_2_10, l_2_6)
	l_2_12:quad(l_2_3, l_2_4, l_2_8, l_2_7)
	l_2_12:quad(l_2_5, l_2_6, l_2_10, l_2_9)
end

end
 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

 -- WARNING: undefined locals caused missing assignments!

