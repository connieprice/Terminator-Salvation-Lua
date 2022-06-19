require("menu/2D/Menu2DPage")
Menu2DPageStart = Menu2DPageStart or class(Menu2DPage)
function Menu2DPageStart.init(A0_0, A1_1, A2_2)
	Menu2DPage.init(A0_0, A1_1, A2_2)
end
function Menu2DPageStart.parse(A0_3, A1_4)
	A0_3._name = A1_4:parameter("name")
	A0_3._goto = A1_4:parameter("goto_page")
end
function Menu2DPageStart.open(A0_5, A1_6)
	A0_5._shows_press_start = false
	Menu2DPage.open(A0_5, A1_6, true, tweak_data.menu2d.layer_title)
	A0_5._bg = A0_5._root_panel:rect({layer = 1})
	A0_5._press_start = A0_5._panel:text({
		text = managers.localization:text("menu_press_any_button"),
		font = "faith_font_22",
		color = Color(1, 1, 1, 1),
		halign = "center",
		valign = "center",
		align = "center",
		width = A0_5._panel:w(),
		height = tweak_data.menu2d.press_start_font_size * 2,
		x = 0,
		y = A0_5._panel:height() * 0.5 + 150,
		layer = 10
	})
	A0_5:show()
	if A0_5._shown then
		A0_5._press_start:set_color(Color.white:with_alpha(0))
		A0_5._bg:set_color(Color.black:with_alpha(0))
		A0_5:animate_in_reverse()
	else
		A0_5._shown = true
		A0_5._press_start:set_color(Color.white:with_alpha(0))
		A0_5._bg:set_color(Color.black)
		A0_5:animate_in_first_time()
	end
	A0_5._next_burst_start = tweak_data.menu2d.title_press_start_wait + tweak_data.menu2d.title_animation_speed_in
	A0_5._shown = true
	managers.menu2d:logo():start("title")
end
function Menu2DPageStart.close(A0_7)
	Menu2DPage.close(A0_7)
	managers.menu2d:logo():stop()
end
function Menu2DPageStart.destroy(A0_8)
	Menu2DPage.destroy(A0_8)
	A0_8._root_panel:remove(A0_8._bg)
end
function Menu2DPageStart.update(A0_9, A1_10)
	Menu2DPage.update(A0_9, A1_10)
	A0_9:animation_done()
	if A0_9._next_burst_start < TimerManager:main():time() then
		managers.menu2d:distortion_burst(A1_10, A0_9._next_burst_length)
		managers.menu2d:logo_twitch(A0_9._next_burst_length)
		A0_9._next_burst_length = math.rand(tweak_data.menu2d.distortion.min_distortion_burst_time, tweak_data.menu2d.distortion.max_distortion_burst_time)
		A0_9._next_burst_start = TimerManager:main():time() + A0_9._next_burst_length + math.rand(tweak_data.menu2d.distortion.min_distortion_burst_interval, tweak_data.menu2d.distortion.max_distortion_burst_interval)
	end
	if not managers.save:has_primary_user() then
		A0_9:_show_press_start()
	else
		A0_9:_hide_press_start()
	end
end
function Menu2DPageStart.set_transition(A0_11, A1_12)
	Menu2DPage.set_transition(A0_11, A1_12)
	A0_11:animate_out()
end
function Menu2DPageStart._transition(A0_13)
	local L1_14
	L1_14 = A0_13._in_transition
	if L1_14 == "out" then
		L1_14 = A0_13._transition_timer
		if L1_14 < 0 then
			L1_14 = true
			return L1_14
		end
	else
		L1_14 = A0_13._transition_timer
		if L1_14 then
			L1_14 = A0_13._transition_timer
			L1_14 = L1_14 - TimerManager:main():delta_time()
			A0_13._transition_timer = L1_14
		end
	end
end
function Menu2DPageStart.advance(A0_15)
	local L1_16
