core:module("CoreSubtitlePresenter")
core:require_module("CoreClass")
core:require_module("CoreCode")
core:require_module("CoreEvent")
core:require_module("CoreDebug")
core:require_module("CoreSubtitleSequence")
SubtitlePresenter = SubtitlePresenter or CoreClass.class()
DebugPresenter = DebugPresenter or CoreClass.class(SubtitlePresenter)
OverlayPresenter = OverlayPresenter or CoreClass.class(SubtitlePresenter)
function SubtitlePresenter.destroy(A0_0)
	local L1_1
end
function SubtitlePresenter.update(A0_2, A1_3, A2_4)
end
function SubtitlePresenter.show(A0_5)
	local L1_6
end
function SubtitlePresenter.hide(A0_7)
	local L1_8
end
function SubtitlePresenter.show_text(A0_9, A1_10, A2_11)
end
function SubtitlePresenter.preprocess_sequence(A0_12, A1_13)
	return A1_13
end
function DebugPresenter.destroy(A0_14)
	local L2_15
	L2_15 = CoreDebug
	L2_15 = L2_15.cat_print
	L2_15("debug", string.format("SubtitlePresenter is destroyed."))
end
function DebugPresenter.show(A0_16)
	local L2_17
	L2_17 = CoreDebug
	L2_17 = L2_17.cat_print
	L2_17("debug", string.format("SubtitlePresenter is shown."))
end
function DebugPresenter.hide(A0_18)
	local L2_19
	L2_19 = CoreDebug
	L2_19 = L2_19.cat_print
	L2_19("debug", string.format("SubtitlePresenter hides."))
end
function DebugPresenter.show_text(A0_20, A1_21, A2_22)
	local L4_23
	L4_23 = CoreDebug
	L4_23 = L4_23.cat_print
	L4_23("debug", string.format("SubtitlePresenter displays \"%s\" %s.", A1_21, A2_22 and string.format("for %g seconds", A2_22) or "until further notice"))
end
function OverlayPresenter.init(A0_24, A1_25, A2_26)
	A0_24:set_font(A1_25 or A0_24:_default_font_name(), A2_26 or A0_24:_default_font_size())
	A0_24:_clear_workspace()
	A0_24.__resolution_changed_id = managers.viewport:add_resolution_changed_func(CoreEvent.callback(A0_24, A0_24, "_on_resolution_changed"))
end
function OverlayPresenter.destroy(A0_27)
	if A0_27.__resolution_changed_id and managers.viewport then
		managers.viewport:remove_resolution_changed_func(A0_27.__resolution_changed_id)
	end
	A0_27.__resolution_changed_id = nil
	if CoreCode.alive(A0_27.__subtitle_panel) then
		A0_27.__subtitle_panel:stop()
		A0_27.__subtitle_panel:clear()
	end
	A0_27.__subtitle_panel = nil
	if CoreCode.alive(A0_27.__ws) then
		A0_27.__ws:gui():destroy_workspace(A0_27.__ws)
	end
	A0_27.__ws = nil
end
function OverlayPresenter.show(A0_28)
	A0_28.__ws:show()
end
function OverlayPresenter.hide(A0_29)
	A0_29.__ws:hide()
end
function OverlayPresenter.set_debug(A0_30, A1_31)
	if A0_30.__ws then
		A0_30.__ws:panel():set_debug(A1_31)
	end
end
function OverlayPresenter.set_font(A0_32, A1_33, A2_34)
	local L3_35, L4_36, L5_37, L6_38, L7_39
	A0_32.__font_name = L3_35
	A0_32.__font_size = L3_35
	L3_35(L4_36, L5_37)
	if L3_35 then
		L6_38 = "label"
		L7_39 = "shadow"
		for L6_38, L7_39 in L3_35(L4_36) do
			if A0_32.__subtitle_panel:child(L7_39) then
				A0_32.__subtitle_panel:child(L7_39):set_font(A0_32.__font_name)
				A0_32.__subtitle_panel:child(L7_39):set_font_size(A0_32.__font_size)
			end
		end
	end
