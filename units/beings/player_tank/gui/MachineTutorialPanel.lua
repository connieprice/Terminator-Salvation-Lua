MachineTutorialPanel = MachineTutorialPanel or class()
function MachineTutorialPanel.init(A0_0, A1_1, A2_2, A3_3)
	A0_0._parent_panel = A1_1
	A0_0._coop = A2_2
	A0_0._unit = A3_3
	A0_0._alpha_interpolator = Interpolator:new(0, tweak_data.player.new_hud.ammo_panel.FADE_IN_SPEED)
	A0_0._alpha_interpolator:set_target(1)
	A0_0._stay_visible_time = 11
	A0_0._next_blink_time = 0
	A0_0._blink_speed = 0.25
	A0_0._overheat_blink_start = 6
	A0_0._overheat_blink_end = 9
	A0_0._powerup_blink_start = 2
	A0_0._powerup_blink_end = 5
	A0_0._blink_overheat = false
	A0_0._blink_powerup = false
	A0_0._tutorial_panel = A0_0._parent_panel:panel({
		name = "tutorial_panel",
		width = A0_0._parent_panel:width(),
		height = A0_0._parent_panel:height(),
		layer = 100
	})
end
function MachineTutorialPanel.panel(A0_4)
	local L1_5
	L1_5 = A0_4._tutorial_panel
	return L1_5
end
function MachineTutorialPanel._setup_tutorial_texts(A0_6)
	local L1_7, L2_8, L3_9, L4_10, L5_11
	L1_7 = A0_6._tutorial_panel
	L2_8 = L1_7
	L1_7 = L1_7.set_width
	L3_9 = A0_6._parent_panel
	L4_10 = L3_9
	L3_9 = L3_9.width
	L4_10 = L3_9(L4_10)
	L1_7(L2_8, L3_9, L4_10, L5_11, L3_9(L4_10))
	L1_7 = A0_6._tutorial_panel
	L2_8 = L1_7
	L1_7 = L1_7.set_height
	L3_9 = A0_6._parent_panel
	L4_10 = L3_9
	L3_9 = L3_9.height
	L4_10 = L3_9(L4_10)
	L1_7(L2_8, L3_9, L4_10, L5_11, L3_9(L4_10))
	L1_7 = A0_6._overheat_tutorial_panel
	L2_8 = L1_7
	L1_7 = L1_7.panel
	L1_7 = L1_7(L2_8)
	L2_8 = L1_7
	L1_7 = L1_7.x
	L1_7 = L1_7(L2_8)
	L2_8 = A0_6._overheat_tutorial_panel
	L3_9 = L2_8
	L2_8 = L2_8.panel
	L2_8 = L2_8(L3_9)
	L3_9 = L2_8
	L2_8 = L2_8.y
	L2_8 = L2_8(L3_9)
	L3_9 = A0_6._overheat_tutorial_panel
	L3_9 = L3_9._size_modifier
	L3_9 = 4 * L3_9
	L2_8 = L2_8 - L3_9
	L3_9 = A0_6._unit
	L4_10 = L3_9
	L3_9 = L3_9.name
	L3_9 = L3_9(L4_10)
	if L3_9 == "player2_tank" then
		L3_9 = A0_6._overheat_tutorial_panel
		L3_9 = L3_9._size_modifier
		L3_9 = 22 * L3_9
		L2_8 = L2_8 + L3_9
	end
	L3_9 = A0_6._overheat_tutorial_panel
	L4_10 = L3_9
	L3_9 = L3_9.panel
	L3_9 = L3_9(L4_10)
	L4_10 = L3_9
	L3_9 = L3_9.width
	L3_9 = L3_9(L4_10)
	L4_10 = A0_6._powerup_tutorial_panel
	L4_10 = L4_10._height
	L4_10 = L4_10 - L5_11
	if L5_11 then
		for 