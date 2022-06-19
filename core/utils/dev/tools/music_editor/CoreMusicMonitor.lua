core:module("CoreMusicMonitor")
core:require_module("CoreKeywordArguments")
core:require_module("CoreClass")
core:require_module("CoreEvent")
core:require_module("CoreCode")
TOOLHUB_NAME = "Music Monitor"
CoreMusicMonitor = CoreMusicMonitor or CoreClass.class()
function CoreMusicMonitor.init(A0_0)
	A0_0._database = ProjectDatabase
	A0_0:_create_main_frame()
end
function CoreMusicMonitor._create_main_frame(A0_1)
	local L1_2, L2_3, L3_4, L4_5
	L1_2 = {}
	A0_1._met = L1_2
	L1_2 = EWS
	L2_3 = L1_2
	L1_2 = L1_2.Frame
	L3_4 = TOOLHUB_NAME
	L4_5 = Vector3
	L4_5 = L4_5(100, 400, 0)
	L1_2 = L1_2(L2_3, L3_4, L4_5, Vector3(900, 350, 0), "FRAME_FLOAT_ON_PARENT,DEFAULT_FRAME_STYLE", Global.frame)
	A0_1._frame = L1_2
	L1_2 = EWS
	L2_3 = L1_2
	L1_2 = L1_2.Panel
	L3_4 = A0_1._frame
	L4_5 = ""
	L1_2 = L1_2(L2_3, L3_4, L4_5, "")
	L3_4 = A0_1
	L2_3 = A0_1._create_menu
	L4_5 = A0_1._frame
	L2_3(L3_4, L4_5)
	L2_3 = A0_1._met
	L3_4 = LuaHelperBox
	L4_5 = L3_4
	L3_4 = L3_4.new
	L3_4 = L3_4(L4_5, {parent = L1_2})
	L2_3.lua_helper = L3_4
	L2_3 = A0_1._met
	L3_4 = NowPlayingApiBox
	L4_5 = L3_4
	L3_4 = L3_4.new
	L3_4 = L3_4(L4_5, {parent = L1_2})
	L2_3.now_playing = L3_4
	L2_3 = A0_1._met
	L3_4 = LoadAndSaveApiBox
	L4_5 = L3_4
	L3_4 = L3_4.new
	L3_4 = L3_4(L4_5, {
		parent = L1_2,
		lua_helper = A0_1._met.lua_helper
	})
	L2_3.loadandsave = L3_4
	L2_3 = A0_1._met
	L3_4 = PitchApiBox
	L4_5 = L3_4
	L3_4 = L3_4.new
	L3_4 = L3_4(L4_5, {
		parent = L1_2,
		lua_helper = A0_1._met.lua_helper
	})
	L2_3.pitch_api = L3_4
	L2_3 = A0_1._met
	L3_4 = MixerApiBox
	L4_5 = L3_4
	L3_4 = L3_4.new
	L3_4 = L3_4(L4_5, {
		parent = L1_2,
		database = A0_1._database,
		lua_helper = A0_1._met.lua_helper
	})
	L2_3.mixer_api = L3_4
	L2_3 = A0_1._met
	L3_4 = GameplayApiBox
	L4_5 = L3_4
	L3_4 = L3_4.new
	L3_4 = L3_4(L4_5, {
		parent = L1_2,
		database = A0_1._database,
		mixer_api = A0_1._met.mixer_api,
		lua_helper = A0_1._met.lua_helper
	})
	L2_3.gameplay_api = L3_4
	L2_3 = EWS
	L3_4 = L2_3
	L2_3 = L2_3.BoxSizer
	L4_5 = "VERTICAL"
	L2_3 = L2_3(L3_4, L4_5)
	L4_5 = L2_3
	L3_4 = L2_3.add
	L3_4(L4_5, A0_1._met.pitch_api.box_sizer, 0, 0, "EXPAND")
	L4_5 = L2_3
	L3_4 = L2_3.add
	L3_4(L4_5, A0_1._met.now_playing.box_sizer, 1, 0, "EXPAND")
	L3_4 = EWS
	L4_5 = L3_4
	L3_4 = L3_4.BoxSizer
	L3_4 = L3_4(L4_5, "HORIZONTAL")
	L4_5 = L3_4.add
	L4_5(L3_4, A0_1._met.gameplay_api.box_sizer, 0, 0, "EXPAND")
	L4_5 = L3_4.add
	L4_5(L3_4, A0_1._met.loadandsave.box_sizer, 1, 0, "EXPAND")
	L4_5 = L3_4.add
	L4_5(L3_4, A0_1._met.mixer_api.box_sizer, 0, 0, "EXPAND")
	L4_5 = L3_4.add
	L4_5(L3_4, L2_3, 1, 0, "EXPAND")
	L4_5 = EWS
	L4_5 = L4_5.BoxSizer
	L4_5 = L4_5(L4_5, "VERTICAL")
	L4_5:add(L3_4, 0, 0, "EXPAND")
	L4_5:add(A0_1._met.lua_helper.box_sizer, 1, 0, "EXPAND")
	L1_2:set_sizer(L4_5)
	A0_1._frame:set_visible(true)
	A0_1:_set_enabled(true)