end
function OverlayPresenter.set_width(A0_40, A1_41)
	local L2_42, L3_43
	L2_42 = managers
	L2_42 = L2_42.viewport
	L3_43 = L2_42
	L2_42 = L2_42.get_safe_rect
	L2_42 = L2_42(L3_43)
	L3_43 = A0_40._gui_width
	L3_43 = L3_43(A0_40)
	L3_43 = L3_43 * L2_42.width
	A0_40.__width = math.min(A1_41, L3_43)
	if CoreCode.alive(A0_40.__subtitle_panel) then
		A0_40:_layout_text_field():set_width(A0_40.__width)
	end
end
function OverlayPresenter.show_text(A0_44, A1_45, A2_46)
	(A0_44.__subtitle_panel:child("label") or A0_44.__subtitle_panel:text({
		name = "label",
		x = 1,
		y = 1,
		font = A0_44.__font_name,
		font_size = A0_44.__font_size,
		color = Color.white,
		align = "center",
		vertical = "bottom",
		layer = 1,
		wrap = true,
		word_wrap = true
	})):set_text(A1_45)
	;(A0_44.__subtitle_panel:child("shadow") or A0_44.__subtitle_panel:text({
		name = "shadow",
		x = 2,
		y = 2,
		font = A0_44.__font_name,
		font_size = A0_44.__font_size,
		color = Color.black:with_alpha(0.5),
		align = "center",
		vertical = "bottom",
		layer = 0,
		wrap = true,
		word_wrap = true
	})):set_text(A1_45)
end
function OverlayPresenter.preprocess_sequence(A0_47, A1_48)
	local L2_49, L3_50, L4_51, L5_52, L6_53, L7_54, L8_55, L9_56, L10_57, L11_58, L12_59, L13_60, L14_61, L15_62, L16_63, L17_64, L18_65
	L2_49 = CoreSubtitleSequence
	L2_49 = L2_49.SubtitleSequence
	L2_49 = L2_49.new
	L2_49 = L2_49(L3_50)
	L18_65 = L4_51(L5_52)
	for L6_53, L7_54 in L3_50(L4_51, L5_52, L6_53, L7_54, L8_55, L9_56, L10_57, L11_58, L12_59, L13_60, L14_61, L15_62, L16_63, L17_64, L18_65, L4_51(L5_52)) do
		L9_56 = L7_54
		L8_55 = L7_54.string
		L8_55 = L8_55(L9_56)
		L10_57 = A0_47
		L9_56 = A0_47._split_string_into_lines
		L11_58 = L8_55
		L12_59 = A1_48
		L9_56 = L9_56(L10_57, L11_58, L12_59)
		L10_57 = 2
		L11_58 = math
		L11_58 = L11_58.max
		L12_59 = math
		L12_59 = L12_59.ceil
		L13_60 = #L9_56
		L13_60 = L13_60 / L10_57
		L12_59 = L12_59(L13_60)
		L13_60 = 1
		L11_58 = L11_58(L12_59, L13_60)
		L13_60 = L7_54
		L12_59 = L7_54.duration
		L12_59 = L12_59(L13_60)
		L12_59 = L12_59 / L11_58
		L13_60 = 0
		for L17_64 = 1, L11_58 * L10_57, 2 do
			L18_65 = table
			L18_65 = L18_65.concat
			L18_65 = L18_65({
				L9_56[L17_64],
				L9_56[L17_64 + 1]
			}, "\n")
			L2_49:add_subtitle(CoreSubtitleSequence.Subtitle:new(L18_65, L7_54:start_time() + L12_59 * L13_60, L12_59))
			L13_60 = L13_60 + 1
		end
	end
	return L2_49
end
function OverlayPresenter._clear_workspace(A0_66)
	if CoreCode.alive(A0_66.__ws) then
		Overlay:newgui():destroy_workspace(A0_66.__ws)
	end
	A0_66.__ws = Overlay:newgui():create_scaled_screen_workspace(A0_66:_gui_width(), A0_66:_gui_height(), 0, 0, RenderSettings.resolution.x)
	A0_66.__subtitle_panel = A0_66.__ws:panel():panel({layer = 1000})
	A0_66:_on_resolution_changed()
