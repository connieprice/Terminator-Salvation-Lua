require("units/beings/player/new_gui/HudPanel")
require("units/beings/player/new_gui/HudUtility")
DustPanel = DustPanel or class(HudPanel)
function DustPanel.init(A0_0, A1_1, A2_2)
	HudPanel.init(A0_0, false)
	A0_0:set_low_frequency_update(1)
	A0_0._parent_panel = A1_1
	A0_0._player_unit = A2_2
	A0_0._player_data = A2_2:player_data()
	A0_0._width = A0_0._parent_panel:width()
	A0_0._height = A0_0._parent_panel:height()
	A0_0._center_x = A0_0._width / 2
	A0_0._center_y = A0_0._height / 2
	A0_0._x = 0
	A0_0._y = 0
	A0_0._panel = A0_0._parent_panel:panel({
		name = "dust_panel",
		width = A0_0._width,
		height = A0_0._height,
		valign = "center",
		halign = "center"
	})
	A0_0._panel:set_center(A0_0._center_x, A0_0._center_y)
	A0_0._dust_icon = {}
	A0_0._dust_icon.first_dust = A0_0._panel:bitmap({
		name = "dust_icon",
		texture = "gui_screeneffect_dust_01",
		valign = "center",
		halign = "center"
	})
	A0_0._dust_icon.first_dust:set_size(tweak_data.player.new_hud.dust_panel.FIRST_DUST_TEXTURE_SIZE, tweak_data.player.new_hud.dust_panel.FIRST_DUST_TEXTURE_SIZE)
	A0_0._dust_icon.first_dust:set_center(A0_0._center_x, A0_0._center_y)
	A0_0._dust_icon.second_dust = A0_0._panel:bitmap({
		name = "dust_icon",
		texture = "gui_screeneffect_dust_02",
		valign = "center",
		halign = "center"
	})
	A0_0._dust_icon.second_dust:set_size(tweak_data.player.new_hud.dust_panel.SECOND_DUST_TEXTURE_SIZE, tweak_data.player.new_hud.dust_panel.SECOND_DUST_TEXTURE_SIZE)
	A0_0._dust_icon.second_dust:set_center(A0_0._center_x, A0_0._center_y)
	A0_0._alpha_table = {}
	A0_0._alpha_table.first_dust = 0
	A0_0._alpha_table.second_dust = 0
	A0_0:set_alpha(0, "first_dust")
	A0_0:set_alpha(0, "second_dust")
	A0_0._stay_visible_time = 0
	A0_0._alpha_interpolator = {}
	A0_0._alpha_interpolator.first_dust = Interpolator:new(0, tweak_data.player.new_hud.dust_panel.FADE_IN_SPEED)
	A0_0._alpha_interpolator.first_dust:set_target(0)
	A0_0._alpha_interpolator.second_dust = Interpolator:new(0, tweak_data.player.new_hud.dust_panel.FADE_IN_SPEED)
	A0_0._alpha_interpolator.second_dust:set_target(0)
	A0_0._is_split_screen = HudUtility.is_split_screen()
end
function DustPanel.panel(A0_3)
	local L1_4
	L1_4 = A0_3._panel
	return L1_4
end
function DustPanel.show(A0_5, A1_6)
	A0_5._explosion_direction = A1_6
	A0_5._second_dust_start = tweak_data.player.new_hud.dust_panel.DELAY_BETWEEN_DUSTS
	A0_5:_show("first_dust")
end
function DustPanel._show(A0_7, A1_8)
	local L2_9
	L2_9 = tweak_data
	L2_9 = L2_9.player
	L2_9 = L2_9.new_hud
	L2_9 = L2_9.dust_panel
	L2_9 = L2_9.TIME_BEFORE_FADE_OUT
	A0_7._stay_visible_time = L2_9
	L2_9 = A0_7._alpha_interpolator
	L2_9 = L2_9[A1_8]
	L2_9 = L2_9.set_target
	L2_9(L2_9, 1)
	L2_9 = A0_7._alpha_interpolator
	L2_9 = L2_9[A1_8]
	L2_9 = L2_9.set_speed
	L2_9(L2_9, tweak_data.player.new_hud.dust_panel.FADE_IN_SPEED)
	L2_9 = A0_7._get_explosion_direction_angle
	L2_9 = L2_9(A0_7)
	A0_7:_set_random_position_and_rotation(L2_9, A1_8)
end
function DustPanel._get_random_rotation(A0_10)
	return math.random(360)
end
function DustPanel._get_random_radius(A0_11)
	local L1_12
	if A0_11._is_split_screen then
		L1_12 = math.random(tweak_data.player.new_hud.dust_panel.COOP_RADIUS_VARIATION * 2) - tweak_data.player.new_hud.dust_panel.COOP_RADIUS_VARIATION
	else
		L1_12 = math.random(tweak_data.player.new_hud.dust_panel.RADIUS_VARIATION * 2) - tweak_data.player.new_hud.dust_panel.RADIUS_VARIATION
	end
	return tweak_data.player.new_hud.dust_panel.RADIUS + L1_12
end
function DustPanel._get_random_angle(A0_13, A1_14)
	A1_14 = A1_14 + (math.random(tweak_data.player.new_hud.dust_panel.ANGLE_VARIATION * 2) - tweak_data.player.new_hud.dust_panel.ANGLE_VARIATION)
	return A1_14