end
function CoreMusicMonitor._create_menu(A0_6, A1_7)
	local L2_8, L3_9
	L2_8 = EWS
	L3_9 = L2_8
	L2_8 = L2_8.Menu
	L2_8 = L2_8(L3_9, "")
	L3_9 = L2_8.append_item
	L3_9(L2_8, "REFRESH", "Refresh", "")
	L3_9 = L2_8.append_item
	L3_9(L2_8, "EXIT", "Exit", "")
	L3_9 = EWS
	L3_9 = L3_9.MenuBar
	L3_9 = L3_9(L3_9)
	L3_9:append(L2_8, "File")
	A1_7:set_menu_bar(L3_9)
	A1_7:connect("REFRESH", "EVT_COMMAND_MENU_SELECTED", CoreEvent.callback(A0_6, A0_6, "_on_refresh"), "")
	A1_7:connect("EXIT", "EVT_COMMAND_MENU_SELECTED", CoreEvent.callback(A0_6, A0_6, "_on_close"), "")
	A1_7:connect("", "EVT_CLOSE_WINDOW", CoreEvent.callback(A0_6, A0_6, "_on_close"), "")
end
function CoreMusicMonitor.close(A0_10)
	if A0_10._frame then
		A0_10._frame:destroy()
	end
	A0_10._song_project = nil
end
function CoreMusicMonitor.set_position(A0_11, A1_12)
	if A0_11._frame then
		A0_11._frame:set_position(A1_12)
	end
end
function CoreMusicMonitor.update(A0_13, A1_14, A2_15)
	if A0_13._met.pitch_api then
		A0_13._met.pitch_api:update(A1_14, A2_15)
	end
	if A0_13._met.now_playing then
		A0_13._met.now_playing:update(A1_14, A2_15)
	end
	if A0_13._met.loadandsave then
		A0_13._met.loadandsave:update(A1_14, A2_15)
	end
end
function CoreMusicMonitor._set_enabled(A0_16, A1_17)
	A0_16._met.lua_helper:set_enabled(A1_17)
	A0_16._met.mixer_api:set_enabled(A1_17)
	A0_16._met.gameplay_api:set_enabled(A1_17)
	A0_16:redraw()
end
function CoreMusicMonitor.redraw(A0_18)
	A0_18._met.lua_helper:redraw()
	A0_18._met.mixer_api:redraw()
	A0_18._met.gameplay_api:redraw()
end
function CoreMusicMonitor._on_close(A0_19)
	managers.toolhub:close(TOOLHUB_NAME)
