require("units/beings/rail/RailDamage")
RailPickupDamage = RailPickupDamage or class(RailDamage)
RailPickupDamage._PARTS = {
	bodies = {
		{
			body_names = {"b_ray_hood"},
			name = "hood",
			destroyed_sequence_name = "kill_hood",
			hp = 200
		},
		{
			body_names = {
				"b_ray_door_l"
			},
			name = "door_l",
			destroyed_sequence_name = "none",
			hp = 99999
		},
		{
			body_names = {
				"b_ray_door_r"
			},
			name = "door_r",
			destroyed_sequence_name = "none",
			hp = 99999
		},
		{
			body_names = {
				"b_chassi_ray"
			},
			name = "chassie",
			destroyed_sequence_name = "kill_vehicle_1",
			hp = 50000
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
	damage_unit = true,
	unit_destroyed_sequence = "kill_vehicle_1"
}
function RailPickupDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	RailDamage.init(A0_0, A1_1, BodyDamage, A3_3, A4_4, A5_5, A6_6)
	A0_0:_setup_bodies()
end
function RailPickupDamage._setup_bodies(A0_7)
	RailDamage._setup_body_group(A0_7, RailPickupDamage._PARTS)
end
