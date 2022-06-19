require("units/beings/WeaponMounting/WeaponMounting")
require("units/beings/WeaponMounting/WeaponMountingPointSetup")
require("units/beings/machines/walker/states/WalkerOnGround")
require("units/beings/machines/walker/states/WalkerFullyDamagedState")
require("units/beings/WeaponLogic/WeaponLogicFactory")
require("shared/FiniteStateMachine")
require("shared/updatescheduler/UpdateSchedulerDtMethod")
local l_0_0 = function(l_1_0, l_1_1, l_1_2)
	local l_1_3 = World:spawn_unit(l_1_0, l_1_1, l_1_2)
	local l_1_4 = l_1_3:num_bodies()
	for l_1_8 = 0, l_1_4 - 1 do
		local l_1_9 = l_1_3:body(l_1_8)
		l_1_9:set_enabled(false)
	end
	return l_1_3
end

if not WalkerBase then
	WalkerBase = class()
end
WalkerBase._CONNECT_ALIGN_NAME = "a_weapon_left_front"
local l_0_1 = WalkerBase
local l_0_2 = {}
local l_0_3 = Polar(1, 0, 0)
local l_0_4 = {}
l_0_4.redirect = "strike_of_death_forward"
l_0_4.impact_object_name = "LeftHand"
l_0_4.impact_direction = Vector3(1, 0, 0)
l_0_2[l_0_3] = l_0_4
l_0_3 = Polar
l_0_4 = 1
l_0_3 = l_0_3(l_0_4, 0, 90)
l_0_2[l_0_3], l_0_4 = l_0_4, {redirect = "strike_of_death_left", impact_object_name = "LeftHand", impact_direction = Vector3(0, -1, 0)}
l_0_3 = Polar
l_0_4 = 1
l_0_3 = l_0_3(l_0_4, 0, 180)
l_0_2[l_0_3], l_0_4 = l_0_4, {redirect = "strike_of_death_backward", impact_object_name = "LeftHand", impact_direction = Vector3(1, 0, 0)}
l_0_3 = Polar
l_0_4 = 1
l_0_3 = l_0_3(l_0_4, 0, 270)
local l_0_7 = Vector3
l_0_7 = l_0_7(0, -1, 0)
l_0_2[l_0_3], l_0_4 = l_0_4, {redirect = "strike_of_death_right", impact_object_name = "RightHand", impact_direction = l_0_7}
l_0_1._STRIKE_OF_DEATH_DIRECTIONS = l_0_2
l_0_1 = 0.01
l_0_7 = "walk_forward"
l_0_4 = {l_0_7, "walk_forward_aim"}
l_0_7 = "walk_forward_turn"
l_0_4 = {l_0_7, "walk_forward_turn_aim"}
l_0_3 = {min = 240, max = 120, redirects = l_0_4, turn_redirects = l_0_4}
l_0_7 = "walk_backward"
l_0_4 = {l_0_7, "walk_backward_aim"}
l_0_7 = "walk_backward_turn"
l_0_4 = {l_0_7, "walk_backward_turn_aim"}
l_0_3 = {min = 135, max = 225, redirects = l_0_4, turn_redirects = l_0_4}
l_0_7 = "walk_left"
l_0_4 = {l_0_7, "walk_left_aim"}
l_0_7 = "walk_left_turn"
l_0_4 = {l_0_7, "walk_left_turn_aim"}
l_0_3 = {min = 30, max = 150, redirects = l_0_4, turn_redirects = l_0_4}
l_0_7 = "walk_right"
l_0_4 = {l_0_7, "walk_right_aim"}
l_0_7 = "walk_right_turn"
local l_0_6 = "walk_right_turn_aim"
l_0_4 = {l_0_7, l_0_6}
l_0_3 = {min = 210, max = 330, redirects = l_0_4, turn_redirects = l_0_4}
l_0_3 = pairs
l_0_4, l_0_2 = l_0_2, {[1] = l_0_3, [2] = l_0_3, [3] = l_0_3, [4] = l_0_3}
l_0_3 = l_0_3(l_0_4)
for l_0_6,i_1 in l_0_3 do
	local l_0_8 = l_0_5.min
	local l_0_9 = l_0_5.max
	local l_0_10 = nil
	if l_0_9 < l_0_8 then
		l_0_10 = l_0_9 + 360 - l_0_8
	else
		l_0_10 = l_0_9 - l_0_8
	end
	l_0_5.range = l_0_10
end
local l_0_11 = 50
local l_0_12 = 50
local l_0_13 = 30
local l_0_14 = 50
local l_0_15 = -30
local l_0_16 = function(l_18_0, l_18_1, l_18_2, l_18_3)
	local l_18_11, l_18_12, l_18_13, l_18_14, l_18_15, l_18_16, l_18_17, l_18_18 = nil
	local l_18_4 = mvector3.angle(l_18_0, l_18_1)
	local l_18_5 = math.cross(math.UP, l_18_1)
	if mvector3.dot(l_18_5, l_18_0) < 0 then
		l_18_4 = 360 - l_18_4
	end
	local l_18_6, l_18_7 = nil, nil
	for i_0,i_1 in ipairs(l_18_3) do
		local l_18_21 = i_1.min
		do
			local l_18_22, l_18_23 = i_1.max, l_18_20.range
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_18_4 < l_18_21 and l_18_4 + 360 or l_18_4 <= l_18_21 + l_18_23 then
			if l_18_2 == l_18_19 then
				return l_18_2
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			local l_18_24 = nil
		if not l_18_6 or math.abs(((l_18_4 < l_18_21 and l_18_4 + 360 or l_18_4) - l_18_21) / l_18_23 - 0.5) < l_18_7 then
			end
			l_18_6 = l_18_19
			l_18_7 = math.abs(((l_18_4 < l_18_21 and l_18_4 + 360 or l_18_4) - l_18_21) / l_18_23 - 0.5)
		end
	end
	return l_18_6
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

local l_0_17 = {}
local l_0_18 = {}
 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

local l_0_19 = {}
local l_0_20 = {}
local l_0_21 = {}
 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

do
	local l_0_22 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

end
 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

 -- WARNING: undefined locals caused missing assignments!

