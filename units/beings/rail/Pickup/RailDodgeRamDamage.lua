require("units/beings/rail/RailDamage")
RailDodgeRamDamage = RailDodgeRamDamage or class(RailDamage)
RailDodgeRamDamage._PARTS = {
	bodies = {
		{
			body_names = {
				"b_chassi_ray"
			},
			name = "chassie",
			destroyed_sequence_name = "kill_vehicle_1",
			hp = 50000
		},
		{
			body_names = {"body_hood"},
			name = "spwn_hood",
			destroyed_sequence_name = "spawn_hood_dmg",
			hp = 500
		},
		{
			body_names = {
				"body_lf_door"
			},
			name = "spwn_lf_door_dmg",
			destroyed_sequence_name = "spawn_lf_door_dmg",
			hp = 500
		},
		{
			body_names = {
				"body_lb_door"
			},
			name = "spwn_lb_door_dmg",
			destroyed_sequence_name = "spawn_lb_door_dmg",
			hp = 500
		},
		{
			body_names = {
				"body_rf_door"
			},
			name = "spwn_rf_door_dmg",
			destroyed_sequence_name = "spawn_rf_door_dmg",
			hp = 500
		},
		{
			body_names = {
				"body_rb_door"
			},
			name = "spwn_rb_door_dmg",
			destroyed_sequence_name = "spawn_rb_door_dmg",
			hp = 500
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
function RailDodgeRamDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	RailDamage.init(A0_0, A1_1, BodyDamage, A3_3, A4_4, A5_5, A6_6)
	A0_0:_setup_bodies()
end
function RailDodgeRamDamage._setup_bodies(A0_7)
	RailDamage._setup_body_group(A0_7, RailDodgeRamDamage._PARTS)
end
