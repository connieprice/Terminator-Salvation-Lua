core:module("CoreMusicMonitor")
core:require_module("CoreKeywordArguments")
core:require_module("CoreClass")
core:require_module("CoreEvent")
core:require_module("CoreCode")
TOOLHUB_NAME = "Music Monitor"
if not CoreMusicMonitor then
	CoreMusicMonitor = CoreClass.class()
end
CoreMusicMonitor.init = function(l_1_0)
	l_1_0._database = ProjectDatabase
	l_1_0:_create_main_frame()
end

CoreMusicMonitor._create_main_frame = function(l_2_0)
	l_2_0._met = {}
	l_2_0._frame = EWS:Frame(TOOLHUB_NAME, Vector3(100, 400, 0), Vector3(900, 350, 0), "FRAME_FLOAT_ON_PARENT,DEFAULT_FRAME_STYLE", Global.frame)
	local l_2_1 = EWS:Panel(l_2_0._frame, "", "")
	l_2_0:_create_menu(l_2_0._frame)
	local l_2_2 = l_2_0._met
	local l_2_3, l_2_4 = LuaHelperBox:new, LuaHelperBox
	local l_2_5 = {}
	l_2_5.parent = l_2_1
	l_2_3 = l_2_3(l_2_4, l_2_5)
	l_2_2.lua_helper = l_2_3
	l_2_2 = l_2_0._met
	l_2_3 = NowPlayingApiBox
	l_2_3, l_2_4 = l_2_3:new, l_2_3
	l_2_3, l_2_5 = l_2_3(l_2_4, l_2_5), {parent = l_2_1}
	l_2_2.now_playing = l_2_3
	l_2_2 = l_2_0._met
	l_2_3 = LoadAndSaveApiBox
	l_2_3, l_2_4 = l_2_3:new, l_2_3
	l_2_3, l_2_5 = l_2_3(l_2_4, l_2_5), {parent = l_2_1, lua_helper = l_2_0._met.lua_helper}
	l_2_2.loadandsave = l_2_3
	l_2_2 = l_2_0._met
	l_2_3 = PitchApiBox
	l_2_3, l_2_4 = l_2_3:new, l_2_3
	l_2_3, l_2_5 = l_2_3(l_2_4, l_2_5), {parent = l_2_1, lua_helper = l_2_0._met.lua_helper}
	l_2_2.pitch_api = l_2_3
	l_2_2 = l_2_0._met
	l_2_3 = MixerApiBox
	l_2_3, l_2_4 = l_2_3:new, l_2_3
	l_2_3, l_2_5 = l_2_3(l_2_4, l_2_5), {parent = l_2_1, database = l_2_0._database, lua_helper = l_2_0._met.lua_helper}
	l_2_2.mixer_api = l_2_3
	l_2_2 = l_2_0._met
	l_2_3 = GameplayApiBox
	l_2_3, l_2_4 = l_2_3:new, l_2_3
	l_2_3, l_2_5 = l_2_3(l_2_4, l_2_5), {parent = l_2_1, database = l_2_0._database, mixer_api = l_2_0._met.mixer_api, lua_helper = l_2_0._met.lua_helper}
	l_2_2.gameplay_api = l_2_3
	l_2_2 = EWS
	l_2_2, l_2_3 = l_2_2:BoxSizer, l_2_2
	l_2_4 = "VERTICAL"
	l_2_2 = l_2_2(l_2_3, l_2_4)
	l_2_3, l_2_4 = l_2_2:add, l_2_2
	l_2_5 = l_2_0._met
	l_2_5 = l_2_5.pitch_api
	l_2_5 = l_2_5.box_sizer
	l_2_3(l_2_4, l_2_5, 0, 0, "EXPAND")
	l_2_3, l_2_4 = l_2_2:add, l_2_2
	l_2_5 = l_2_0._met
	l_2_5 = l_2_5.now_playing
	l_2_5 = l_2_5.box_sizer
	l_2_3(l_2_4, l_2_5, 1, 0, "EXPAND")
	l_2_3 = EWS
	l_2_3, l_2_4 = l_2_3:BoxSizer, l_2_3
	l_2_5 = "HORIZONTAL"
	l_2_3 = l_2_3(l_2_4, l_2_5)
	l_2_4, l_2_5 = l_2_3:add, l_2_3
	l_2_4(l_2_5, l_2_0._met.gameplay_api.box_sizer, 0, 0, "EXPAND")
	l_2_4, l_2_5 = l_2_3:add, l_2_3
	l_2_4(l_2_5, l_2_0._met.loadandsave.box_sizer, 1, 0, "EXPAND")
	l_2_4, l_2_5 = l_2_3:add, l_2_3
	l_2_4(l_2_5, l_2_0._met.mixer_api.box_sizer, 0, 0, "EXPAND")
	l_2_4, l_2_5 = l_2_3:add, l_2_3
	l_2_4(l_2_5, l_2_2, 1, 0, "EXPAND")
	l_2_4 = EWS
	l_2_4, l_2_5 = l_2_4:BoxSizer, l_2_4
	l_2_4 = l_2_4(l_2_5, "VERTICAL")
	l_2_5(l_2_4, l_2_3, 0, 0, "EXPAND")
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_5(l_2_4, l_2_0._met.lua_helper.box_sizer, 1, 0, "EXPAND")
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_5(l_2_1, l_2_4)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_5(l_2_5, true)
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_5(l_2_0, true)
end

