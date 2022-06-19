require("units/beings/player/new_gui/ReticulePiece")
require("units/beings/player/new_gui/HudPanel")
if not ReticulePanel then
	ReticulePanel = class(HudPanel)
end
ReticulePanel.init = function(l_1_0, l_1_1, l_1_2)
	HudPanel.init(l_1_0, false)
	l_1_0:set_mid_frequency_update(0.06666667)
	l_1_0._parent_panel = l_1_1
	l_1_0._player_unit = l_1_2
	l_1_0._player_data = l_1_2:player_data()
	local l_1_3, l_1_4 = l_1_0._parent_panel:panel, l_1_0._parent_panel
	local l_1_5 = {}
	l_1_5.name = "reticule_panel"
	l_1_5.width = l_1_0._width
	l_1_5.height = l_1_0._height
	l_1_5.valign = "center"
	l_1_5.halign = "center"
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0._panel = l_1_3
	l_1_0._reticule_pieces, l_1_3 = l_1_3, {}
	l_1_3, l_1_4 = l_1_0:use_circle_reticule, l_1_0
	l_1_3(l_1_4)
	l_1_3, l_1_4 = l_1_0:set_alpha, l_1_0
	l_1_5 = 0
	l_1_3(l_1_4, l_1_5)
end

ReticulePanel.panel = function(l_2_0)
	return l_2_0._panel
end

ReticulePanel.use_circle_reticule = function(l_3_0)
	local l_3_4, l_3_5, l_3_6, l_3_7 = nil
	if l_3_0._reticule_type ~= "circle_reticule" or l_3_0._on_rail ~= l_3_0._player_data.on_rail_vehicle then
		l_3_0._reticule_type = "circle_reticule"
		l_3_0._on_rail = l_3_0._player_data.on_rail_vehicle
		for i_0,i_1 in pairs(l_3_0._reticule_pieces) do
			i_1:set_alpha(0)
		end
		l_3_0._reticule_pieces = {}
		l_3_0._reticule_pieces.top = ReticulePiece:new(l_3_0._panel, "top", l_3_0._reticule_type, l_3_0._on_rail)
		l_3_0._reticule_pieces.right = ReticulePiece:new(l_3_0._panel, "right", l_3_0._reticule_type, l_3_0._on_rail)
		l_3_0._reticule_pieces.bottom = ReticulePiece:new(l_3_0._panel, "bottom", l_3_0._reticule_type, l_3_0._on_rail)
		l_3_0._reticule_pieces.left = ReticulePiece:new(l_3_0._panel, "left", l_3_0._reticule_type, l_3_0._on_rail)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

ReticulePanel.use_trajectory_reticule = function(l_4_0)
	local l_4_4, l_4_5, l_4_6, l_4_7 = nil
	if l_4_0._reticule_type ~= "trajectory_reticule" or l_4_0._on_rail ~= l_4_0._player_data.on_rail_vehicle then
		l_4_0._reticule_type = "trajectory_reticule"
		l_4_0._on_rail = l_4_0._player_data.on_rail_vehicle
		for i_0,i_1 in pairs(l_4_0._reticule_pieces) do
			i_1:set_alpha(0)
		end
		l_4_0._reticule_pieces = {}
		l_4_0._reticule_pieces.right = ReticulePiece:new(l_4_0._panel, "right", l_4_0._reticule_type, l_4_0._on_rail)
		l_4_0._reticule_pieces.bottom = ReticulePiece:new(l_4_0._panel, "bottom", l_4_0._reticule_type, l_4_0._on_rail)
		l_4_0._reticule_pieces.left = ReticulePiece:new(l_4_0._panel, "left", l_4_0._reticule_type, l_4_0._on_rail)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

