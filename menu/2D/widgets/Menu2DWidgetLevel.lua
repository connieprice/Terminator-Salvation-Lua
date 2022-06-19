require("menu/2D/widgets/Menu2DWidgetBase.lua")
Menu2DWidgetLevel = Menu2DWidgetLevel or class(Menu2DWidgetBase)
Menu2DWidgetLevel._bmp_inactive_alpha = 0.3
Menu2DWidgetLevel._text_inactive_alpha = 0.6
function Menu2DWidgetLevel.init(A0_0, A1_1)
	Menu2DWidgetBase.init(A0_0, A1_1)
end
function Menu2DWidgetLevel.parse(A0_2, A1_3)
	local L2_4
	L2_4 = A0_2._params
	L2_4.x = tonumber(A1_3.x)
	L2_4 = A0_2._params
	L2_4.y = tonumber(A1_3.y)
end
function Menu2DWidgetLevel.update(A0_5, A1_6)
	if A0_5._level_text_animation then
		A0_5._level_text_animation:update(A1_6)
	end
	if A0_5._bmp_animation then
		A0_5._bmp_animation:update(A1_6)
	end
end
function Menu2DWidgetLevel.texture(A0_7)
	local L1_8
	L1_8 = A0_7._bmp
	return L1_8
end
function Menu2DWidgetLevel.create_gui(A0_9)
	Menu2DWidgetBase.create_gui(A0_9)
	A0_9._panel = A0_9._params.panel:panel({
		height = A0_9._params.panel:height() * tweak_data.menu2d.widgets.level_spacing,
		layer = tweak_data.menu2d.layer_normal
	})
	A0_9._level = A0_9._panel:text({
		color = tweak_data.menu2d.widgets.level_text_color,
		font = "faith_font_22",
		font_scale = 0.6,
		x = 6,
		y = A0_9._panel:h() - tweak_data.menu2d.resume_level_font_size * 3 + 10,
		height = tweak_data.menu2d.resume_level_font_size + 2,
		align = "left",
		text = A0_9._params.level,
		layer = tweak_data.menu2d.layer_normal + 3
	})
	A0_9._bmp = A0_9._panel:bitmap({
		texture = A0_9._params.texture,
		x = 0,
		width = 256,
		height = 256,
		layer = tweak_data.menu2d.layer_normal + 1
	})
	A0_9._gradient = A0_9._panel:rect({
		x = 0,
		y = A0_9._panel:h() - tweak_data.menu2d.resume_level_font_size * 3 + 6,
		height = tweak_data.menu2d.resume_level_font_size + 3,
		width = 256,
		color = Color(0.6, 0, 0, 0),
		layer = tweak_data.menu2d.layer_normal + 2
	})
	if A0_9._bmp:texture_width() == 0 then
		A0_9._bmp:set_image("gui_resumegame_level_1")
	end
end
function Menu2DWidgetLevel.set_active(A0_10, A1_11)
	A0_10._active = true
	A0_10._level:set_color(tweak_data.menu2d.normal_menu.choice_text_color_active)
	A0_10._level_text_animation = Menu2DFadeInAnimation:new(A0_10._level, 0, 0.25, 1)
	A0_10._bmp_animation = Menu2DFadeInAnimation:new(A0_10._bmp, 0, 0.25, 1)
end
function Menu2DWidgetLevel.set_inactive(A0_12, A1_13)
	A0_12._active = false
	A0_12._level:set_color(tweak_data.menu2d.widgets.level_text_color)
	A0_12._level_text_animation = Menu2DFadeOutAnimation:new(A0_12._level, 0, 0.25, 0.3)
	A0_12._bmp_animation = Menu2DFadeOutAnimation:new(A0_12._bmp, 0, 0.25, A0_12._bmp_inactive_alpha)
end
function Menu2DWidgetLevel.destroy(A0_14)
	local L1_15
end
function Menu2DWidgetLevel.height(A0_16)
	local L1_17, L2_18
	L1_17 = tweak_data
	L1_17 = L1_17.menu2d
	L2_18 = L1_17.resume_level_font_size
	L2_18 = L2_18 * 2
	L2_18 = L2_18 + L1_17.resume_level_bmp_height
	return L2_18
end
function Menu2DWidgetLevel.animate(A0_19, A1_20, A2_21)
	local L3_22, L4_23, L5_24
	L3_22 = A2_21[1]
	L4_23 = A2_21[2]
	L5_24 = A2_21[3]
	if A1_20 == "fade_in" then
		if A0_19._active == true then
			L5_24 = 1
		else
			L5_24 = A0_19._bmp_inactive_alpha
		end
		A0_19._level:set_color(A0_19._level:color():with_alpha(0))
		A0_19._bmp:set_color(A0_19._bmp:color():with_alpha(0))
		A0_19._level_text_animation = Menu2DFadeInAnimation:new(A0_19._level, L3_22, L4_23, L5_24)
		A0_19._bmp_animation = Menu2DFadeInAnimation:new(A0_19._bmp, L3_22, L4_23, L5_24)
	elseif A1_20 == "fade_out" then
		A0_19._level_text_animation = Menu2DFadeOutAnimation:new(A0_19._level, L3_22, L4_23, L5_24)
		A0_19._bmp_animation = Menu2DFadeOutAnimation:new(A0_19._bmp, L3_22, L4_23, L5_24)
	end
end
function Menu2DWidgetLevel.confirm_mode(A0_25)
	local L1_26
	L1_26 = "confirm"
	return L1_26
end
function Menu2DWidgetLevel.mouse_input(A0_27, A1_28)
end