end
function CoreMusicMonitor._on_refresh(A0_20)
	managers.music:reload_songs(song_name)
	A0_20:redraw()
end
LuaHelperBox = LuaHelperBox or CoreClass.class()
function LuaHelperBox.init(A0_21, ...)
	local L2_23
	L2_23 = CoreKeywordArguments
	L2_23 = L2_23.KeywordArguments
	L2_23 = L2_23.new
	L2_23 = L2_23(L2_23, ...)
	A0_21._ews_parent = L2_23:mandatory_object("parent")
	L2_23:assert_all_consumed()
	A0_21.gameplay_text = EWS:StaticText(A0_21._ews_parent, "", "", "")
	A0_21.box_sizer = EWS:StaticBoxSizer(A0_21._ews_parent, "VERTICAL", "Lua Helper")
	A0_21.box_sizer:add(EWS:StaticText(A0_21._ews_parent, "In LUA write:", "", ""), 0, 0, "")
	A0_21.box_sizer:add(A0_21.gameplay_text, 0, 10, "")
	A0_21:redraw()
end
function LuaHelperBox.set_enabled(A0_24, A1_25)
end
function LuaHelperBox.redraw(A0_26)
	local L1_27
end
function LuaHelperBox.set_help_text(A0_28, A1_29)
	A0_28.gameplay_text:set_value(A1_29)
end
LoadAndSaveApiBox = LoadAndSaveApiBox or CoreClass.class()
function LoadAndSaveApiBox.init(A0_30, ...)
	local L2_32, L3_33
	L2_32 = CoreKeywordArguments
	L2_32 = L2_32.KeywordArguments
	L3_33 = L2_32
	L2_32 = L2_32.new
	L2_32 = L2_32(L3_33, ...)
	L3_33 = L2_32.mandatory_object
	L3_33 = L3_33(L2_32, "parent")
	A0_30._ews_parent = L3_33
	L3_33 = L2_32.mandatory_object
	L3_33 = L3_33(L2_32, "lua_helper")
	A0_30._lua_helper = L3_33
	L3_33 = L2_32.assert_all_consumed
	L3_33(L2_32)
	L3_33 = EWS
	L3_33 = L3_33.Button
	L3_33 = L3_33(L3_33, A0_30._ews_parent, "save", "", "")
	A0_30.save_button = L3_33
	L3_33 = EWS
	L3_33 = L3_33.Button
	L3_33 = L3_33(L3_33, A0_30._ews_parent, "load", "", "")
	A0_30.load_button = L3_33
	L3_33 = EWS
	L3_33 = L3_33.StaticText
	L3_33 = L3_33(L3_33, A0_30._ews_parent, "", "", "")
	A0_30._text = L3_33
	L3_33 = A0_30.save_button
	L3_33 = L3_33.connect
	L3_33(L3_33, "", "EVT_COMMAND_BUTTON_CLICKED", CoreEvent.callback(A0_30, A0_30, "_on_save"), "")
	L3_33 = A0_30.load_button
	L3_33 = L3_33.connect
	L3_33(L3_33, "", "EVT_COMMAND_BUTTON_CLICKED", CoreEvent.callback(A0_30, A0_30, "_on_load"), "")
	L3_33 = {}
	A0_30._data = L3_33
	L3_33 = EWS
	L3_33 = L3_33.FlexGridSizer
	L3_33 = L3_33(L3_33, 2, 2, 5, 5)
	L3_33:add(A0_30.save_button, 0, 0, "")
	L3_33:add(A0_30.load_button, 0, 0, "")
	L3_33:add(A0_30._text, 0, 0, "")
	A0_30.box_sizer = EWS:StaticBoxSizer(A0_30._ews_parent, "VERTICAL", "Load And Save API")
	A0_30.box_sizer:add(L3_33, 0, 0, "")
end
function LoadAndSaveApiBox.set_enabled(A0_34, A1_35)
	A0_34.save_button:set_enabled(A1_35)
	A0_34.load_button:set_enabled(A1_35)
