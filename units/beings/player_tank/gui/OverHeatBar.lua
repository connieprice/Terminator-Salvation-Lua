require("shared/FiniteStateMachine")
OverHeatBar = OverHeatBar or class()
function OverHeatBar.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	A0_0._panel = A1_1
	A0_0._y = A4_4
	A0_0._x = A3_3
	A0_0._texture = A0_0._panel:bitmap({name = A2_2, texture = A2_2})
	A0_0._texture:set_lefttop(A3_3, A4_4)
	A0_0._height_interpolator = Interpolator:new(0, tweak_data.machine.hud.OVERHEAT_GROW_SPEED)
	A0_0._color = A6_6 or A0_0._texture:color()
	A0_0._texture_color = A0_0._color
	A0_0._main_alpha = A5_5 or 1
	A0_0:set_alpha(0)
end
function OverHeatBar.set_image_height(A0_7, A1_8)
	A0_7._image_height = A1_8
end
function OverHeatBar.set_texture_size(A0_9, A1_10)
	A0_9._texture_size = A1_10
end
function OverHeatBar.set_image_width(A0_11, A1_12)
	A0_11._texture_size = A1_12
end
function OverHeatBar.destroy(A0_13)
	A0_13._panel:remove(A0_13._texture)
end
function OverHeatBar.activate(A0_14)
	A0_14._height_interpolator:set_target(2)
	A0_14._height_interpolator:set_speed(tweak_data.machine.hud.OVERHEAT_GROW_SPEED)
end
function OverHeatBar.inactivate(A0_15)
	A0_15._height_interpolator:set_target(0.1)
	A0_15._height_interpolator:set_speed(tweak_data.machine.hud.OVERHEAT_SHRINK_SPEED)
end
function OverHeatBar.set_alpha(A0_16, A1_17)
	local L3_18
	L3_18 = A0_16._texture
	L3_18 = L3_18.set_color
	L3_18(L3_18, A0_16._texture_color:with_alpha(A1_17 * A0_16._main_alpha))
end
function OverHeatBar.set_red_alpha(A0_19, A1_20)
	local L2_21
	L2_21 = Color
	L2_21 = L2_21(1, 1 - A1_20, 1 - A1_20)
	L2_21 = L2_21 * A0_19._texture_color
	A0_19._texture:set_color(L2_21)
end
function OverHeatBar.set_y_position(A0_22, A1_23)
	A0_22._y = pos_y
	A0_22._texture:set_lefttop(pos_x, pos_y)
end
function OverHeatBar.update(A0_24, A1_25)
	local L2_26
	L2_26 = A0_24._height_interpolator
	L2_26 = L2_26.has_reached_target
	L2_26 = L2_26(L2_26)
	if not L2_26 then
		L2_26 = A0_24._height_interpolator
		L2_26 = L2_26.update
		L2_26(L2_26, A1_25)
		L2_26 = A0_24._height_interpolator
		L2_26 = L2_26.value
		L2_26 = L2_26(L2_26)
		A0_24:_resize_and_reposition(L2_26)
	end
end
function OverHeatBar._resize_and_reposition(A0_27, A1_28)
	local L2_29
	L2_29 = A0_27._texture_size
	L2_29 = L2_29 * A1_28
	A0_27._texture:set_size(A0_27._texture_size, L2_29)
	A0_27._texture:set_center_y(A0_27._y)
end
