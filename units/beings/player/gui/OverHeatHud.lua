require("units/beings/player/new_gui/HudPanel")
require("units/beings/player_tank/gui/OverHeatBar")
OverHeatHud = OverHeatHud or class(HudPanel)
function OverHeatHud.init(A0_0, A1_1, A2_2, A3_3, A4_4)
	HudPanel.init(A0_0, false)
	assert(A2_2)
	A0_0._unit = A2_2
	A0_0._safe_panel = A1_1
	A0_0._width = 281
	A0_0._height = 54
	A0_0._bar_width = 10
	A0_0._bar_space = 3
	A0_0._total_bars_width = A0_0._width - 40
	A0_0._bar_texture_size = 128
	if A3_3 then
		A0_0._panel = A0_0._safe_panel:panel({
			name = "overheat_panel",
			width = A0_0._width,
			height = A0_0._height,
			valign = "bottom",
			halign = "left"
		})
		A0_0._panel:set_leftbottom(tweak_data.player.new_hud.overheat_panel.X_OFFSET, A0_0._safe_panel:height() - tweak_data.player.new_hud.overheat_panel.Y_OFFSET)
	else
		A0_0._panel = A0_0._safe_panel:panel({
			name = "overheat_panel",
			valign = "top",
			halign = "right",
			height = A0_0._height,
			width = A0_0._width
		})
		A0_0._panel:set_righttop(A0_0._safe_panel:width(), 0)
	end
	if not A4_4 then
		A0_0._background = A0_0._panel:bitmap({
			layer = 0,
			name = "weapon_background",
			texture = "gui_bullet_bg"
		})
		A0_0._background:set_texture_rect(115, 37, 512, 128)
		A0_0._background:set_blend_mode("normal")
	end
	A0_0:_set_up_meters()
	A0_0._alpha_interpolator = Interpolator:new(0, tweak_data.player.weapon_hud.FADE_SPEED)
	A0_0._stay_visible_time = 0
	HudPanel.set_alpha(A0_0, 0)
	A0_0._overheat_percent = 0
	A0_0:hide()
	A0_0:update_visibility(0)
end
function OverHeatHud.panel(A0_5)
	local L1_6
	L1_6 = A0_5._panel
	return L1_6
end
function OverHeatHud._set_up_meters(A0_7)
	local L1_8, L2_9, L3_10, L4_11, L5_12, L7_13, L8_14
	L1_8 = 0
	L2_9 = 26
	L3_10 = 10
	L4_11 = {}
	A0_7._overheat = L4_11
	L4_11 = A0_7._total_bars_width
	L4_11 = L4_11 / L5_12
	for _FORV_8_ = 1, L4_11 do
		A0_7._overheat[_FORV_8_] = OverHeatBar:new(A0_7._panel, "gui_machine_bar_small", L3_10 + L1_8, L2_9)
		A0_7._overheat[_FORV_8_]:set_image_height(25)
		A0_7._overheat[_FORV_8_]:set_texture_size(50)
		L1_8 = _FORV_8_ * (A0_7._bar_width + A0_7._bar_space)
	end
end
function OverHeatHud.set_overheat_value(A0_15)
	local L1_16
	L1_16 = alive
	L1_16 = L1_16(A0_15._weapon)
	if L1_16 then
		L1_16 = A0_15._weapon
		L1_16 = L1_16.logic
		L1_16 = L1_16(L1_16)
		L1_16 = L1_16.get_overheat_percent
		L1_16 = L1_16(L1_16)
		A0_15._overheat_percent = L1_16
	else
		A0_15._overheat_percent = 0
	end
	L1_16 = math
	L1_16 = L1_16.ceil
	L1_16 = L1_16(A0_15._overheat_percent * #A0_15._overheat)
	if L1_16 > #A0_15._overheat then
		L1_16 = #A0_15._overheat
	end
	for _FORV_5_ = 1, L1_16 do
		A0_15._overheat[_FORV_5_]:activate()
	end
	for _FORV_5_ = L1_16 + 1, #A0_15._overheat do
		A0_15._overheat[_FORV_5_]:inactivate()
	end
	for 