end
function LoadAndSaveApiBox.update(A0_36, A1_37, A2_38)
	local L3_39
	L3_39 = A0_36._data
	L3_39 = L3_39.MusicManager
	if L3_39 then
		L3_39 = A0_36._data
		L3_39 = L3_39.MusicManager
		L3_39 = L3_39.mode_name
		if L3_39 then
			L3_39 = A0_36._data
			L3_39 = L3_39.MusicManager
			L3_39 = L3_39.song_name
			if L3_39 then
				L3_39 = string
				L3_39 = L3_39.format
				L3_39 = L3_39([[
saved:
song = '%s'
mode = '%s']], A0_36._data.MusicManager.song_name, A0_36._data.MusicManager.mode_name)
				A0_36._text:set_value(L3_39)
			end
		end
	else
		L3_39 = A0_36._text
		L3_39 = L3_39.set_value
		L3_39(L3_39, "~ nothing saved ~")
	end
end
function LoadAndSaveApiBox._on_save(A0_40)
	A0_40._lua_helper:set_help_text("managers.music:save(data)")
	managers.music:save(A0_40._data)
end
function LoadAndSaveApiBox._on_load(A0_41)
	A0_41._lua_helper:set_help_text("managers.music:load(data)")
	managers.music:load(A0_41._data)
end
NowPlayingApiBox = NowPlayingApiBox or CoreClass.class()
function NowPlayingApiBox.init(A0_42, ...)
	local L2_44
	L2_44 = CoreKeywordArguments
	L2_44 = L2_44.KeywordArguments
	L2_44 = L2_44.new
	L2_44 = L2_44(L2_44, ...)
	A0_42._ews_parent = L2_44:mandatory_object("parent")
	L2_44:assert_all_consumed()
	A0_42._text = EWS:StaticText(A0_42._ews_parent, "", "", "")
	A0_42.box_sizer = EWS:StaticBoxSizer(A0_42._ews_parent, "HORIZONTAL", "Get Now Playing API")
	A0_42.box_sizer:add(A0_42._text, 0, 0, "")
end
function NowPlayingApiBox.set_enabled(A0_45, A1_46)
	A0_45._text:set_enabled(A1_46)
end
function NowPlayingApiBox.update(A0_47, A1_48, A2_49)
	local L3_50, L4_51, L5_52, L6_53, L7_54, L8_55, L9_56
	L3_50 = managers
	L3_50 = L3_50.music
	L4_51 = L3_50
	L3_50 = L3_50.player
	L3_50 = L3_50(L4_51)
	L4_51 = L3_50
	L3_50 = L3_50.get_now_playing
	L3_50 = L3_50(L4_51)
	if L3_50 then
		L4_51 = ""
		for L8_55, L9_56 in L5_52(L6_53) do
			if type(L9_56) == "number" then
				L4_51 = L4_51 .. string.format("%s = %3.3f\n", L8_55, L9_56)
			else
				L4_51 = L4_51 .. string.format("%s = %s\n", L8_55, L9_56)
			end
		end
		L5_52(L6_53, L7_54)
	else
		L4_51 = A0_47._text
		L4_51 = L4_51.set_value
		L4_51(L5_52, L6_53)
	end
end
PitchApiBox = PitchApiBox or CoreClass.class()
function PitchApiBox.init(A0_57, ...)
	local L2_59
	L2_59 = CoreKeywordArguments
	L2_59 = L2_59.KeywordArguments
	L2_59 = L2_59.new
	L2_59 = L2_59(L2_59, ...)
	A0_57._ews_parent = L2_59:mandatory_object("parent")
	A0_57._lua_helper = L2_59:mandatory_object("lua_helper")
	L2_59:assert_all_consumed()
	A0_57._text = EWS:StaticText(A0_57._ews_parent, "pitch", "", "")
	A0_57._slider = EWS:Slider(A0_57._ews_parent, 100, 0, 200, "", "")
	A0_57.box_sizer = EWS:StaticBoxSizer(A0_57._ews_parent, "HORIZONTAL", "Player Pitch API")
	A0_57.box_sizer:add(A0_57._text, 0, 0, "")
	A0_57.box_sizer:add(A0_57._slider, 0, 0, "")
	A0_57._pitch = 1
	managers.music:player():set_pitch(A0_57._pitch)
