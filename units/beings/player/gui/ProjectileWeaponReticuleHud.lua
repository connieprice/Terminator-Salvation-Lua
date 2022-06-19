require("units/beings/player/gui/ProjectileWeaponReticulePiece")
ProjectileWeaponReticuleHud = ProjectileWeaponReticuleHud or class()
function ProjectileWeaponReticuleHud.init(A0_0, A1_1)
	A0_0._safe_panel = A1_1
	A0_0._reticule_panel = A0_0._safe_panel:panel({
		name = "reticule_panel ",
		x = A0_0._safe_panel:x(),
		y = A0_0._safe_panel:y(),
		width = A0_0._safe_panel:width(),
		height = A0_0._safe_panel:height()
	})
	A0_0:_setup_reticule()
end
function ProjectileWeaponReticuleHud.panel(A0_2)
	local L1_3
	L1_3 = A0_2._reticule_panel
	return L1_3
end
function ProjectileWeaponReticuleHud._setup_reticule(A0_4)
	local L1_5
	L1_5 = {}
	A0_4._reticule_pieces = L1_5
	L1_5 = A0_4._reticule_pieces
	L1_5.bottom = ProjectileWeaponReticulePiece:new(A0_4._reticule_panel, "gui_granade_long_full", 0, 200)
	L1_5 = A0_4._reticule_pieces
	L1_5.right = ProjectileWeaponReticulePiece:new(A0_4._reticule_panel, "gui_granade_short_thin", 200, 0)
	L1_5 = A0_4._reticule_pieces
	L1_5.left = ProjectileWeaponReticulePiece:new(A0_4._reticule_panel, "gui_granade_short_thin", -200, 0, 180)
end
function ProjectileWeaponReticuleHud.set_reticule_scale(A0_6, A1_7)
	if not A0_6._reticule_scale then
		A0_6._reticule_scale = A1_7
		A0_6:update_end_positions()
	end
end
function ProjectileWeaponReticuleHud.update_reticule_panel_size(A0_8, A1_9, A2_10)
	A0_8._reticule_panel:set_height(A1_9)
	A0_8._reticule_panel:set_width(A2_10)
	A0_8:update_end_positions()
end
function ProjectileWeaponReticuleHud.update_end_positions(A0_11)
	local L1_12, L2_13, L3_14
	L1_12 = A0_11._reticule_scale
	L1_12 = 1 - L1_12
	L2_13 = tweak_data
	L2_13 = L2_13.player
	L2_13 = L2_13.hud
	L2_13 = L2_13.RETICULE_MIN_OFFSET
	L1_12 = L1_12 * L2_13
	L1_12 = 10 + L1_12
	L2_13 = A0_11._reticule_scale
	L3_14 = tweak_data
	L3_14 = L3_14.player
	L3_14 = L3_14.hud
	L3_14 = L3_14.RETICULE_MAX_OFFSET
	L2_13 = L2_13 * L3_14
	L1_12 = L1_12 + L2_13
	L2_13 = A0_11._reticule_panel
	L3_14 = L2_13
	L2_13 = L2_13.width
	L2_13 = L2_13(L3_14)
	L2_13 = L2_13 / 2
	L3_14 = A0_11._reticule_panel
	L3_14 = L3_14.height
	L3_14 = L3_14(L3_14)
	L3_14 = L3_14 / 2
	A0_11._reticule_pieces.right:set_end_positions(L2_13 + L1_12, L3_14)
	A0_11._reticule_pieces.left:set_end_positions(L2_13 - L1_12, L3_14)
	A0_11._reticule_pieces.bottom:set_end_positions(L2_13, L3_14 + L1_12 + 26)
end
function ProjectileWeaponReticuleHud.set_player_control(A0_15, A1_16)
	A0_15._player_control = A1_16
end
function ProjectileWeaponReticuleHud.update(A0_17, A1_18, A2_19)
	if A0_17._reticule_panel:height() ~= A2_19:height() or A0_17._reticule_panel:width() ~= A2_19:width() then
		A0_17:update_reticule_panel_size(A2_19:height(), A2_19:width())
	end
	for 