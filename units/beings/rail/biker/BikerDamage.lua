require("units/beings/rail/RailDamage")
if not BikerDamage then
	BikerDamage = class(RailDamage)
end
local l_0_0 = BikerDamage
local l_0_1 = {}
local l_0_2 = {}
local l_0_3 = {}
local l_0_4 = {}
 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

local l_0_5 = {}
l_0_5.damage = 0.49
l_0_5.sequence_name = "severe_damage"
l_0_4, l_0_3 = {damage = 0.05, sequence_name = "light_damage"}, {damage = 0, sequence_name = nil}
l_0_1.unit_damage_steps, l_0_2 = l_0_2, {l_0_3, l_0_4, l_0_5}
l_0_0._BIKE = l_0_1
l_0_0 = BikerDamage
l_0_1 = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6)
	RailDamage.init(l_1_0, l_1_1, BodyDamage, l_1_3, l_1_4, l_1_5, l_1_6)
	l_1_0:_setup_bodies()
	l_1_0._outline_weakspots = {}
	local l_1_7 = l_1_0._outline_weakspots
	local l_1_8 = {}
	l_1_8.body_name = "b_chassi_ray"
	l_1_8.obj = l_1_0._unit:get_object("g_outline_biker")
	l_1_7[1] = l_1_8
end

l_0_0.init = l_0_1
l_0_0 = BikerDamage
l_0_1 = function(l_2_0)
	RailDamage._setup_body_group(l_2_0, BikerDamage._BIKE)
end

l_0_0._setup_bodies = l_0_1
l_0_0 = BikerDamage
l_0_1 = function(l_3_0, l_3_1)
	local l_3_5, l_3_6, l_3_7, l_3_8, l_3_9, l_3_10 = nil
	if l_3_0._outline_weakspots then
		for i_0,i_1 in pairs(l_3_0._outline_weakspots) do
			if i_1.body_name == l_3_1 then
				return {i_1.obj}
			end
		end
	end
end

l_0_0.check_outline_weakspot = l_0_1

