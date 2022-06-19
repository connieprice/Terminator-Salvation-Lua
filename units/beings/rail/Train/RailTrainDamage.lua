require("units/beings/rail/RailDamage")
RailTrainDamage = RailTrainDamage or class(RailDamage)
RailTrainDamage._PARTS = {
	bodies = {
		{
			body_names = {
				"default_body"
			},
			name = "default_body",
			destroyed_sequence_name = "kill_vehicle",
			hp = 22500
		}
	},
	unit_damage_steps = {
		{
			damage = 0,
			sequence_name = "dmg_state_0"
		},
		{
			damage = 0.2,
			sequence_name = "dmg_state_1"
		},
		{
			damage = 0.5,
			sequence_name = "dmg_state_2"
		},
		{
			damage = 0.7,
			sequence_name = "dmg_state_3"
		}
	},
	unit_damage_steps = {
		{damage = 0.05, sequence_name = "damage"},
		{damage = 0.1, sequence_name = "damage"},
		{damage = 0.3, sequence_name = "damage"},
		{damage = 0.45, sequence_name = "damage"},
		{damage = 0.6, sequence_name = "damage"},
		{damage = 0.75, sequence_name = "damage"}
	},
	unit_damage_steps_total = {},
	damage_unit = true,
	unit_destroyed_sequence = "kill_vehicle"
}
function RailTrainDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	RailDamage.init(A0_0, A1_1, BodyDamage, A3_3, A4_4, A5_5, A6_6)
	A0_0:_setup_bodies()
end
function RailTrainDamage._setup_bodies(A0_7)
	RailDamage._setup_body_group(A0_7, RailTrainDamage._PARTS)
end
function RailTrainDamage.add_damage(A0_8, A1_9, A2_10, A3_11, A4_12, A5_13, A6_14, A7_15, A8_16)
	A0_8._unit:damage_data().no_lethal_damage = false
	RailDamage.add_damage(A0_8, A1_9, A2_10, A3_11, A4_12, A5_13, A6_14, A7_15, A8_16)
end
function RailTrainDamage.check_god_mode(A0_17)
	A0_17._player_in_vehicle = A0_17._player_in_vehicle or managers.unit_scripting:get_unit_by_name("character_slot1")
	if A0_17._player_in_vehicle then
		return A0_17._player_in_vehicle:damage():immune_to_damage()
	else
		return false
	end
end
