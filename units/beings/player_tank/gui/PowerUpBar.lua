PowerUpBar = PowerUpBar or class()
function PowerUpBar.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	A0_0._panel = A1_1
	A0_0._image = A0_0._panel:bitmap({name = A2_2, texture = A2_2})
	A0_0._image:set_size(A5_5, A6_6)
	A0_0._image:set_lefttop(A3_3, A4_4)
	A0_0._color = tweak_data.machine.hud.HIGHLIGHT_COLOR_TWEAK
	A0_0._alpha_interpolator = Interpolator:new(0, tweak_data.machine.hud.POWER_UP_FADE_IN_SPEED)
end
function PowerUpBar.destroy(A0_7)
	A0_7._panel:remove(A0_7._image)
end
function PowerUpBar.full_activate(A0_8)
	A0_8._alpha_interpolator:set_target(tweak_data.machine.hud.HIGH_ALPHA)
	A0_8._alpha_interpolator:set_speed(tweak_data.machine.hud.POWER_UP_FADE_IN_SPEED)
	A0_8.need_update = true
end
function PowerUpBar.activate(A0_9)
	A0_9._alpha_interpolator:set_target(tweak_data.machine.hud.MAIN_ALPHA)
	A0_9._alpha_interpolator:set_speed(tweak_data.machine.hud.POWER_UP_FADE_IN_SPEED)
	A0_9.need_update = true
end
function PowerUpBar.inactivate(A0_10)
	A0_10._alpha_interpolator:set_target(0.1)
	A0_10._alpha_interpolator:set_speed(tweak_data.machine.hud.POWER_UP_FADE_OUT_SPEED)
	A0_10.need_update = true
end
function PowerUpBar.set_alpha(A0_11, A1_12)
	local L3_13
	A0_11._alpha = A1_12
	L3_13 = A0_11._image
	L3_13 = L3_13.set_color
	L3_13(L3_13, A0_11._color:with_alpha(A1_12))
end
function PowerUpBar.resize(A0_14, A1_15, A2_16)
	A0_14._image:set_size(A1_15, A2_16)
end
function PowerUpBar.update(A0_17, A1_18)
	local L2_19
	L2_19 = A0_17._alpha_interpolator
	L2_19 = L2_19.has_reached_target
	L2_19 = L2_19(L2_19)
	if L2_19 then
		A0_17.need_update = false
	else
		L2_19 = A0_17._alpha_interpolator
		L2_19 = L2_19.update
		L2_19(L2_19, A1_18)
		L2_19 = A0_17._alpha_interpolator
		L2_19 = L2_19.value
		L2_19 = L2_19(L2_19)
		A0_17:set_alpha(L2_19)
		A0_17.need_update = true
	end
end
function PowerUpBar.show(A0_20)
	A0_20:set_alpha(A0_20._alpha)
end
