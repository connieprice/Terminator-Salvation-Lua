require("units/beings/player/gui/ProjectileWeaponReticulePiece")
if not ProjectileWeaponReticuleHud then
	ProjectileWeaponReticuleHud = class()
end
ProjectileWeaponReticuleHud.init = function(l_1_0, l_1_1)
	l_1_0._safe_panel = l_1_1
	local l_1_2, l_1_3 = l_1_0._safe_panel:panel, l_1_0._safe_panel
	local l_1_4 = {}
	l_1_4.name = "reticule_panel "
	l_1_4.x = l_1_0._safe_panel:x()
	l_1_4.y = l_1_0._safe_panel:y()
	l_1_4.width = l_1_0._safe_panel:width()
	l_1_4.height = l_1_0._safe_panel:height()
	l_1_2 = l_1_2(l_1_3, l_1_4)
	l_1_0._reticule_panel = l_1_2
	l_1_2, l_1_3 = l_1_0:_setup_reticule, l_1_0
	l_1_2(l_1_3)
end

ProjectileWeaponReticuleHud.panel = function(l_2_0)
	return l_2_0._reticule_panel
end

ProjectileWeaponReticuleHud._setup_reticule = function(l_3_0)
	l_3_0._reticule_pieces = {}
	l_3_0._reticule_pieces.bottom = ProjectileWeaponReticulePiece:new(l_3_0._reticule_panel, "gui_granade_long_full", 0, 200)
	l_3_0._reticule_pieces.right = ProjectileWeaponReticulePiece:new(l_3_0._reticule_panel, "gui_granade_short_thin", 200, 0)
	l_3_0._reticule_pieces.left = ProjectileWeaponReticulePiece:new(l_3_0._reticule_panel, "gui_granade_short_thin", -200, 0, 180)
end

ProjectileWeaponReticuleHud.set_reticule_scale = function(l_4_0, l_4_1)
	if not l_4_0._reticule_scale then
		l_4_0._reticule_scale = l_4_1
		l_4_0:update_end_positions()
	end
end

ProjectileWeaponReticuleHud.update_reticule_panel_size = function(l_5_0, l_5_1, l_5_2)
	l_5_0._reticule_panel:set_height(l_5_1)
	l_5_0._reticule_panel:set_width(l_5_2)
	l_5_0:update_end_positions()
end

ProjectileWeaponReticuleHud.update_end_positions = function(l_6_0)
	local l_6_1 = 10 + (1 - l_6_0._reticule_scale) * tweak_data.player.hud.RETICULE_MIN_OFFSET + l_6_0._reticule_scale * tweak_data.player.hud.RETICULE_MAX_OFFSET
	local l_6_2 = l_6_0._reticule_panel:width() / 2
	local l_6_3 = l_6_0._reticule_panel:height() / 2
	l_6_0._reticule_pieces.right:set_end_positions(l_6_2 + l_6_1, l_6_3)
	l_6_0._reticule_pieces.left:set_end_positions(l_6_2 - l_6_1, l_6_3)
	l_6_0._reticule_pieces.bottom:set_end_positions(l_6_2, l_6_3 + l_6_1 + 26)
end

ProjectileWeaponReticuleHud.set_player_control = function(l_7_0, l_7_1)
	l_7_0._player_control = l_7_1
end

ProjectileWeaponReticuleHud.update = function(l_8_0, l_8_1, l_8_2)
	if l_8_0._reticule_panel:height() ~= l_8_2:height() or l_8_0._reticule_panel:width() ~= l_8_2:width() then
		local l_8_6, l_8_7, l_8_8, l_8_9, l_8_10, l_8_11, l_8_12, l_8_13, l_8_14, l_8_15, l_8_16, l_8_17 = l_8_0:update_reticule_panel_size, l_8_0, l_8_2:height(), l_8_2:width(), .end
		l_8_6(l_8_7, l_8_8, l_8_9, l_8_10, l_8_11, l_8_12, l_8_13, l_8_14, l_8_15, l_8_16, l_8_17)
	end
	for i_0,i_1 in pairs(l_8_0._reticule_pieces) do
		if l_8_0._player_control then
			i_1:move_in()
		else
			i_1:move_out()
		end
		i_1:update(l_8_1)
	end
end

ProjectileWeaponReticuleHud.visible = function(l_9_0)
	local l_9_4, l_9_5 = nil
	for i_0,i_1 in pairs(l_9_0._reticule_pieces) do
		if i_1:get_alpha() > 0 then
			return true
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