end
function Menu2DPageStart.animate_in_first_time(A0_17)
	A0_17._animations = {}
	A0_17._in_transition = "in"
	A0_17:_show_press_start(tweak_data.menu2d.title_press_start_wait)
	A0_17._bg:animate(Menu2DAnimations.fade_in, 0, tweak_data.menu2d.bg_fade_speed, tweak_data.menu2d.bg_alpha)
	A0_17._active = false
end
function Menu2DPageStart.animate_in_reverse(A0_18)
	local L1_19
	L1_19 = {}
	A0_18._animations = L1_19
	A0_18._in_transition = "in"
	L1_19 = tweak_data
	L1_19 = L1_19.menu2d
	L1_19 = L1_19.reverse_speed
	L1_19 = 1 / L1_19
	A0_18:_show_press_start(tweak_data.menu2d.press_start_revers_wait)
	table.insert(A0_18._animations, A0_18._bg:animate(Menu2DAnimations.fade_in, 0, tweak_data.menu2d.bg_fade_speed * L1_19, tweak_data.menu2d.bg_alpha))
	A0_18._bg:animate(Menu2DAnimations.fade_in, 0, tweak_data.menu2d.bg_fade_speed * L1_19, tweak_data.menu2d.bg_alpha)
	A0_18._active = false
end
function Menu2DPageStart.animate_out(A0_20)
	A0_20._animations = {}
	A0_20._in_transition = "out"
	A0_20._transition_timer = 0.1
	A0_20:_hide_press_start()
	table.insert(A0_20._animations, A0_20._bg:animate(Menu2DAnimations.fade_out, tweak_data.menu2d.bg_wait_fade, tweak_data.menu2d.bg_fade_speed, 0))
end
function Menu2DPageStart.animate_active(A0_21)
	A0_21._press_start:stop()
	A0_21._press_start:animate(Menu2DAnimations.pulse, tweak_data.menu2d.press_start_pulse_speed, tweak_data.menu2d.press_start_pulse_low_alpha, tweak_data.menu2d.press_start_pulse_high_alpha, tweak_data.menu2d.press_start_pulse_wait)
	A0_21._active = true
end
function Menu2DPageStart.animation_done(A0_22)
	local L1_23, L2_24, L3_25, L4_26, L5_27, L6_28
	L1_23 = A0_22._animations
	L1_23 = #L1_23
	if L1_23 > 0 then
		L1_23 = {}
		for L5_27, L6_28 in L2_24(L3_25) do
			if coroutine.status(L6_28) ~= "running" and coroutine.status(L6_28) ~= "suspended" then
				table.insert(L1_23, L5_27)
			end
		end
		for L5_27 = #L1_23, 1, -1 do
			L6_28 = table
			L6_28 = L6_28.remove
			L6_28(A0_22._animations, L1_23[L5_27])
		end
	else
		L1_23 = A0_22._active
		if not L1_23 then
			L1_23 = A0_22.animate_active
			L1_23(L2_24)
		else
			L1_23 = A0_22._in_transition
			if L1_23 == "out" then
				A0_22._animating_out = nil
			end
			A0_22._in_transition = nil
			L1_23 = true
			return L1_23
		end
	end
end
function Menu2DPageStart._show_press_start(A0_29, A1_30)
	local L2_31, L3_32
	L2_31 = A0_29._shows_press_start
	if not L2_31 then
		A1_30 = A1_30 or 0
		L2_31 = table
		L2_31 = L2_31.insert
		L3_32 = A0_29._animations
		L2_31(L3_32, A0_29._press_start:animate(Menu2DAnimations.fade_in, A1_30, tweak_data.menu2d.press_start_fade_in))
		A0_29._shows_press_start = true
	end
end
function Menu2DPageStart._hide_press_start(A0_33)
	if A0_33._shows_press_start then
		A0_33._press_start:stop()
		table.insert(A0_33._animations, A0_33._press_start:animate(Menu2DAnimations.fade_out, 0, tweak_data.menu2d.press_start_fade_out, 0))
		A0_33._shows_press_start = false
	end
end