ReticulePanel.use_circular_trajectory_reticule = function(l_5_0)
	local l_5_4, l_5_5, l_5_6, l_5_7 = nil
	if l_5_0._reticule_type ~= "circular_trajectory_reticule" or l_5_0._on_rail ~= l_5_0._player_data.on_rail_vehicle then
		l_5_0._reticule_type = "circular_trajectory_reticule"
		l_5_0._on_rail = l_5_0._player_data.on_rail_vehicle
		for i_0,i_1 in pairs(l_5_0._reticule_pieces) do
			i_1:set_alpha(0)
		end
		l_5_0._reticule_pieces = {}
		l_5_0._reticule_pieces.bottom = ReticulePiece:new(l_5_0._panel, "bottom", l_5_0._reticule_type, l_5_0._on_rail)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

ReticulePanel.update = function(l_6_0, l_6_1, l_6_2)
	local l_6_3 = false
	if l_6_2 and not alive(l_6_0._player_data.weakspot_outline_object) and l_6_0._player_data.on_rail_vehicle then
		local l_6_9, l_6_10, l_6_11, l_6_12, l_6_13, l_6_14, l_6_15, l_6_16 = l_6_2:in_slot, l_6_2, managers.slot:get_mask("enemies"), .end
		l_6_9 = l_6_9(l_6_10, l_6_11, l_6_12, l_6_13, l_6_14, l_6_15, l_6_16)
	if l_6_9 then
		end
		l_6_3 = true
	end
	l_6_9 = 0
	local l_6_4 = nil
	l_6_10 = true
	local l_6_5 = nil
	l_6_11 = pairs
	l_6_12 = l_6_0._reticule_pieces
	l_6_11 = l_6_11(l_6_12)
	for l_6_14,l_6_15 in l_6_11 do
		do
			local l_6_6, l_6_7, l_6_8 = nil
			l_6_16, l_6_4 = l_6_15:update, l_6_15
			l_6_5 = l_6_1
			l_6_6 = l_6_3
			l_6_16(l_6_4, l_6_5, l_6_6)
			l_6_16 = math
			l_6_16 = l_6_16.max
			l_6_4 = l_6_9
			l_6_5, l_6_6 = l_6_15:get_alpha, l_6_15
			l_6_6, l_6_5 = .end, l_6_5(l_6_6)
			l_6_16 = l_6_16(l_6_4, l_6_5, l_6_6, l_6_7, l_6_8)
			l_6_9 = l_6_16
			l_6_16 = l_6_15._wants_to_idle
			if not l_6_16 then
				l_6_10 = false
			end
		end
		if l_6_10 then
			l_6_0:use_mid_frequency_update()
		end
		l_6_0:set_alpha(l_6_9)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ReticulePanel.set_alpha = function(l_7_0, l_7_1)
	HudPanel.set_alpha(l_7_0, l_7_1)
end

ReticulePanel.instant_show = function(l_8_0)
	local l_8_4, l_8_5, l_8_6, l_8_7 = nil
	for i_0,i_1 in pairs(l_8_0._reticule_pieces) do
		i_1:set_alpha(l_8_0._alpha)
	end
end

ReticulePanel.show = function(l_9_0)
	local l_9_4, l_9_5, l_9_6, l_9_7 = nil
	if not l_9_0._show or l_9_0._alpha == 0 then
		for i_0,i_1 in pairs(l_9_0._reticule_pieces) do
			i_1:move_in()
		end
		l_9_0._show = true
		l_9_0:use_high_frequency_update()
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

ReticulePanel.hide = function(l_10_0)
	local l_10_4, l_10_5, l_10_6, l_10_7 = nil
	if l_10_0._show then
		for i_0,i_1 in pairs(l_10_0._reticule_pieces) do
			i_1:move_out()
		end
		l_10_0._show = false
		l_10_0:use_high_frequency_update()
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

ReticulePanel.instant_hide = function(l_11_0)
	local l_11_4, l_11_5, l_11_6, l_11_7, l_11_8, l_11_9, l_11_10, l_11_11 = nil
	for i_0,i_1 in pairs(l_11_0._reticule_pieces) do
		i_1:set_instant_hide()
		i_1:move_out()
	end
end

ReticulePanel.visible = function(l_12_0)
	local l_12_1, l_12_2 = l_12_0._panel:visible, l_12_0._panel
	return l_12_1(l_12_2)
end


