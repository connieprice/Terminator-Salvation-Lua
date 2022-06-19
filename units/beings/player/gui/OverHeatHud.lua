require("units/beings/player/new_gui/HudPanel")
require("units/beings/player_tank/gui/OverHeatBar")
if not OverHeatHud then
	OverHeatHud = class(HudPanel)
end
OverHeatHud.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4)
	HudPanel.init(l_1_0, false)
	assert(l_1_2)
	l_1_0._unit = l_1_2
	l_1_0._safe_panel = l_1_1
	l_1_0._width = 281
	l_1_0._height = 54
	l_1_0._bar_width = 10
	l_1_0._bar_space = 3
	l_1_0._total_bars_width = l_1_0._width - 40
	l_1_0._bar_texture_size = 128
	if l_1_3 then
		local l_1_5, l_1_6 = l_1_0._safe_panel:panel, l_1_0._safe_panel
		local l_1_7 = {}
		l_1_7.name = "overheat_panel"
		l_1_7.width = l_1_0._width
		l_1_7.height = l_1_0._height
		l_1_7.valign = "bottom"
		l_1_7.halign = "left"
		l_1_5 = l_1_5(l_1_6, l_1_7)
		l_1_0._panel = l_1_5
		l_1_5 = l_1_0._panel
		l_1_5, l_1_6 = l_1_5:set_leftbottom, l_1_5
		l_1_7 = tweak_data
		l_1_7 = l_1_7.player
		l_1_7 = l_1_7.new_hud
		l_1_7 = l_1_7.overheat_panel
		l_1_7 = l_1_7.X_OFFSET
		l_1_5(l_1_6, l_1_7, l_1_0._safe_panel:height() - tweak_data.player.new_hud.overheat_panel.Y_OFFSET)
	else
		local l_1_8, l_1_9 = l_1_0._safe_panel:panel, l_1_0._safe_panel
		local l_1_10 = {}
		l_1_10.name = "overheat_panel"
		l_1_10.valign = "top"
		l_1_10.halign = "right"
		l_1_10.height = l_1_0._height
		l_1_10.width = l_1_0._width
		l_1_8 = l_1_8(l_1_9, l_1_10)
		l_1_0._panel = l_1_8
		l_1_8 = l_1_0._panel
		l_1_8, l_1_9 = l_1_8:set_righttop, l_1_8
		l_1_10 = l_1_0._safe_panel
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_1_8(l_1_9, l_1_10, 0)
	end
	if not l_1_4 then
		local l_1_11, l_1_12 = l_1_0._panel:bitmap, l_1_0._panel
		local l_1_13 = {}
		l_1_13.layer = 0
		l_1_13.name = "weapon_background"
		l_1_13.texture = "gui_bullet_bg"
		l_1_11 = l_1_11(l_1_12, l_1_13)
		l_1_0._background = l_1_11
		l_1_11 = l_1_0._background
		l_1_11, l_1_12 = l_1_11:set_texture_rect, l_1_11
		l_1_13 = 115
		l_1_11(l_1_12, l_1_13, 37, 512, 128)
		l_1_11 = l_1_0._background
		l_1_11, l_1_12 = l_1_11:set_blend_mode, l_1_11
		l_1_13 = "normal"
		l_1_11(l_1_12, l_1_13)
	end
	l_1_0:_set_up_meters()
	l_1_0._alpha_interpolator = Interpolator:new(0, tweak_data.player.weapon_hud.FADE_SPEED)
	l_1_0._stay_visible_time = 0
	HudPanel.set_alpha(l_1_0, 0)
	l_1_0._overheat_percent = 0
	l_1_0:hide()
	l_1_0:update_visibility(0)
end

OverHeatHud.panel = function(l_2_0)
	return l_2_0._panel
end

