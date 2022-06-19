require("units/beings/rail/RailDamage")
if not RailSchoolBusDamage then
	RailSchoolBusDamage = class(RailDamage)
end
local l_0_0 = RailSchoolBusDamage
local l_0_1 = {}
local l_0_2 = {}
local l_0_3 = {}
local l_0_4 = {}
 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

local l_0_5 = {}
l_0_5.damage = 0.35
l_0_5.sequence_name = "dmg_state_2"
l_0_5.to_lower = "idle"
l_0_5.to_higher = "panic"
local l_0_6 = {}
l_0_6.damage = 0.55
l_0_6.sequence_name = "dmg_state_3"
l_0_6.to_lower = "idle"
l_0_6.to_higher = "panic"
local l_0_7 = {}
l_0_7.damage = 0.75
l_0_7.sequence_name = "dmg_state_4"
l_0_7.to_lower = "idle"
l_0_7.to_higher = nil
l_0_4, l_0_3 = {damage = 0.2, sequence_name = "dmg_state_1", to_lower = "idle", to_higher = "panic"}, {damage = 0, sequence_name = "dmg_state_0", to_lower = nil, to_higher = "panic"}
l_0_1.unit_damage_steps, l_0_2 = l_0_2, {l_0_3, l_0_4, l_0_5, l_0_6, l_0_7}
l_0_0._PARTS = l_0_1
l_0_0 = RailSchoolBusDamage
l_0_1 = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6)
	RailDamage.init(l_1_0, l_1_1, BodyDamage, l_1_3, l_1_4, l_1_5, l_1_6)
	l_1_0:_setup_bodies()
end

l_0_0.init = l_0_1
l_0_0 = RailSchoolBusDamage
l_0_1 = function(l_2_0)
	RailDamage._setup_body_group(l_2_0, RailSchoolBusDamage._PARTS)
end

l_0_0._setup_bodies = l_0_1
l_0_0 = RailSchoolBusDamage
l_0_1 = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5, l_3_6, l_3_7, l_3_8)
	if alive(l_3_2) and l_3_2:slot() == 2 then
		l_3_7 = l_3_7 * tweak_data.rail.vehicle.rail_vehicle_school_bus.FRIENDLY_DAMAGE_MULTIPLICATOR
	end
	RailDamage.add_damage(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5, l_3_6, l_3_7, l_3_8)
end

l_0_0.add_damage = l_0_1
l_0_0 = RailSchoolBusDamage
l_0_1 = function(l_4_0)
	if not l_4_0._player_in_vehicle then
		l_4_0._player_in_vehicle = managers.unit_scripting:get_unit_by_name("character_slot1")
	end
	if l_4_0._player_in_vehicle and l_4_0._player_in_vehicle:damage():immune_to_damage() then
		return true
	end
	return false
end

l_0_0.check_god_mode = l_0_1