end
function DustPanel._set_random_position_and_rotation(A0_15, A1_16, A2_17)
	local L3_18, L4_19, L5_20, L6_21, L7_22
	L4_19 = A0_15
	L3_18 = A0_15._get_random_radius
	L3_18 = L3_18(L4_19)
	L5_20 = A0_15
	L4_19 = A0_15._get_random_rotation
	L4_19 = L4_19(L5_20)
	L6_21 = A0_15
	L5_20 = A0_15._get_random_angle
	L7_22 = A1_16
	L5_20 = L5_20(L6_21, L7_22)
	L6_21 = A0_15._center_x
	L7_22 = math
	L7_22 = L7_22.cos
	L7_22 = L7_22(L5_20 - 90)
	L7_22 = L3_18 * L7_22
	L6_21 = L6_21 + L7_22
	L7_22 = A0_15._center_y
	L7_22 = L7_22 + L3_18 * math.sin(L5_20 - 90)
	if alive(A0_15._dust_icon[A2_17]) then
		if A0_15._is_split_screen then
			A0_15:_randomize_texture(A2_17)
		else
			A0_15._dust_icon[A2_17]:set_rotation(L4_19)
		end
		A0_15._dust_icon[A2_17]:set_center(L6_21, L7_22)
	end
end
function DustPanel._randomize_texture(A0_23, A1_24)
	local L2_25, L3_26
	L2_25 = math
	L2_25 = L2_25.random
	L3_26 = 4
	L2_25 = L2_25(L3_26)
	L3_26 = "gui_screeneffect_dust_01"
	if A1_24 == "second_dust" then
		L3_26 = "gui_screeneffect_dust_02"
	end
	if L2_25 == 1 then
		A0_23._dust_icon[A1_24]:set_image(L3_26, 0, 0, 256, 256)
	elseif L2_25 == 2 then
		A0_23._dust_icon[A1_24]:set_image(L3_26, 256, 0, -256, 256)
	elseif L2_25 == 3 then
		A0_23._dust_icon[A1_24]:set_image(L3_26, 0, 256, 256, -256)
	else
		A0_23._dust_icon[A1_24]:set_image(L3_26, 256, 256, -256, -256)
	end
end
function DustPanel._get_explosion_direction_angle(A0_27)
	local L1_28, L2_29
	L1_28 = A0_27._explosion_direction
	L2_29 = A0_27._player_unit
	L2_29 = L2_29.camera_data
	L2_29 = L2_29(L2_29)
	L2_29 = L2_29.camera_rotation
	L2_29 = L2_29.y
	L2_29 = L2_29(L2_29)
	return Rotation(L2_29, Vector3(0, 0, 1)):roll() - Rotation(L1_28, Vector3(0, 0, 1)):roll() + 180
end
function DustPanel.hide(A0_30)
	if A0_30._stay_visible_time < 0 then
		A0_30._alpha_interpolator.first_dust:set_target(0)
		A0_30._alpha_interpolator.first_dust:set_speed(tweak_data.player.new_hud.dust_panel.FADE_OUT_SPEED)
		A0_30._alpha_interpolator.second_dust:set_target(0)
		A0_30._alpha_interpolator.second_dust:set_speed(tweak_data.player.new_hud.dust_panel.FADE_OUT_SPEED)
	end
end
function DustPanel.visible(A0_31)
	local L1_32
	L1_32 = A0_31._alpha_table
	L1_32 = L1_32.first_dust
	L1_32 = L1_32 > 0 or L1_32 > 0 or L1_32 > 0
	return L1_32
end
function DustPanel.done(A0_33)
	local L1_34
	L1_34 = A0_33._alpha_table
	L1_34 = L1_34.first_dust
	L1_34 = L1_34 > 0.3 or L1_34 > 0.3 or L1_34 > 0
	return L1_34
end
function DustPanel.get_alpha(A0_35)
	local L1_36
	L1_36 = A0_35._alpha
	return L1_36
end
function DustPanel.set_alpha(A0_37, A1_38, A2_39)
	local L3_40
	L3_40 = A0_37._alpha_table
	L3_40[A2_39] = A1_38
	L3_40 = A0_37._dust_icon
	L3_40 = L3_40[A2_39]
	L3_40 = L3_40.set_color
	L3_40(L3_40, A0_37._dust_icon[A2_39]:color():with_alpha(A0_37._alpha_table[A2_39]))
	L3_40 = math
	L3_40 = L3_40.max
	L3_40 = L3_40(A0_37._alpha_table.first_dust, A0_37._alpha_table.second_dust)
	HudPanel.set_alpha(A0_37, L3_40)
end
function DustPanel.set_temp_alpha(A0_41, A1_42, A2_43)
	A0_41._dust_icon[A2_43]:set_color(A0_41._dust_icon[A2_43]:color():with_alpha(A1_42))
	HudPanel.set_alpha(A0_41, 0)
end
function DustPanel.update(A0_44, A1_45, A2_46)
	local L3_47, L4_48, L5_49, L6_50, L7_51, L8_52
	if L3_47 then
		A0_44._second_dust_start = L3_47
		if L3_47 <= 0 then
			L3_47(L4_48, L5_49)
			A0_44._second_dust_start = nil
		end
	end
	A0_44._stay_visible_time = L3_47
	if L3_47 <= 0 then
		L3_47(L4_48)
	end
	for L6_50, L7_51 in L3_47(L4_48) do
		L8_52 = L7_51.update
		L8_52(L7_51, A1_45)
		L8_52 = nil
		if L7_51:has_reached_target() then
			L8_52 = L7_51:target()
		else
			L8_52 = L7_51:value()
		end
		if A2_46 then
			A0_44:set_temp_alpha(0, L6_50)
		else
			A0_44:set_alpha(L8_52, L6_50)
		end
	end
end
