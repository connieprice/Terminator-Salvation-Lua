require("units/beings/rail/RailDamage")
if not RailVehicleVanDamage then
	RailVehicleVanDamage = class(RailDamage)
end
local l_0_0 = RailVehicleVanDamage
local l_0_1 = {}
local l_0_2 = {}
local l_0_3 = {}
local l_0_4 = {}
 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

local l_0_5 = {}
l_0_5.damage = 0.65
l_0_5.sequence_name = "dmg_state_2"
local l_0_6 = {}
l_0_6.damage = 1
l_0_6.sequence_name = "dmg_state_3"
l_0_4, l_0_3 = {damage = 0.2, sequence_name = "dmg_state_1"}, {damage = 0, sequence_name = "dmg_state_0"}
l_0_1.unit_damage_steps, l_0_2 = l_0_2, {l_0_3, l_0_4, l_0_5, l_0_6}
l_0_1.damage_unit = true
l_0_0._PARTS = l_0_1
l_0_0 = RailVehicleVanDamage
l_0_1 = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6)
	RailDamage.init(l_1_0, l_1_1, BodyDamage, l_1_3, l_1_4, l_1_5, l_1_6)
	l_1_0:_setup_bodies()
end

l_0_0.init = l_0_1
l_0_0 = RailVehicleVanDamage
l_0_1 = function(l_2_0)
	RailDamage._setup_body_group(l_2_0, RailVehicleVanDamage._PARTS)
end

l_0_0._setup_bodies = l_0_1
l_0_0 = RailVehicleVanDamage
l_0_1 = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5, l_3_6, l_3_7, l_3_8)
	if alive(l_3_2) and l_3_2:name() == "rail_walker_driver" then
		return 
	end
	RailDamage.add_damage(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5, l_3_6, l_3_7, l_3_8)
end

l_0_0.add_damage = l_0_1