OverHeatHud._set_up_meters = function(l_3_0)
	local l_3_1 = 0
	local l_3_2 = 26
	local l_3_3 = 10
	l_3_0._overheat = {}
	local l_3_4 = l_3_0._total_bars_width / (l_3_0._bar_width + l_3_0._bar_space)
	for l_3_8 = 1, l_3_4 do
		l_3_0._overheat[l_3_8] = OverHeatBar:new(l_3_0._panel, "gui_machine_bar_small", l_3_3 + l_3_1, l_3_2)
		l_3_0._overheat[l_3_8]:set_image_height(25)
		l_3_0._overheat[l_3_8]:set_texture_size(50)
		l_3_1 = l_3_8 * (l_3_0._bar_width + l_3_0._bar_space)
	end
end

OverHeatHud.set_overheat_value = function(l_4_0)
	if alive(l_4_0._weapon) then
		l_4_0._overheat_percent = l_4_0._weapon:logic():get_overheat_percent()
	else
		l_4_0._overheat_percent = 0
	end
	if #l_4_0._overheat < math.ceil(l_4_0._overheat_percent * #l_4_0._overheat) then
		local l_4_1, l_4_2, l_4_7, l_4_8, l_4_13 = #l_4_0._overheat
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	for l_4_6 = 1, l_4_1 do
		local l_4_3 = nil
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_4_0._overheat[l_4_13]:activate()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	for l_4_12 = l_4_3 + 1, #l_4_0._overheat do
		local l_4_9, l_4_19, l_4_21 = nil
		l_4_19 = l_4_0._overheat
		l_4_19 = l_4_19[l_4_17]
		l_4_19, l_4_21 = l_4_19:inactivate, l_4_19
		local l_4_18, l_4_20, l_4_22 = nil
		l_4_19(l_4_21)
	end
	for i_0,i_1 in pairs(l_4_0._overheat) do
		local l_4_14 = nil
		if l_4_0._overheat_percent > 0.7 then
			l_4_0._red_alpha = (l_4_0._overheat_percent - 0.7) * 2.2
			i_1:set_red_alpha(l_4_0._red_alpha)
		end
	end
end

OverHeatHud.update_visibility = function(l_5_0, l_5_1)
	if l_5_0._overheat_percent > 0 then
		l_5_0._stay_visible_time = tweak_data.player.weapon_hud.STAY_VISIBILE_DELAY_AFTER_SHOOTING
	end
	if l_5_0._stay_visible_time > 0 and not l_5_0._hide then
		l_5_0._alpha_interpolator:set_target(1)
	else
		l_5_0._alpha_interpolator:set_target(0)
	end
	l_5_0._stay_visible_time = l_5_0._stay_visible_time - l_5_1
	l_5_0._alpha_interpolator:update(l_5_1)
	local l_5_2 = l_5_0._alpha_interpolator:value()
	if not l_5_0._unit:base():player_has_control() then
		l_5_2 = 0
	end
	l_5_0:set_alpha(l_5_2)
end

OverHeatHud.set_alpha = function(l_6_0, l_6_1)
	HudPanel.set_alpha(l_6_0, l_6_1)
	if l_6_0._background then
		local l_6_5, l_6_6, l_6_7, l_6_8 = l_6_0._background:set_color, l_6_0._background, l_6_0._background:color():with_alpha(l_6_1), .end
		l_6_5(l_6_6, l_6_7, l_6_8)
	end
	for i_0,i_1 in pairs(l_6_0._overheat) do
		i_1:set_alpha(l_6_1)
	end
end

OverHeatHud.hide = function(l_7_0)
	l_7_0._hide = true
end

OverHeatHud.show = function(l_8_0, l_8_1)
	l_8_0._hide = false
	l_8_0._weapon = l_8_1
	assert(l_8_0._weapon)
end

OverHeatHud.visible = function(l_9_0)
	return l_9_0._alpha_interpolator:value() > 0
end

OverHeatHud.update = function(l_10_0, l_10_1)
	local l_10_5, l_10_6, l_10_7, l_10_8 = nil
	for i_0,i_1 in pairs(l_10_0._overheat) do
		i_1:update(l_10_1)
	end
	l_10_0:set_overheat_value()
	l_10_0:update_visibility(l_10_1)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


