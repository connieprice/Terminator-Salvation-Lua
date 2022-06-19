require("units/beings/rail/RailDamage")
if not RailTrainDamage then
	RailTrainDamage = class(RailDamage)
end
local l_0_0 = RailTrainDamage
local l_0_1 = {}
local l_0_2 = {}
local l_0_3 = {}
local l_0_4 = {}
 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

local l_0_5 = {}
l_0_5.damage = 0.5
l_0_5.sequence_name = "dmg_state_2"
local l_0_6 = {}
l_0_6.damage = 0.7
l_0_6.sequence_name = "dmg_state_3"
l_0_4, l_0_3 = {damage = 0.2, sequence_name = "dmg_state_1"}, {damage = 0, sequence_name = "dmg_state_0"}
l_0_1.unit_damage_steps, l_0_2 = l_0_2, {l_0_3, l_0_4, l_0_5, l_0_6}
local l_0_7 = {}
l_0_7.damage = 0.6
l_0_7.sequence_name = "damage"
local l_0_8 = {}
l_0_8.damage = 0.75
l_0_8.sequence_name = "damage"
l_0_6, l_0_5, l_0_4, l_0_3 = {damage = 0.45, sequence_name = "damage"}, {damage = 0.3, sequence_name = "damage"}, {damage = 0.1, sequence_name = "damage"}, {damage = 0.05, sequence_name = "damage"}
l_0_1.unit_damage_steps, l_0_2 = l_0_2, {l_0_3, l_0_4, l_0_5, l_0_6, l_0_7, l_0_8}
l_0_1.unit_damage_steps_total, l_0_2 = l_0_2, {}
l_0_1.damage_unit = true
l_0_1.unit_destroyed_sequence = "kill_vehicle"
l_0_0._PARTS = l_0_1
l_0_0 = RailTrainDamage
l_0_1 = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6)
	RailDamage.init(l_1_0, l_1_1, BodyDamage, l_1_3, l_1_4, l_1_5, l_1_6)
	l_1_0:_setup_bodies()
end

l_0_0.init = l_0_1
l_0_0 = RailTrainDamage
l_0_1 = function(l_2_0)
	RailDamage._setup_body_group(l_2_0, RailTrainDamage._PARTS)
end

l_0_0._setup_bodies = l_0_1
l_0_0 = RailTrainDamage
l_0_1 = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5, l_3_6, l_3_7, l_3_8)
	l_3_0._unit:damage_data().no_lethal_damage = false
	RailDamage.add_damage(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5, l_3_6, l_3_7, l_3_8)
end

l_0_0.add_damage = l_0_1
l_0_0 = RailTrainDamage
l_0_1 = function(l_4_0)
	if not l_4_0._player_in_vehicle then
		local l_4_3 = managers.unit_scripting:get_unit_by_name
		l_4_3 = l_4_3(managers.unit_scripting, "character_slot1")
	end
	l_4_0._player_in_vehicle = l_4_3
	if l_4_0._player_in_vehicle then
		local l_4_1, l_4_2 = l_4_0._player_in_vehicle:damage():immune_to_damage, l_4_0._player_in_vehicle:damage()
		return l_4_1(l_4_2)
	else
		return false
	end
end

l_0_0.check_god_mode = l_0_1

