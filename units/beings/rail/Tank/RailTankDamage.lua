require("units/beings/rail/RailDamage")
if not RailTankDamage then
	RailTankDamage = class(RailDamage)
end
local l_0_0 = RailTankDamage
local l_0_1 = {}
local l_0_2 = {}
local l_0_3 = {}
local l_0_4 = {}
 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

local l_0_5 = {}
l_0_5.damage = 0.3
l_0_5.sequence_name = "medium_damage"
local l_0_6 = {}
l_0_6.damage = 0.7
l_0_6.sequence_name = "severe_damage"
l_0_4, l_0_3 = {damage = 0.1, sequence_name = "light_damage"}, {damage = 0, sequence_name = nil}
l_0_1.unit_damage_steps, l_0_2 = l_0_2, {l_0_3, l_0_4, l_0_5, l_0_6}
l_0_1.unit_destroyed_sequence = "kill_tank"
l_0_1.damage_unit = true
l_0_0._PARTS = l_0_1
l_0_0 = RailTankDamage
l_0_1 = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6)
	RailDamage.init(l_1_0, l_1_1, BodyDamage, l_1_3, l_1_4, l_1_5, l_1_6)
	l_1_0:_setup_bodies()
end

l_0_0.init = l_0_1
l_0_0 = RailTankDamage
l_0_1 = function(l_2_0)
	RailDamage._setup_body_group(l_2_0, RailTankDamage._PARTS)
end

l_0_0._setup_bodies = l_0_1
l_0_0 = RailTankDamage
l_0_1 = function(l_3_0, l_3_1)
end

l_0_0.body_damage_percent = l_0_1