end
function PitchApiBox.set_enabled(A0_60, A1_61)
	A0_60._text:set_enabled(A1_61)
	A0_60._slider:set_enabled(A1_61)
end
function PitchApiBox.update(A0_62, A1_63, A2_64)
	if A0_62._pitch ~= A0_62._slider:get_value() / 100 then
		A0_62._pitch = A0_62._slider:get_value() / 100
		A0_62._lua_helper:set_help_text(string.format("managers.music:player():set_pitch( %3.3f )", A0_62._pitch))
		managers.music:player():set_pitch(A0_62._pitch)
	end
end
MixerApiBox = MixerApiBox or CoreClass.class()
function MixerApiBox.init(A0_65, ...)
	local L2_67, L3_68
	L2_67 = CoreKeywordArguments
	L2_67 = L2_67.KeywordArguments
	L3_68 = L2_67
	L2_67 = L2_67.new
	L2_67 = L2_67(L3_68, ...)
	L3_68 = L2_67.mandatory_object
	L3_68 = L3_68(L2_67, "parent")
	A0_65._ews_parent = L3_68
	L3_68 = L2_67.mandatory_object
	L3_68 = L3_68(L2_67, "lua_helper")
	A0_65._lua_helper = L3_68
	L3_68 = L2_67.mandatory_object
	L3_68 = L3_68(L2_67, "database")
	A0_65._database = L3_68
	L3_68 = L2_67.assert_all_consumed
	L3_68(L2_67)
	L3_68 = EWS
	L3_68 = L3_68.Button
	L3_68 = L3_68(L3_68, A0_65._ews_parent, "reg mixer", "", "")
	A0_65.reg_mixer_button = L3_68
	L3_68 = EWS
	L3_68 = L3_68.Button
	L3_68 = L3_68(L3_68, A0_65._ews_parent, "unreg mixer", "", "")
	A0_65.unreg_mixer_button = L3_68
	L3_68 = EWS
	L3_68 = L3_68.ComboBox
	L3_68 = L3_68(L3_68, A0_65._ews_parent, "", "", "")
	A0_65.set_mode_combo = L3_68
	L3_68 = A0_65.reg_mixer_button
	L3_68 = L3_68.connect
	L3_68(L3_68, "", "EVT_COMMAND_BUTTON_CLICKED", CoreEvent.callback(A0_65, A0_65, "_on_reg_mixer"), "")
	L3_68 = A0_65.unreg_mixer_button
	L3_68 = L3_68.connect
	L3_68(L3_68, "", "EVT_COMMAND_BUTTON_CLICKED", CoreEvent.callback(A0_65, A0_65, "_on_unreg_mixer"), "")
	L3_68 = EWS
	L3_68 = L3_68.FlexGridSizer
	L3_68 = L3_68(L3_68, 20, 2, 5, 5)
	A0_65.mixer_grid = L3_68
	L3_68 = {}
	A0_65.text_table = L3_68
	L3_68 = {}
	A0_65.slider_table = L3_68
	L3_68 = EWS
	L3_68 = L3_68.FlexGridSizer
	L3_68 = L3_68(L3_68, 2, 2, 5, 5)
	L3_68:add(A0_65.reg_mixer_button, 0, 0, "")
	L3_68:add(A0_65.set_mode_combo, 0, 10, "")
	L3_68:add(A0_65.unreg_mixer_button, 0, 0, "")
	L3_68:add(EWS:StaticText(A0_65._ews_parent, "~ uses the mode above ~", "", ""), 0, 10, "")
	A0_65.box_sizer = EWS:StaticBoxSizer(A0_65._ews_parent, "VERTICAL", "Sub Mode Mixer API")
	A0_65.box_sizer:add(L3_68, 0, 0, "")
	A0_65.box_sizer:add(A0_65.mixer_grid, 0, 0, "")
	A0_65:redraw()