CoreMusicMonitor._create_menu = function(l_3_0, l_3_1)
	local l_3_2 = EWS:Menu("")
	l_3_2:append_item("REFRESH", "Refresh", "")
	l_3_2:append_item("EXIT", "Exit", "")
	local l_3_3 = EWS:MenuBar()
	l_3_3:append(l_3_2, "File")
	l_3_1:set_menu_bar(l_3_3)
	l_3_1:connect("REFRESH", "EVT_COMMAND_MENU_SELECTED", CoreEvent.callback(l_3_0, l_3_0, "_on_refresh"), "")
	l_3_1:connect("EXIT", "EVT_COMMAND_MENU_SELECTED", CoreEvent.callback(l_3_0, l_3_0, "_on_close"), "")
	l_3_1:connect("", "EVT_CLOSE_WINDOW", CoreEvent.callback(l_3_0, l_3_0, "_on_close"), "")
end

CoreMusicMonitor.close = function(l_4_0)
	if l_4_0._frame then
		l_4_0._frame:destroy()
	end
	l_4_0._song_project = nil
end

CoreMusicMonitor.set_position = function(l_5_0, l_5_1)
	if l_5_0._frame then
		l_5_0._frame:set_position(l_5_1)
	end
end

CoreMusicMonitor.update = function(l_6_0, l_6_1, l_6_2)
	if l_6_0._met.pitch_api then
		l_6_0._met.pitch_api:update(l_6_1, l_6_2)
	end
	if l_6_0._met.now_playing then
		l_6_0._met.now_playing:update(l_6_1, l_6_2)
	end
	if l_6_0._met.loadandsave then
		l_6_0._met.loadandsave:update(l_6_1, l_6_2)
	end
end

CoreMusicMonitor._set_enabled = function(l_7_0, l_7_1)
	l_7_0._met.lua_helper:set_enabled(l_7_1)
	l_7_0._met.mixer_api:set_enabled(l_7_1)
	l_7_0._met.gameplay_api:set_enabled(l_7_1)
	l_7_0:redraw()
end

CoreMusicMonitor.redraw = function(l_8_0)
	l_8_0._met.lua_helper:redraw()
	l_8_0._met.mixer_api:redraw()
	l_8_0._met.gameplay_api:redraw()
end

CoreMusicMonitor._on_close = function(l_9_0)
	managers.toolhub:close(TOOLHUB_NAME)
end

CoreMusicMonitor._on_refresh = function(l_10_0)
	managers.music:reload_songs(song_name)
	l_10_0:redraw()
end

if not LuaHelperBox then
	LuaHelperBox = CoreClass.class()
