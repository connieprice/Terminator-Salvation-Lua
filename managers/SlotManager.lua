SlotManager = SlotManager or class(CoreSlotManager)
function SlotManager.init(A0_0)
	CoreSlotManager.init(A0_0)
	World:unit_manager():set_slot_infinite(2)
	World:unit_manager():set_slot_infinite(3)
	World:unit_manager():set_slot_infinite(4)
	World:unit_manager():set_slot_infinite(5)
	World:unit_manager():set_slot_limited(6, 4)
	World:unit_manager():set_slot_infinite(7)
	World:unit_manager():set_slot_limited(8, 25)
	World:unit_manager():set_slot_infinite(9)
	World:unit_manager():set_slot_infinite(10)
	World:unit_manager():set_slot_infinite(11)
	World:unit_manager():set_slot_infinite(12)
	World:unit_manager():set_slot_infinite(13)
	World:unit_manager():set_slot_infinite(14)
	World:unit_manager():set_slot_infinite(15)
	World:unit_manager():set_slot_infinite(16)
	World:unit_manager():set_slot_infinite(17)
	World:unit_manager():set_slot_infinite(18)
	World:unit_manager():set_slot_infinite(20)
	World:unit_manager():set_slot_infinite(21)
	World:unit_manager():set_slot_infinite(22)
	World:unit_manager():set_slot_infinite(23)
	World:unit_manager():set_slot_infinite(24)
	World:unit_manager():set_slot_infinite(25)
	World:unit_manager():set_slot_infinite(26)
	World:unit_manager():set_slot_infinite(27)
	World:unit_manager():set_slot_timed_limited(28, 5, 100)
	World:unit_manager():set_slot_infinite(29)
	World:unit_manager():set_slot_infinite(31)
	World:unit_manager():set_slot_infinite(32)
	World:unit_manager():set_slot_limited(33, 10)
	World:unit_manager():set_slot_infinite(34)
	World:unit_manager():set_slot_infinite(36)
	World:unit_manager():set_slot_infinite(37)
	World:unit_manager():set_slot_infinite(38)
	World:unit_manager():set_slot_infinite(39)
	World:unit_manager():set_slot_infinite(40)
	World:unit_manager():set_slot_infinite(42)
	World:unit_manager():set_slot_infinite(43)
	World:unit_manager():set_slot_infinite(44)
	World:unit_manager():set_slot_infinite(45)
	World:unit_manager():set_slot_infinite(46)
	A0_0._masks.all = World:make_slot_mask(1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 22, 23, 26, 27, 34, 37, 39)
	A0_0._masks.editor_all = World:make_slot_mask(1, 10, 11, 13, 19, 20, 24, 32, 34, 36, 39, 45, 46)
	A0_0._masks.player_aim = World:make_slot_mask(1, 3, 4, 5, 6, 7, 8, 9, 11, 14, 15, 22, 23, 26, 27)
	A0_0._masks.explosion_targets = World:make_slot_mask(1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 14, 15, 22, 23, 26, 27, 33, 39, 42)
	A0_0._masks.cameras = World:make_slot_mask(42)
	A0_0._masks.solid_objects = World:make_slot_mask(1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 15, 26, 27, 39)
	A0_0._masks.sound_material = World:make_slot_mask(1, 3, 4, 5, 6, 7, 8, 9, 11, 15, 26, 27, 39)
	A0_0._masks.solid_non_ai_objects = World:make_slot_mask(1, 5, 6, 7, 8, 9, 11, 15, 26, 27, 39)
	A0_0._masks.players = World:make_slot_mask(2)
	A0_0._masks.enemies = World:make_slot_mask(4, 5, 9)
	A0_0._masks.machines = World:make_slot_mask(4)
	A0_0._masks.vehicles = World:make_slot_mask(5, 39)
	A0_0._masks.ragdolls = World:make_slot_mask(6, 7)
	A0_0._masks.punchables = World:make_slot_mask(4, 5, 6, 8, 9, 11)
	A0_0._masks.enemy_punchables = World:make_slot_mask(6, 8, 11)
	A0_0._masks.bosses = World:make_slot_mask(9)
	A0_0._masks.hub_elements = World:make_slot_mask(1, 10)
	A0_0._masks.dynamics = World:make_slot_mask(8, 11, 13)
	A0_0._masks.target_world = World:make_slot_mask(1, 4, 5, 6, 7, 8, 9, 11, 13, 24, 26, 27, 39)
	A0_0._masks.visibility_blockers = World:make_slot_mask(1, 5, 8, 9, 11)
	A0_0._masks.aim_tracking = World:make_slot_mask(11)
	A0_0._masks.statics_layer = World:make_slot_mask(1, 4, 5, 11, 24, 26, 27, 32, 34, 39)
	A0_0._masks.onwall_check = World:make_slot_mask(1, 11, 26)
	A0_0._masks.edge_check = World:make_slot_mask(1, 5, 8, 11, 26, 39)
	A0_0._masks.standable = World:make_slot_mask(1, 5, 8, 9, 11, 26, 27, 39)
	A0_0._masks.movement_blockers = World:make_slot_mask(1, 8, 11, 15, 26, 27, 39, 45)
	A0_0._masks.movement_restricters = World:make_slot_mask(2, 3, 4, 5, 9)
	A0_0._masks.water = World:make_slot_mask(34)
	A0_0._masks.interactables = World:make_slot_mask(12, 13, 44)
	A0_0._masks.kemmler_bolt = World:make_slot_mask(17)
	A0_0._masks.shield = World:make_slot_mask(14)
	A0_0._masks.ai_editor = World:make_slot_mask(19, 45)
	A0_0._masks.groupables = World:make_slot_mask(1, 19, 24, 26, 27, 34)
	A0_0._masks.cutscenes = World:make_slot_mask(20)
	A0_0._masks.friends = World:make_slot_mask(3)
	A0_0._masks.good = World:make_slot_mask(2, 3, 39)
	A0_0._masks.claw_targets = World:make_slot_mask(1, 4, 5, 6, 7, 8, 9, 11, 13, 14, 23, 26, 39)
	A0_0._masks.claw_targets_auto = World:make_slot_mask(6, 7, 8, 11, 14, 23, 26)
	A0_0._masks.claw_targets_no_pickups = World:make_slot_mask(1, 4, 5, 6, 7, 8, 9, 11, 14, 23, 26, 39)
	A0_0._masks.rope_targets = World:make_slot_mask(1, 9, 11, 26)
	A0_0._masks.dump_mesh = World:make_slot_mask(1, 11, 26)
	A0_0._masks.overview_map = World:make_slot_mask(1)
	A0_0._masks.ai_graph = World:make_slot_mask(1, 26, 45)
	A0_0._masks.ai_graph_game = World:make_slot_mask(1, 11, 26, 45)
	A0_0._masks.tarantula_lock = World:make_slot_mask(2, 4, 5, 9, 11, 16, 23, 26, 27, 39)
	A0_0._masks.mine = World:make_slot_mask(2, 3, 4, 5, 6, 8, 11, 15, 39)
	A0_0._masks.beings = World:make_slot_mask(2, 4)
	A0_0._masks.area_damage = World:make_slot_mask(1, 3, 5, 8, 9, 11, 14, 23, 26, 27, 33, 39)
	A0_0._masks.evading_units = World:make_slot_mask(2, 4)
	A0_0._masks.missile_avoid_units = World:make_slot_mask(1, 6, 8, 11, 26, 33)
	A0_0._masks.plant_action_units = World:make_slot_mask(5)
	A0_0._masks.gravity_grenade_targets = World:make_slot_mask(2, 4, 6, 7, 8, 11, 13, 39)
	A0_0._masks.sound_swoosh = World:make_slot_mask(1, 4, 5, 9, 11, 15, 26, 39)
	A0_0._masks.player_autotarget = World:make_slot_mask(4, 5, 9, 22, 26)
	A0_0._masks.player_stickyaim = World:make_slot_mask(4, 5, 22, 26)
	A0_0._masks.player_tarantula_lock = World:make_slot_mask(4, 5, 9, 22, 23)
	A0_0._masks.player_tarantula_override = World:make_slot_mask(16)
	A0_0._masks.player_claw_autotarget = World:make_slot_mask(4, 5, 9, 13, 26)
	A0_0._masks.environment_events = World:make_slot_mask(2, 3, 4, 5, 6, 8, 11, 12, 15, 39)
	A0_0._masks.sonicblast_targets = World:make_slot_mask(2, 4, 8, 11, 13)
	A0_0._masks.brush_placeable = World:make_slot_mask(1)
	A0_0._masks.brushes = World:make_slot_mask(29)
	A0_0._masks.death_zone = World:make_slot_mask(32)
	A0_0._masks.swingable = World:make_slot_mask(1, 9)
	A0_0._masks.all_but_player = World:make_slot_mask(1, 4, 5, 6, 7, 8, 9, 10, 11, 22, 23, 26, 27, 39)
	A0_0._masks.claw_autotargets = World:make_slot_mask(4, 13)
	A0_0._masks.shootable_wo_adr_shield = World:make_slot_mask(1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 14, 15, 22, 23, 26, 27, 39)
	A0_0._masks.missile_avoid_units_wo_adr_shield = World:make_slot_mask(1, 6, 8, 11, 26)
	A0_0._masks.lancer_beam_check = World:make_slot_mask(1, 2, 3, 4, 5, 7, 9, 39)
	A0_0._masks.mover_collision_damage = World:make_slot_mask(1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 14, 16, 25, 26, 27, 39)
	A0_0._masks.body_collision_damage = World:make_slot_mask(1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 14, 16, 17, 23, 25, 26, 27, 28, 33, 39)
	A0_0._masks.player_ballistic_weapon = World:make_slot_mask(1, 3, 5, 6, 7, 8, 9, 11, 23, 26, 39)
	A0_0._masks.mp_claw_targets = World:make_slot_mask(1, 2, 4, 5, 6, 7, 8, 9, 11, 13, 14, 23, 26, 39)
	A0_0._masks.mp_claw_targets_no_pickups = World:make_slot_mask(1, 2, 4, 5, 6, 7, 8, 9, 11, 14, 23, 26, 39)
	A0_0._masks.static_elec_affected = World:make_slot_mask(6, 7, 8, 11)
	A0_0._masks.check_points_layer = World:make_slot_mask(36)
	A0_0._masks.fire_damage = A0_0._masks.players
	A0_0._masks.footstep_decals = World:make_slot_mask(1, 11)
	A0_0._masks.anchor_units = World:make_slot_mask(37)
	A0_0._masks.player_line_of_fire_blockers = A0_0._masks.visibility_blockers + A0_0._masks.players
	A0_0._masks.enemy_line_of_fire_blockers = A0_0._masks.visibility_blockers + A0_0._masks.enemies
	A0_0._masks.rail_vehicles = World:make_slot_mask(39)
	A0_0._masks.menu = World:make_slot_mask(40)
	A0_0._masks.explosion_covers = A0_0._masks.solid_objects - A0_0._masks.beings
	A0_0._masks.rails = World:make_slot_mask(43)
	A0_0._masks.mounted_guns = World:make_slot_mask(44)
	A0_0._masks.harvester_targets = World:make_slot_mask(46)
	A0_0._masks.navigation_graph = World:make_slot_mask(22)
end