end
function MixerApiBox.set_enabled(A0_69, A1_70)
	A0_69.reg_mixer_button:set_enabled(A1_70)
	A0_69.unreg_mixer_button:set_enabled(A1_70)
end
function MixerApiBox.redraw(A0_71)
	local L1_72
end
function MixerApiBox.song_selected(A0_73, A1_74)
	local L2_75, L3_76, L4_77, L5_78, L6_79, L7_80, L8_81
	L5_78 = A1_74
	if L2_75 then
		L2_75(L3_76)
		L5_78 = A1_74
		L8_81 = L3_76(L4_77, L5_78)
		for L5_78, L6_79 in L2_75(L3_76, L4_77, L5_78, L6_79, L7_80, L8_81, L3_76(L4_77, L5_78)) do
			L7_80 = A0_73.set_mode_combo
			L8_81 = L7_80
			L7_80 = L7_80.append
			L7_80(L8_81, L6_79)
		end
		L2_75(L3_76)
		for L5_78, L6_79 in L2_75(L3_76) do
			L8_81 = L6_79
			L7_80 = L6_79.destroy
			L7_80(L8_81)
		end
		for L5_78, L6_79 in L2_75(L3_76) do
			L8_81 = L6_79
			L7_80 = L6_79.destroy
			L7_80(L8_81)
		end
		A0_73.text_table = L2_75
		A0_73.slider_table = L2_75
		L5_78 = A1_74
		L8_81 = L3_76(L4_77, L5_78)
		for L5_78, L6_79 in L2_75(L3_76, L4_77, L5_78, L6_79, L7_80, L8_81, L3_76(L4_77, L5_78)) do
			L7_80 = EWS
			L8_81 = L7_80
			L7_80 = L7_80.StaticText
			L7_80 = L7_80(L8_81, A0_73._ews_parent, L6_79, "", "")
			L8_81 = EWS
			L8_81 = L8_81.Slider
			L8_81 = L8_81(L8_81, A0_73._ews_parent, 0, 0, 100, "", "")
			A0_73.text_table[L6_79] = L7_80
			A0_73.slider_table[L6_79] = L8_81
			A0_73.mixer_grid:add(L7_80, 0, 10, "")
			A0_73.mixer_grid:add(L8_81, 0, 10, "")
		end
		L2_75(L3_76)
	end
end
function MixerApiBox._on_reg_mixer(A0_82)
	local L1_83
	L1_83 = A0_82.set_mode_combo
	L1_83 = L1_83.get_value
	L1_83 = L1_83(L1_83)
	A0_82._lua_helper:set_help_text(string.format("managers.music:player():register_sub_mode_mixer_cb( \"%s\", <your_callback>)", L1_83))
	managers.music:player():register_sub_mode_mixer_cb(L1_83, CoreEvent.callback(A0_82, A0_82, "_mixer_cb"))
end
function MixerApiBox._on_unreg_mixer(A0_84)
	local L1_85
	L1_85 = A0_84.set_mode_combo
	L1_85 = L1_85.get_value
	L1_85 = L1_85(L1_85)
	A0_84._lua_helper:set_help_text(string.format("managers.music:player():unregister_sub_mode_mixer_cb( \"%s\" )", L1_85))
	managers.music:player():unregister_sub_mode_mixer_cb(L1_85)
end
function MixerApiBox._mixer_cb(A0_86)
	local L1_87
	L1_87 = {}
	for 