end
LuaHelperBox.init = function(l_11_0, ...)
	l_11_0._ews_parent = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("parent")
	CoreKeywordArguments.KeywordArguments:new(...):assert_all_consumed()
	l_11_0.gameplay_text = EWS:StaticText(l_11_0._ews_parent, "", "", "")
	l_11_0.box_sizer = EWS:StaticBoxSizer(l_11_0._ews_parent, "VERTICAL", "Lua Helper")
	l_11_0.box_sizer:add(EWS:StaticText(l_11_0._ews_parent, "In LUA write:", "", ""), 0, 0, "")
	l_11_0.box_sizer:add(l_11_0.gameplay_text, 0, 10, "")
	l_11_0:redraw()
end

LuaHelperBox.set_enabled = function(l_12_0, l_12_1)
end

LuaHelperBox.redraw = function(l_13_0)
end

LuaHelperBox.set_help_text = function(l_14_0, l_14_1)
	l_14_0.gameplay_text:set_value(l_14_1)
end

if not LoadAndSaveApiBox then
	LoadAndSaveApiBox = CoreClass.class()
end
LoadAndSaveApiBox.init = function(l_15_0, ...)
	l_15_0._ews_parent = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("parent")
	l_15_0._lua_helper = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("lua_helper")
	CoreKeywordArguments.KeywordArguments:new(...):assert_all_consumed()
	l_15_0.save_button = EWS:Button(l_15_0._ews_parent, "save", "", "")
	l_15_0.load_button = EWS:Button(l_15_0._ews_parent, "load", "", "")
	l_15_0._text = EWS:StaticText(l_15_0._ews_parent, "", "", "")
	l_15_0.save_button:connect("", "EVT_COMMAND_BUTTON_CLICKED", CoreEvent.callback(l_15_0, l_15_0, "_on_save"), "")
	l_15_0.load_button:connect("", "EVT_COMMAND_BUTTON_CLICKED", CoreEvent.callback(l_15_0, l_15_0, "_on_load"), "")
	l_15_0._data = {}
	local l_15_2 = nil
	EWS:FlexGridSizer(2, 2, 5, 5):add(l_15_0.save_button, 0, 0, "")
	EWS:FlexGridSizer(2, 2, 5, 5):add(l_15_0.load_button, 0, 0, "")
	EWS:FlexGridSizer(2, 2, 5, 5):add(l_15_0._text, 0, 0, "")
	l_15_0.box_sizer = EWS:StaticBoxSizer(l_15_0._ews_parent, "VERTICAL", "Load And Save API")
	l_15_0.box_sizer:add(EWS:FlexGridSizer(2, 2, 5, 5), 0, 0, "")
end

LoadAndSaveApiBox.set_enabled = function(l_16_0, l_16_1)
	l_16_0.save_button:set_enabled(l_16_1)
	l_16_0.load_button:set_enabled(l_16_1)
end

LoadAndSaveApiBox.update = function(l_17_0, l_17_1, l_17_2)
	if l_17_0._data.MusicManager and l_17_0._data.MusicManager.mode_name and l_17_0._data.MusicManager.song_name then
		local l_17_3 = string.format("saved:\nsong = '%s'\nmode = '%s'", l_17_0._data.MusicManager.song_name, l_17_0._data.MusicManager.mode_name)
		l_17_0._text:set_value(l_17_3)
	else
		l_17_0._text:set_value("~ nothing saved ~")
	end
end

LoadAndSaveApiBox._on_save = function(l_18_0)
	l_18_0._lua_helper:set_help_text("managers.music:save(data)")
	managers.music:save(l_18_0._data)
end

LoadAndSaveApiBox._on_load = function(l_19_0)
	l_19_0._lua_helper:set_help_text("managers.music:load(data)")
	managers.music:load(l_19_0._data)
end

if not NowPlayingApiBox then
	NowPlayingApiBox = CoreClass.class()
end
NowPlayingApiBox.init = function(l_20_0, ...)
	l_20_0._ews_parent = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("parent")
	CoreKeywordArguments.KeywordArguments:new(...):assert_all_consumed()
	l_20_0._text = EWS:StaticText(l_20_0._ews_parent, "", "", "")
	l_20_0.box_sizer = EWS:StaticBoxSizer(l_20_0._ews_parent, "HORIZONTAL", "Get Now Playing API")
	l_20_0.box_sizer:add(l_20_0._text, 0, 0, "")
end

NowPlayingApiBox.set_enabled = function(l_21_0, l_21_1)
	l_21_0._text:set_enabled(l_21_1)
