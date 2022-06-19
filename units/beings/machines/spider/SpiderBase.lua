require("ai/common/NavigationGraphUtilities")
require("projectile/InstantBulletSpawner")
require("units/beings/machines/spider/states/SpiderNormalState")
require("units/beings/machines/spider/states/SpiderDeadState")
require("units/beings/machines/spider/states/SpiderFullyDamagedState")
require("shared/updatescheduler/UpdateSchedulerDtMethod")
SpiderBase = SpiderBase or class()
SpiderBase._CHEST_ROTATION = Rotation(math.UP, 90)
SpiderBase._HORIZONTAL_GUN_ROTATION = SpiderBase._CHEST_ROTATION
SpiderBase._VERTICAL_GUN_ROTATION = SpiderBase._CHEST_ROTATION
SpiderBase._PREPARING_ATTACK_SOUND_NAME = "spider_detect"
SpiderBase._PREPARING_ATTACK_SOUND_OUTPUT_OBJECT_NAME = "head"
SpiderBase._FEET_OBJECT_TO_GLOBAL_MACHINE_HEIGHTS = {
	leg_front_left4 = "front_left_leg_height",
	leg_front_right4 = "front_right_leg_height",
	leg_back_left4 = "rear_left_leg_height",
	leg_back_right4 = "rear_right_leg_height"
}
function SpiderBase.init(A0_0, A1_1)
	local L2_2, L3_3, L4_4, L5_5, L6_6
	A0_0._unit = A1_1
	L2_2 = A1_1.set_driving
	L2_2(L3_3, L4_4)
	L2_2 = A1_1.set_separate_weight
	L2_2(L3_3, L4_4)
	L2_2 = A0_0._unit
	L2_2 = L2_2.anim_state_machine
	L2_2 = L2_2(L3_3)
	A0_0._state_machine = L2_2
	L2_2 = Draw
	L2_2 = L2_2.brush
	L2_2 = L2_2(L3_3)
	A0_0._debug_brush = L2_2
	L2_2 = Draw
	L2_2 = L2_2.brush
	L2_2 = L2_2(L3_3)
	A0_0._debug_text_brush = L2_2
	L2_2 = A0_0._debug_text_brush
	L2_2 = L2_2.set_font
	L2_2(L3_3, L4_4, L5_5)
	L2_2 = A1_1.enemy_data
	L2_2 = L2_2(L3_3)
	A0_0._enemy_data = L2_2
	L2_2 = A0_0._enter_state
	L6_6 = A1_1
	L6_6 = L4_4(L5_5, L6_6)
	L2_2(L3_3, L4_4, L5_5, L6_6, L4_4(L5_5, L6_6))
	L2_2 = World
	L2_2 = L2_2.spawn_unit
	L6_6 = L5_5
	L6_6 = A0_0._unit
	L6_6 = L6_6.rotation
	L6_6 = L6_6(L6_6)
	L2_2 = L2_2(L3_3, L4_4, L5_5, L6_6, L6_6(L6_6))
	A0_0._left_weapon = L2_2
	L2_2 = A0_0._unit
	L2_2 = L2_2.link
	L6_6 = A0_0._left_weapon
	L6_6 = L6_6.orientation_object
	L6_6 = L6_6(L6_6)
	L6_6 = L6_6.name
	L6_6 = L6_6(L6_6)
	L2_2(L3_3, L4_4, L5_5, L6_6, L6_6(L6_6))
	L2_2 = A0_0._left_weapon
	L2_2 = L2_2.base
	L2_2 = L2_2(L3_3)
	L2_2 = L2_2.setup
	L2_2(L3_3, L4_4)
	L2_2 = A0_0._left_weapon
	L2_2 = L2_2.base
	L2_2 = L2_2(L3_3)
	L2_2 = L2_2.set_equiped
	L2_2(L3_3, L4_4)
	L2_2 = A0_0._left_weapon
	L2_2 = L2_2.base
	L2_2 = L2_2(L3_3)
	L2_2 = L2_2.enable
	L2_2(L3_3)
	L2_2 = World
	L2_2 = L2_2.spawn_unit
	L6_6 = L5_5
	L6_6 = A0_0._unit
	L6_6 = L6_6.rotation
	L6_6 = L6_6(L6_6)
	L2_2 = L2_2(L3_3, L4_4, L5_5, L6_6, L6_6(L6_6))
	A0_0._right_weapon = L2_2
	L2_2 = A0_0._unit
	L2_2 = L2_2.link
	L6_6 = A0_0._right_weapon
	L6_6 = L6_6.orientation_object
	L6_6 = L6_6(L6_6)
	L6_6 = L6_6.name
	L6_6 = L6_6(L6_6)
	L2_2(L3_3, L4_4, L5_5, L6_6, L6_6(L6_6))
	L2_2 = A0_0._right_weapon
	L2_2 = L2_2.base
	L2_2 = L2_2(L3_3)
	L2_2 = L2_2.setup
	L2_2(L3_3, L4_4)
	L2_2 = A0_0._right_weapon
	L2_2 = L2_2.base
	L2_2 = L2_2(L3_3)
	L2_2 = L2_2.set_equiped
	L2_2(L3_3, L4_4)
	L2_2 = A0_0._right_weapon
	L2_2 = L2_2.base
	L2_2 = L2_2(L3_3)
	L2_2 = L2_2.enable
	L2_2(L3_3)
	L2_2 = A0_0._state_machine
	L2_2 = L2_2.get_modifier
	L2_2 = L2_2(L3_3, L4_4)
	A0_0._ik_chest = L2_2
	L2_2 = A0_0._state_machine
	L2_2 = L2_2.get_modifier
	L2_2 = L2_2(L3_3, L4_4)
	A0_0._ik_gun_left = L2_2
	L2_2 = A0_0._state_machine
	L2_2 = L2_2.get_modifier
	L2_2 = L2_2(L3_3, L4_4)
	A0_0._ik_gun_right = L2_2
	L2_2 = Sound
	L2_2 = L2_2.make_bank
	L2_2 = L2_2(L3_3, L4_4, L5_5)
	A0_0._preparing_attack_sound = L2_2
	L2_2 = A1_1.get_object
	L2_2 = L2_2(L3_3, L4_4)
	L3_3(L4_4, L5_5)
	L6_6 = L5_5
	L4_4.weapon_object = L5_5
	L4_4.weapon = L5_5
	L6_6 = L5_5
	L4_4.ik = L5_5
	L4_4.recoil_anim = "recoil_left"
	L6_6 = L5_5
	L4_4.weapon_data = L5_5
	L6_6 = A0_0._unit
	L6_6 = L6_6.get_object
	L6_6 = L6_6(L6_6, "gun_right")
	L5_5.weapon_object = L6_6
	L6_6 = A0_0._right_weapon
	L5_5.weapon = L6_6
	L6_6 = A0_0._state_machine
	L6_6 = L6_6.get_modifier
	L6_6 = L6_6(L6_6, "ik_gun_right")
	L5_5.ik = L6_6
	L5_5.recoil_anim = "recoil_right"
	L6_6 = A0_0._right_weapon
	L6_6 = L6_6.weapon_data
	L6_6 = L6_6(L6_6)
	L5_5.weapon_data = L6_6
	A0_0._weapon_infos = L3_3
	A0_0._curr_ik_rotation = L3_3
	A0_0._feet_heights = L3_3
	for L6_6, 