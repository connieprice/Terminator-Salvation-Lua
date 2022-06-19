RadarBlip = RadarBlip or class()
function RadarBlip.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5)
	A0_0._parent_panel = A1_1
	A0_0._shrink_fade_out = A4_4
	A0_0._size_modifier = A5_5 or 1
	A0_0._color = tweak_data.machine.hud.HIGHLIGHT_COLOR_TWEAK
	A0_0._x = A2_2
	A0_0._y = A3_3
	A0_0._fade_out_x = A0_0._x
	A0_0._fade_out_y = A0_0._y
	A0_0._show_time = 0.3
	A0_0._time_shown = 0
	A0_0._is_done = false
	A0_0._radar_blip_texture = A0_0._parent_panel:bitmap({
		name = "gui_machine_radar_dot",
		texture = "gui_machine_radar_dot"
	})
	A0_0._radar_blip_texture:set_size(16 * A0_0._size_modifier, 16 * A0_0._size_modifier)
	A0_0._radar_blip_texture:set_center_x(A0_0._x)
	A0_0._radar_blip_texture:set_center_y(A0_0._y)
	A0_0:set_alpha(0)
	A0_0._texture_width = A0_0._radar_blip_texture:width()
	A0_0._texture_height = A0_0._radar_blip_texture:height()
	A0_0._interpolator_fade_in_speed = 10
	A0_0._interpolator_fade_out_speed = 1.2
	A0_0._interpolator = Interpolator:new(0, A0_0._interpolator_fade_in_speed)
	A0_0._interpolator:set_target(1)
	A0_0._show = false
	A0_0._fade_out = false
	A0_0._size_threshold = 0.4
end
function RadarBlip.show(A0_6)
	A0_6._show = true
	if not A0_6._time_since_last_showed or A0_6._time_since_last_showed > 2 then
		A0_6._interpolator:set_target(1)
		A0_6._interpolator:set_speed(A0_6._interpolator_fade_in_speed)
		A0_6._fade_out = false
		A0_6._time_shown = 0
		A0_6._time_since_last_showed = 0
		A0_6._radar_blip_texture:set_size(A0_6._texture_width, A0_6._texture_height)
		A0_6._radar_blip_texture:set_center_x(A0_6._x)
		A0_6._radar_blip_texture:set_center_y(A0_6._y)
		A0_6._fade_out_x = A0_6._x
		A0_6._fade_out_y = A0_6._y
	end
end
function RadarBlip.unhide(A0_7)
	local L1_8
	L1_8 = A0_7._interpolator
	L1_8 = L1_8.value
	L1_8 = L1_8(L1_8)
	if A0_7._radar_blip_texture then
		A0_7:set_alpha(L1_8)
	end
end
function RadarBlip.hide(A0_9)
	if A0_9._radar_blip_texture then
		A0_9:set_alpha(0)
	end
end
function RadarBlip.is_done(A0_10)
	local L1_11
	L1_11 = A0_10._is_done
	return L1_11
end
function RadarBlip.update(A0_12, A1_13)
	local L2_14, L3_15, L4_16
	L2_14 = A0_12._show
	if not L2_14 then
		return
	end
	L2_14 = A0_12._time_shown
	L2_14 = L2_14 + A1_13
	A0_12._time_shown = L2_14
	L2_14 = A0_12._time_since_last_showed
	if L2_14 then
		L2_14 = A0_12._time_since_last_showed
		L2_14 = L2_14 + A1_13
		A0_12._time_since_last_showed = L2_14
	end
	L2_14 = A0_12._time_shown
	L3_15 = A0_12._show_time
	if L2_14 > L3_15 then
		L2_14 = A0_12._fade_out
		if not L2_14 then
			L2_14 = A0_12._interpolator
			L3_15 = L2_14
			L2_14 = L2_14.set_target
			L4_16 = 0
			L2_14(L3_15, L4_16)
			A0_12._fade_out = true
		end
	end
	L2_14 = A0_12._fade_out
	if L2_14 then
		L2_14 = A0_12._interpolator
		L3_15 = L2_14
		L2_14 = L2_14.set_speed
		L4_16 = A0_12._interpolator_fade_out_speed
		L2_14(L3_15, L4_16)
	end
	L2_14 = A0_12._interpolator
	L3_15 = L2_14
	L2_14 = L2_14.update
	L4_16 = A1_13
	L2_14(L3_15, L4_16)
	L2_14 = A0_12._fade_out
	if L2_14 then
		L2_14 = A0_12._interpolator
		L3_15 = L2_14
		L2_14 = L2_14.has_reached_target
		L2_14 = L2_14(L3_15)
		if L2_14 then
			L3_15 = A0_12
			L2_14 = A0_12.kill
			L2_14(L3_15)
		end
	else
		L2_14 = A0_12._fade_out
		if L2_14 then
			L2_14 = A0_12._shrink_fade_out
			if L2_14 then
				L2_14 = A0_12._interpolator
				L3_15 = L2_14
				L2_14 = L2_14.value
				L2_14 = L2_14(L3_15)
				L3_15 = A0_12._size_threshold
				if L2_14 > L3_15 then
					L3_15 = A0_12._texture_width
					L3_15 = L3_15 * L2_14
					L4_16 = A0_12._texture_height
					L4_16 = L4_16 * L2_14
					A0_12._radar_blip_texture:set_size(L3_15, L4_16)
					A0_12._radar_blip_texture:set_center_x(A0_12._fade_out_x)
					A0_12._radar_blip_texture:set_center_y(A0_12._fade_out_y)
				else
					L4_16 = A0_12
					L3_15 = A0_12.set_alpha
					L3_15(L4_16, 0)
				end
			end
		else
			L2_14 = A0_12._interpolator
			L3_15 = L2_14
			L2_14 = L2_14.value
			L2_14 = L2_14(L3_15)
			L4_16 = A0_12
			L3_15 = A0_12.set_alpha
			L3_15(L4_16, L2_14)
		end
	end
end
function RadarBlip.set_alpha(A0_17, A1_18)
	local L3_19
	A0_17._alpha = A1_18
	L3_19 = A0_17._radar_blip_texture
	L3_19 = L3_19.set_color
	L3_19(L3_19, A0_17._color:with_alpha(A1_18 * tweak_data.machine.hud.MAIN_ALPHA))
end
function RadarBlip.update_position(A0_20, A1_21, A2_22)
	A0_20._x = A1_21
	A0_20._y = A2_22
end
function RadarBlip.hit_by_radar_line(A0_23, A1_24, A2_25)
	local L3_26, L4_27
	L3_26 = {}
	L4_27 = {}
	for 