end

NowPlayingApiBox.update = function(l_22_0, l_22_1, l_22_2)
	local l_22_8, l_22_9, l_22_10, l_22_11, l_22_12, l_22_13, l_22_14, l_22_15 = nil
	local l_22_3 = managers.music:player():get_now_playing()
	if l_22_3 then
		local l_22_4 = ""
		for i_0,i_1 in pairs(l_22_3) do
			if type(i_1) == "number" then
				l_22_4 = l_22_4 .. string.format("%s = %3.3f\n", i_0, i_1)
			else
				l_22_4 = l_22_4 .. string.format("%s = %s\n", i_0, i_1)
			end
		end
		l_22_0._text:set_value(l_22_4)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		l_22_4 = l_22_0._text
		l_22_4(l_22_4, "~ no info available ~")
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

if not PitchApiBox then
	PitchApiBox = CoreClass.class()
end
PitchApiBox.init = function(l_23_0, ...)
	l_23_0._ews_parent = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("parent")
	l_23_0._lua_helper = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("lua_helper")
	CoreKeywordArguments.KeywordArguments:new(...):assert_all_consumed()
	l_23_0._text = EWS:StaticText(l_23_0._ews_parent, "pitch", "", "")
	l_23_0._slider = EWS:Slider(l_23_0._ews_parent, 100, 0, 200, "", "")
	l_23_0.box_sizer = EWS:StaticBoxSizer(l_23_0._ews_parent, "HORIZONTAL", "Player Pitch API")
	l_23_0.box_sizer:add(l_23_0._text, 0, 0, "")
	l_23_0.box_sizer:add(l_23_0._slider, 0, 0, "")
	l_23_0._pitch = 1
	managers.music:player():set_pitch(l_23_0._pitch)
end

PitchApiBox.set_enabled = function(l_24_0, l_24_1)
	l_24_0._text:set_enabled(l_24_1)
	l_24_0._slider:set_enabled(l_24_1)
end

PitchApiBox.update = function(l_25_0, l_25_1, l_25_2)
	local l_25_3 = l_25_0._slider:get_value() / 100
	if l_25_0._pitch ~= l_25_3 then
		l_25_0._pitch = l_25_3
		l_25_0._lua_helper:set_help_text(string.format("managers.music:player():set_pitch( %3.3f )", l_25_0._pitch))
		managers.music:player():set_pitch(l_25_0._pitch)
	end
end

if not MixerApiBox then
	MixerApiBox = CoreClass.class()
end
MixerApiBox.init = function(l_26_0, ...)
	l_26_0._ews_parent = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("parent")
	l_26_0._lua_helper = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("lua_helper")
	l_26_0._database = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("database")
	CoreKeywordArguments.KeywordArguments:new(...):assert_all_consumed()
	l_26_0.reg_mixer_button = EWS:Button(l_26_0._ews_parent, "reg mixer", "", "")
	l_26_0.unreg_mixer_button = EWS:Button(l_26_0._ews_parent, "unreg mixer", "", "")
	l_26_0.set_mode_combo = EWS:ComboBox(l_26_0._ews_parent, "", "", "")
	l_26_0.reg_mixer_button:connect("", "EVT_COMMAND_BUTTON_CLICKED", CoreEvent.callback(l_26_0, l_26_0, "_on_reg_mixer"), "")
	l_26_0.unreg_mixer_button:connect("", "EVT_COMMAND_BUTTON_CLICKED", CoreEvent.callback(l_26_0, l_26_0, "_on_unreg_mixer"), "")
	l_26_0.mixer_grid = EWS:FlexGridSizer(20, 2, 5, 5)
	l_26_0.text_table = {}
	l_26_0.slider_table = {}
	local l_26_2 = nil
	EWS:FlexGridSizer(2, 2, 5, 5):add(l_26_0.reg_mixer_button, 0, 0, "")
	EWS:FlexGridSizer(2, 2, 5, 5):add(l_26_0.set_mode_combo, 0, 10, "")
	EWS:FlexGridSizer(2, 2, 5, 5):add(l_26_0.unreg_mixer_button, 0, 0, "")
	EWS:FlexGridSizer(2, 2, 5, 5):add(EWS:StaticText(l_26_0._ews_parent, "~ uses the mode above ~", "", ""), 0, 10, "")
	l_26_0.box_sizer = EWS:StaticBoxSizer(l_26_0._ews_parent, "VERTICAL", "Sub Mode Mixer API")
	l_26_0.box_sizer:add(EWS:FlexGridSizer(2, 2, 5, 5), 0, 0, "")
	l_26_0.box_sizer:add(l_26_0.mixer_grid, 0, 0, "")
	l_26_0:redraw()
