require("units/beings/rail/RailDamage")
RailTankDamage = RailTankDamage or class(RailDamage)
RailTankDamage._PARTS = {
	bodies = {
		{
			body_names = {
				"default_body"
			},
			name = "default_body",
			destroyed_sequence_name = "kill_tank",
			hp = 1000000
		}
	},
	unit_damage_steps = {
		{damage = 0, sequence_name = nil},
		{
			damage = 0.1,
			sequence_name = "light_damage"
		},
		{
			damage = 0.3,
			sequence_name = "medium_damage"
		},
		{
			damage = 0.7,
			sequence_name = "severe_damage"
		}
	},
	unit_destroyed_sequence = "kill_tank",
	damage_unit = true
}
function RailTankDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	RailDamage.init(A0_0, A1_1, BodyDamage, A3_3, A4_4, A5_5, A6_6)
	A0_0:_setup_bodies()
end
function RailTankDamage._setup_bodies(A0_7)
	RailDamage._setup_body_group(A0_7, RailTankDamage._PARTS)
end
function RailTankDamage.body_damage_percent(A0_8, A1_9)
end
