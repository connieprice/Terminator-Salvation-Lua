require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
core:require_module("CoreColorPickerDialog")
CoreOverlayFXCutsceneKey = CoreOverlayFXCutsceneKey or class(CoreCutsceneKeyBase)
CoreOverlayFXCutsceneKey.ELEMENT_NAME = "overlay_fx"
CoreOverlayFXCutsceneKey.NAME = "Overlay Effect"
CoreOverlayFXCutsceneKey.VALID_BLEND_MODES = {"normal", "add"}
CoreOverlayFXCutsceneKey:register_serialized_attribute("blend_mode", CoreOverlayFXCutsceneKey.VALID_BLEND_MODES[1])
CoreOverlayFXCutsceneKey:register_serialized_attribute("color", Color.white, CoreCutsceneKeyBase.string_to_color)
CoreOverlayFXCutsceneKey:register_serialized_attribute("fade_in", 0, tonumber)
CoreOverlayFXCutsceneKey:register_serialized_attribute("sustain", 0, tonumber)
CoreOverlayFXCutsceneKey:register_serialized_attribute("fade_out", 0, tonumber)
CoreOverlayFXCutsceneKey.control_for_blend_mode = CoreCutsceneKeyBase.standard_combo_box_control
CoreOverlayFXCutsceneKey.refresh_control_for_blend_mode = CoreCutsceneKeyBase:standard_combo_box_control_refresh("blend_mode", CoreOverlayFXCutsceneKey.VALID_BLEND_MODES)
function CoreOverlayFXCutsceneKey.__tostring(A0_0)
	local L1_1
	L1_1 = "Trigger overlay effect."
	return L1_1
end
function CoreOverlayFXCutsceneKey.preroll(A0_2, A1_3)
	local L2_4
	L2_4 = A0_2.fade_in
	L2_4 = L2_4(A0_2)
	if L2_4 == 0 then
		L2_4 = A0_2._effect_data
		L2_4 = L2_4(A0_2)
		L2_4.fade_in = 0
		L2_4.sustain = nil
		L2_4.fade_out = 0
		managers.cutscene:play_overlay_effect(L2_4)
	end
end
function CoreOverlayFXCutsceneKey.skip(A0_5, A1_6)
	local L2_7, L3_8, L4_9, L5_10
	L3_8 = A0_5
	L2_7 = A0_5.time
	L2_7 = L2_7(L3_8)
	L4_9 = A0_5
	L3_8 = A0_5.fade_in
	L3_8 = L3_8(L4_9)
	L2_7 = L2_7 + L3_8
	L4_9 = A0_5
	L3_8 = A0_5.sustain
	L3_8 = L3_8(L4_9)
	L3_8 = L2_7 + L3_8
	L5_10 = A1_6
	L4_9 = A1_6.cutscene_duration
	L4_9 = L4_9(L5_10)
	if L2_7 <= L4_9 and L3_8 >= L4_9 then
		L5_10 = A0_5._effect_data
		L5_10 = L5_10(A0_5)
		L5_10.fade_in = 0
		L5_10.sustain = math.max(L3_8 - L4_9, 0)
		managers.cutscene:play_overlay_effect(L5_10)
	end
end
function CoreOverlayFXCutsceneKey.evaluate(A0_11, A1_12, A2_13)
	local L3_14
	L3_14 = table
	L3_14 = L3_14.remap
	L3_14 = L3_14(A0_11:attribute_names(), function(A0_15, A1_16)
		local L2_17
		L2_17 = A1_16
		return L2_17, _UPVALUE0_:attribute_value(A1_16)
	end)
	managers.cutscene:play_overlay_effect(L3_14)
end
function CoreOverlayFXCutsceneKey.revert(A0_18, A1_19)
	A0_18:_stop()
end
function CoreOverlayFXCutsceneKey.update_gui(A0_20, A1_21, A2_22, A3_23)
	if A0_20.__color_picker_dialog then
		A0_20.__color_picker_dialog:update(A1_21, A2_22)
	end
end
function CoreOverlayFXCutsceneKey.is_valid_blend_mode(A0_24, A1_25)
	return table.contains(A0_24.VALID_BLEND_MODES, A1_25)
end
function CoreOverlayFXCutsceneKey.is_valid_fade_in(A0_26, A1_27)
	local L2_28
	L2_28 = A1_27 >= 0
	return L2_28
end
function CoreOverlayFXCutsceneKey.is_valid_sustain(A0_29, A1_30)
	local L2_31
	L2_31 = A1_30 >= 0
	return L2_31
end
function CoreOverlayFXCutsceneKey.is_valid_fade_out(A0_32, A1_33)
	local L2_34
	L2_34 = A1_33 >= 0
	return L2_34
end
function CoreOverlayFXCutsceneKey.control_for_color(A0_35, A1_36)
	local L2_37
	L2_37 = EWS
	L2_37 = L2_37.ColorWell
	L2_37 = L2_37(L2_37, A1_36, "")
	L2_37:set_tool_tip("Open Color Picker")
	L2_37:set_background_colour(255, 20, 255)
	L2_37:set_color(A0_35:color())
	L2_37:connect("EVT_LEFT_UP", callback(A0_35, A0_35, "_on_pick_color"), L2_37)
	return L2_37
end
function CoreOverlayFXCutsceneKey._on_pick_color(A0_38, A1_39)
	local L2_40
	L2_40 = A0_38.__color_picker_dialog
	if L2_40 == nil then
		L2_40 = A0_38._top_level_window
		L2_40 = L2_40(A0_38, A1_39)
		A0_38.__color_picker_dialog = CoreColorPickerDialog.ColorPickerDialog:new(L2_40, true, "HORIZONTAL", true)
		A0_38.__color_picker_dialog:connect("EVT_CLOSE_WINDOW", function()
			local L1_41
			L1_41 = _UPVALUE0_
			L1_41.__color_picker_dialog = nil
		end)
		A0_38.__color_picker_dialog:connect("EVT_COLOR_CHANGED", function()
			local L0_42
			L0_42 = _UPVALUE0_
			L0_42 = L0_42.__color_picker_dialog
			L0_42 = L0_42.color
			L0_42 = L0_42(L0_42)
			_UPVALUE1_:set_color(L0_42)
			_UPVALUE0_:set_color(L0_42)
		end)
		A0_38.__color_picker_dialog:center(L2_40)
		A0_38.__color_picker_dialog:set_color(A0_38:color())
		A0_38.__color_picker_dialog:set_visible(true)
	end
end
function CoreOverlayFXCutsceneKey._effect_data(A0_43)
	return table.remap(A0_43:attribute_names(), function(A0_44, A1_45)
		local L2_46
		L2_46 = A1_45
		return L2_46, _UPVALUE0_:attribute_value(A1_45)
	end)
end
function CoreOverlayFXCutsceneKey._stop(A0_47)
	managers.cutscene:stop_overlay_effect()
end
function CoreOverlayFXCutsceneKey._top_level_window(A0_48, A1_49)
	return (type_name(A1_49) == "EWSFrame" or type_name(A1_49) == "EWSDialog") and A1_49 or A0_48:_top_level_window(assert(A1_49:parent()))
end