end

MixerApiBox.set_enabled = function(l_27_0, l_27_1)
	l_27_0.reg_mixer_button:set_enabled(l_27_1)
	l_27_0.unreg_mixer_button:set_enabled(l_27_1)
end

MixerApiBox.redraw = function(l_28_0)
end

MixerApiBox.song_selected = function(l_29_0, l_29_1)
	if l_29_0._database:has("song", l_29_1) then
		l_29_0.set_mode_combo:clear()
		local l_29_5, l_29_6 = ipairs, managers.music:get_modes(l_29_1)
		l_29_5 = l_29_5(l_29_6)
		for i_0,i_1 in l_29_5 do
			l_29_0.set_mode_combo:append(l_29_4)
		end
		l_29_0.mixer_grid:clear()
		for i_0,i_1 in pairs(l_29_0.text_table) do
			i_1:destroy()
		end
		for i_0,i_1 in pairs(l_29_0.slider_table) do
			i_1:destroy()
		end
		l_29_0.text_table = {}
		l_29_0.slider_table = {}
		for i_0,i_1 in ipairs(managers.music:get_modes(l_29_1)) do
			local l_29_7 = EWS:StaticText(l_29_0._ews_parent, i_1, "", "")
			local l_29_8 = EWS:Slider(l_29_0._ews_parent, 0, 0, 100, "", "")
			l_29_0.text_table[i_1] = l_29_7
			l_29_0.slider_table[i_1] = l_29_8
			l_29_0.mixer_grid:add(l_29_7, 0, 10, "")
			l_29_0.mixer_grid:add(l_29_8, 0, 10, "")
		end
		l_29_0._ews_parent:layout()
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

MixerApiBox._on_reg_mixer = function(l_30_0)
	local l_30_1 = l_30_0.set_mode_combo:get_value()
	l_30_0._lua_helper:set_help_text(string.format("managers.music:player():register_sub_mode_mixer_cb( \"%s\", <your_callback>)", l_30_1))
	managers.music:player():register_sub_mode_mixer_cb(l_30_1, CoreEvent.callback(l_30_0, l_30_0, "_mixer_cb"))
end

MixerApiBox._on_unreg_mixer = function(l_31_0)
	local l_31_1 = l_31_0.set_mode_combo:get_value()
	l_31_0._lua_helper:set_help_text(string.format("managers.music:player():unregister_sub_mode_mixer_cb( \"%s\" )", l_31_1))
	managers.music:player():unregister_sub_mode_mixer_cb(l_31_1)
end

MixerApiBox._mixer_cb = function(l_32_0)
	local l_32_5, l_32_6, l_32_7, l_32_8 = nil
	local l_32_1 = {}
	for i_0,i_1 in pairs(l_32_0.slider_table) do
		if i_1:get_value() > 0 then
			l_32_1[l_32_9] = i_1:get_value() / 100
		end
	end
	l_32_0._lua_helper:set_help_text("<your_callback> returned table:\n" .. CoreCode.ascii_table(l_32_1))
	return l_32_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

if not GameplayApiBox then
	GameplayApiBox = CoreClass.class()