end
function OverlayPresenter._split_string_into_lines(A0_67, A1_68, A2_69)
	return A0_67:_auto_word_wrap_string(A1_68)
end
function OverlayPresenter._auto_word_wrap_string(A0_70, A1_71)
	local L2_72, L3_73, L4_74, L5_75, L6_76, L7_77, L8_78, L9_79, L10_80, L11_81
	L3_73 = A0_70
	L2_72 = A0_70._layout_text_field
	L2_72 = L2_72(L3_73)
	L4_74 = L2_72
	L3_73 = L2_72.set_text
	L3_73(L4_74, L5_75)
	L3_73 = table
	L3_73 = L3_73.collect
	L4_74 = L2_72.line_breaks
	L4_74 = L4_74(L5_75)
	L3_73 = L3_73(L4_74, L5_75)
	L4_74 = {}
	for L8_78 = 1, #L3_73 do
		L9_79 = L3_73[L8_78]
		L10_80 = L8_78 + 1
		L10_80 = L3_73[L10_80]
		L11_81 = utf8
		L11_81 = L11_81.sub
		L11_81 = L11_81(A1_71, L9_79, (L10_80 or 0) - 1)
		table.insert(L4_74, string.trim(L11_81))
	end
	return L4_74
end
function OverlayPresenter._layout_text_field(A0_82)
	assert(A0_82.__subtitle_panel)
	return A0_82.__subtitle_panel:child("layout") or A0_82.__subtitle_panel:text({
		name = "layout",
		width = A0_82.__width,
		visible = false,
		font = A0_82.__font_name,
		font_size = A0_82.__font_size,
		align = "center",
		vertical = "bottom",
		wrap = true,
		word_wrap = true
	})
end
function OverlayPresenter._string_width(A0_83, A1_84)
	(A0_83.__ws:panel():child("string_width") or A0_83.__ws:panel():text({
		name = "string_width",
		visible = false,
		font = A0_83.__font_name,
		font_size = A0_83.__font_size,
		wrap = false
	})):set_text(A1_84)
	return (A0_83.__ws:panel():child("string_width") or A0_83.__ws:panel():text({
		name = "string_width",
		visible = false,
		font = A0_83.__font_name,
		font_size = A0_83.__font_size,
		wrap = false
	})):text_rect()
end
function OverlayPresenter._on_resolution_changed(A0_85)
	local L1_86, L2_87
	L2_87 = A0_85
	L1_86 = A0_85._gui_width
	L1_86 = L1_86(L2_87)
	L2_87 = A0_85._gui_height
	L2_87 = L2_87(A0_85)
	A0_85.__ws:set_screen(L1_86, L2_87, 0, 0, RenderSettings.resolution.x)
	A0_85.__subtitle_panel:set_width(L1_86 * managers.viewport:get_safe_rect().width)
	A0_85.__subtitle_panel:set_height(L2_87 * managers.viewport:get_safe_rect().height)
	A0_85.__subtitle_panel:set_center_x(L1_86 * 0.5)
	A0_85.__subtitle_panel:set_center_y(L2_87 * 0.5)
	A0_85:set_width(A0_85.__width or A0_85:_string_width("The quick brown fox jumped over the lazy dog."))
end
function OverlayPresenter._gui_width(A0_88)
	local L1_89
	L1_89 = RenderSettings
	L1_89 = L1_89.resolution
	L1_89 = L1_89.x
	return L1_89
end
function OverlayPresenter._gui_height(A0_90)
	local L1_91
	L1_91 = RenderSettings
	L1_91 = L1_91.resolution
	return A0_90:_gui_width() / (L1_91.x / L1_91.y)
end
function OverlayPresenter._default_font_name(A0_92)
	local L1_93
	L1_93 = "editor_font"
	return L1_93
end
function OverlayPresenter._default_font_size(A0_94)
	local L1_95
	L1_95 = 22
	return L1_95
end
