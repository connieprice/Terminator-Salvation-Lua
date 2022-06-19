require("menu/2D/widgets/Menu2DWidgetBase.lua")
if not Menu2DWidgetLevel then
	Menu2DWidgetLevel = class(Menu2DWidgetBase)
end
Menu2DWidgetLevel._bmp_inactive_alpha = 0.3
Menu2DWidgetLevel._text_inactive_alpha = 0.6
Menu2DWidgetLevel.init = function(l_1_0, l_1_1)
	Menu2DWidgetBase.init(l_1_0, l_1_1)
end

Menu2DWidgetLevel.parse = function(l_2_0, l_2_1)
	l_2_0._params.x = tonumber(l_2_1.x)
	l_2_0._params.y = tonumber(l_2_1.y)
end

Menu2DWidgetLevel.update = function(l_3_0, l_3_1)
	if l_3_0._level_text_animation then
		l_3_0._level_text_animation:update(l_3_1)
	end
	if l_3_0._bmp_animation then
		l_3_0._bmp_animation:update(l_3_1)
	end
end

Menu2DWidgetLevel.texture = function(l_4_0)
	return l_4_0._bmp
end

Menu2DWidgetLevel.create_gui = function(l_5_0)
	Menu2DWidgetBase.create_gui(l_5_0)
	local l_5_1, l_5_2 = l_5_0._params.panel:panel, l_5_0._params.panel
	local l_5_3 = {}
	l_5_3.height = l_5_0._params.panel:height() * tweak_data.menu2d.widgets.level_spacing
	l_5_3.layer = tweak_data.menu2d.layer_normal
	l_5_1 = l_5_1(l_5_2, l_5_3)
	l_5_0._panel = l_5_1
	l_5_1 = tweak_data
	l_5_1 = l_5_1.menu2d
	l_5_1 = l_5_1.resume_level_font_size
	l_5_2 = l_5_0._panel
	l_5_2, l_5_3 = l_5_2:text, l_5_2
	local l_5_4 = {}
	l_5_4.color = tweak_data.menu2d.widgets.level_text_color
	l_5_4.font = "faith_font_22"
	l_5_4.font_scale = 0.6
	l_5_4.x = 6
	l_5_4.y = l_5_0._panel:h() - l_5_1 * 3 + 10
	l_5_4.height = l_5_1 + 2
	l_5_4.align = "left"
	l_5_4.text = l_5_0._params.level
	l_5_4.layer = tweak_data.menu2d.layer_normal + 3
	l_5_2 = l_5_2(l_5_3, l_5_4)
	l_5_0._level = l_5_2
	l_5_2 = l_5_0._panel
	l_5_2, l_5_3 = l_5_2:bitmap, l_5_2
	l_5_2, l_5_4 = l_5_2(l_5_3, l_5_4), {texture = l_5_0._params.texture, x = 0, width = 256, height = 256, layer = tweak_data.menu2d.layer_normal + 1}
	l_5_0._bmp = l_5_2
	l_5_2 = l_5_0._panel
	l_5_2, l_5_3 = l_5_2:rect, l_5_2
	l_5_2, l_5_4 = l_5_2(l_5_3, l_5_4), {x = 0, y = l_5_0._panel:h() - l_5_1 * 3 + 6, height = l_5_1 + 3, width = 256, color = Color(0.6, 0, 0, 0), layer = tweak_data.menu2d.layer_normal + 2}
	l_5_0._gradient = l_5_2
	l_5_2 = l_5_0._bmp
	l_5_2, l_5_3 = l_5_2:texture_width, l_5_2
	l_5_2 = l_5_2(l_5_3)
	if l_5_2 == 0 then
		l_5_2 = l_5_0._bmp
		l_5_2, l_5_3 = l_5_2:set_image, l_5_2
		l_5_4 = "gui_resumegame_level_1"
		l_5_2(l_5_3, l_5_4)
	end
	l_5_2 = l_5_0._panel
	l_5_2, l_5_3 = l_5_2:height, l_5_2
	l_5_2 = l_5_2(l_5_3)
	l_5_3 = l_5_0._bmp
	l_5_3, l_5_4 = l_5_3:texture_height, l_5_3
	l_5_3 = l_5_3(l_5_4)
	l_5_2 = l_5_2 / l_5_3
end

Menu2DWidgetLevel.set_active = function(l_6_0, l_6_1)
	l_6_0._active = true
	l_6_0._level:set_color(tweak_data.menu2d.normal_menu.choice_text_color_active)
	l_6_0._level_text_animation = Menu2DFadeInAnimation:new(l_6_0._level, 0, 0.25, 1)
	l_6_0._bmp_animation = Menu2DFadeInAnimation:new(l_6_0._bmp, 0, 0.25, 1)
end

Menu2DWidgetLevel.set_inactive = function(l_7_0, l_7_1)
	l_7_0._active = false
	l_7_0._level:set_color(tweak_data.menu2d.widgets.level_text_color)
	l_7_0._level_text_animation = Menu2DFadeOutAnimation:new(l_7_0._level, 0, 0.25, 0.3)
	l_7_0._bmp_animation = Menu2DFadeOutAnimation:new(l_7_0._bmp, 0, 0.25, l_7_0._bmp_inactive_alpha)
end

Menu2DWidgetLevel.destroy = function(l_8_0)
end

Menu2DWidgetLevel.height = function(l_9_0)
	local l_9_1 = tweak_data.menu2d
	return l_9_1.resume_level_font_size * 2 + l_9_1.resume_level_bmp_height
end

Menu2DWidgetLevel.animate = function(l_10_0, l_10_1, l_10_2)
	local l_10_3 = l_10_2[1]
	local l_10_4 = l_10_2[2]
	local l_10_5 = l_10_2[3]
	if l_10_1 == "fade_in" then
		if l_10_0._active == true then
			l_10_5 = 1
		else
			l_10_5 = l_10_0._bmp_inactive_alpha
		end
		l_10_0._level:set_color(l_10_0._level:color():with_alpha(0))
		l_10_0._bmp:set_color(l_10_0._bmp:color():with_alpha(0))
		l_10_0._level_text_animation = Menu2DFadeInAnimation:new(l_10_0._level, l_10_3, l_10_4, l_10_5)
		l_10_0._bmp_animation = Menu2DFadeInAnimation:new(l_10_0._bmp, l_10_3, l_10_4, l_10_5)
	elseif l_10_1 == "fade_out" then
		l_10_0._level_text_animation = Menu2DFadeOutAnimation:new(l_10_0._level, l_10_3, l_10_4, l_10_5)
		l_10_0._bmp_animation = Menu2DFadeOutAnimation:new(l_10_0._bmp, l_10_3, l_10_4, l_10_5)
	end
end

Menu2DWidgetLevel.confirm_mode = function(l_11_0)
	return "confirm"
end

Menu2DWidgetLevel.mouse_input = function(l_12_0, l_12_1)
end