end
GameplayApiBox.init = function(l_33_0, ...)
	l_33_0._ews_parent = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("parent")
	l_33_0._mixer_api = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("mixer_api")
	l_33_0._lua_helper = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("lua_helper")
	l_33_0._database = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("database")
	CoreKeywordArguments.KeywordArguments:new(...):assert_all_consumed()
	l_33_0.play_now_button = EWS:Button(l_33_0._ews_parent, "play_now", "", "")
	l_33_0.play_nice_button = EWS:Button(l_33_0._ews_parent, "play_nice", "", "")
	l_33_0.set_mode_button = EWS:Button(l_33_0._ews_parent, "set_mode", "", "")
	l_33_0.stop_now_button = EWS:Button(l_33_0._ews_parent, "stop_now", "", "")
	l_33_0.stop_nice_button = EWS:Button(l_33_0._ews_parent, "stop_nice", "", "")
	l_33_0.pause_button = EWS:Button(l_33_0._ews_parent, "pause", "", "")
	l_33_0.resume_button = EWS:Button(l_33_0._ews_parent, "resume", "", "")
	l_33_0.song_name_combo = EWS:ComboBox(l_33_0._ews_parent, "", "", "")
	l_33_0.set_mode_combo = EWS:ComboBox(l_33_0._ews_parent, "", "", "")
	l_33_0.mode_prio_spin = EWS:SpinCtrl(l_33_0._ews_parent, 1, "", "")
	l_33_0.mode_prio_spin:set_range(1, 100)
	l_33_0.play_now_button:connect("", "EVT_COMMAND_BUTTON_CLICKED", CoreEvent.callback(l_33_0, l_33_0, "_on_play_now"), "")
	l_33_0.play_nice_button:connect("", "EVT_COMMAND_BUTTON_CLICKED", CoreEvent.callback(l_33_0, l_33_0, "_on_play_nice"), "")
	l_33_0.set_mode_button:connect("", "EVT_COMMAND_BUTTON_CLICKED", CoreEvent.callback(l_33_0, l_33_0, "_on_set_mode"), "")
	l_33_0.stop_now_button:connect("", "EVT_COMMAND_BUTTON_CLICKED", CoreEvent.callback(l_33_0, l_33_0, "_on_stop_now"), "")
	l_33_0.stop_nice_button:connect("", "EVT_COMMAND_BUTTON_CLICKED", CoreEvent.callback(l_33_0, l_33_0, "_on_stop_nice"), "")
	l_33_0.pause_button:connect("", "EVT_COMMAND_BUTTON_CLICKED", CoreEvent.callback(l_33_0, l_33_0, "_on_pause"), "")
	l_33_0.resume_button:connect("", "EVT_COMMAND_BUTTON_CLICKED", CoreEvent.callback(l_33_0, l_33_0, "_on_resume"), "")
	l_33_0.song_name_combo:connect("", "EVT_COMMAND_TEXT_UPDATED", CoreEvent.callback(l_33_0, l_33_0, "_on_song_selected"), "")
	local l_33_2 = nil
	EWS:FlexGridSizer(8, 2, 5, 5):add(l_33_0.play_now_button, 0, 0, "")
	EWS:FlexGridSizer(8, 2, 5, 5):add(l_33_0.song_name_combo, 0, 10, "")
	EWS:FlexGridSizer(8, 2, 5, 5):add(l_33_0.play_nice_button, 0, 0, "")
	EWS:FlexGridSizer(8, 2, 5, 5):add(EWS:StaticText(l_33_0._ews_parent, "~ uses the song above ~", "", ""), 0, 10, "")
	EWS:FlexGridSizer(8, 2, 5, 5):add(l_33_0.set_mode_button, 0, 0, "")
	EWS:FlexGridSizer(8, 2, 5, 5):add(l_33_0.set_mode_combo, 0, 10, "")
	EWS:FlexGridSizer(8, 2, 5, 5):add(EWS:StaticText(l_33_0._ews_parent, "~ set_mode prio ~", "", ""), 0, 0, "")
	EWS:FlexGridSizer(8, 2, 5, 5):add(l_33_0.mode_prio_spin, 0, 10, "")
	EWS:FlexGridSizer(8, 2, 5, 5):add(l_33_0.stop_now_button, 0, 0, "")
	EWS:FlexGridSizer(8, 2, 5, 5):add(EWS:StaticText(l_33_0._ews_parent, "", "", ""), 0, 10, "")
	EWS:FlexGridSizer(8, 2, 5, 5):add(l_33_0.stop_nice_button, 0, 0, "")
	EWS:FlexGridSizer(8, 2, 5, 5):add(EWS:StaticText(l_33_0._ews_parent, "", "", ""), 0, 10, "")
	EWS:FlexGridSizer(8, 2, 5, 5):add(l_33_0.pause_button, 0, 0, "")
	EWS:FlexGridSizer(8, 2, 5, 5):add(EWS:StaticText(l_33_0._ews_parent, "", "", ""), 0, 10, "")
	EWS:FlexGridSizer(8, 2, 5, 5):add(l_33_0.resume_button, 0, 0, "")
	EWS:FlexGridSizer(8, 2, 5, 5):add(EWS:StaticText(l_33_0._ews_parent, "", "", ""), 0, 10, "")
	l_33_0.box_sizer = EWS:StaticBoxSizer(l_33_0._ews_parent, "VERTICAL", "Song Playback API")
	l_33_0.box_sizer:add(EWS:FlexGridSizer(8, 2, 5, 5), 0, 0, "")
	l_33_0:redraw()
end

GameplayApiBox.set_enabled = function(l_34_0, l_34_1)
	l_34_0.play_now_button:set_enabled(l_34_1)
	l_34_0.play_nice_button:set_enabled(l_34_1)
	l_34_0.set_mode_button:set_enabled(l_34_1)
	l_34_0.stop_now_button:set_enabled(l_34_1)
	l_34_0.stop_nice_button:set_enabled(l_34_1)
	l_34_0.pause_button:set_enabled(l_34_1)
	l_34_0.resume_button:set_enabled(l_34_1)
	l_34_0.song_name_combo:set_enabled(l_34_1)
	l_34_0.set_mode_combo:set_enabled(l_34_1)
end

GameplayApiBox.redraw = function(l_35_0)
	l_35_0.song_name_combo:clear()
	local l_35_4, l_35_5 = ipairs, l_35_0._database:all(false, "song")
	l_35_4 = l_35_4(l_35_5)
	for i_0,i_1 in l_35_4 do
		local l_35_6 = l_35_3:name()
		l_35_0.song_name_combo:append(l_35_6)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

GameplayApiBox._on_play_now = function(l_36_0)
	local l_36_1 = l_36_0.song_name_combo:get_value()
	l_36_0._lua_helper:set_help_text(string.format("managers.music:player():play_now( \"%s\" )", l_36_1))
	managers.music:reload_songs(l_36_1)
	managers.music:player():play_now(l_36_1)
end

GameplayApiBox._on_play_nice = function(l_37_0)
	local l_37_1 = l_37_0.song_name_combo:get_value()
	l_37_0._lua_helper:set_help_text(string.format("managers.music:player():play_nice( \"%s\" )", l_37_1))
	managers.music:reload_songs(l_37_1)
	managers.music:player():play_nice(l_37_1)
end

GameplayApiBox._on_set_mode = function(l_38_0)
	local l_38_1 = l_38_0.set_mode_combo:get_value()
	local l_38_2 = l_38_0.mode_prio_spin:get_value()
	l_38_0._lua_helper:set_help_text(string.format("managers.music:player():set_mode( \"%s\", %d )", l_38_1, l_38_2))
	managers.music:player():set_mode(l_38_1, l_38_2)
end

GameplayApiBox._on_stop_now = function(l_39_0)
	l_39_0._lua_helper:set_help_text("managers.music:player():stop_now()")
	managers.music:player():stop_now()
end

GameplayApiBox._on_stop_nice = function(l_40_0)
	l_40_0._lua_helper:set_help_text("managers.music:player():stop_nice()")
	managers.music:player():stop_nice()
end

GameplayApiBox._on_pause = function(l_41_0)
	l_41_0._lua_helper:set_help_text("managers.music:player():pause()")
	managers.music:player():pause()
end

GameplayApiBox._on_resume = function(l_42_0)
	l_42_0._lua_helper:set_help_text("managers.music:player():resume()")
	managers.music:player():resume()
end

GameplayApiBox._on_song_selected = function(l_43_0)
	local l_43_1 = l_43_0.song_name_combo:get_value()
	l_43_0._mixer_api:song_selected(l_43_1)
	l_43_0.set_mode_combo:clear()
	local l_43_5, l_43_6 = ipairs, managers.music:get_modes(l_43_1)
	l_43_5 = l_43_5(l_43_6)
	for i_0,i_1 in l_43_5 do
		l_43_0.set_mode_combo:append(l_43_4)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


