core:module("CoreMusicEditor2")
core:require_module("CoreStartStopBox")
core:require_module("CoreSongCrossfadeBox")
core:require_module("CoreModeCrossfadeBox")
core:require_module("CoreModeTimingBox")
core:require_module("CoreMarkersBox")
core:require_module("CoreMarkerEditBox")
core:require_module("CoreClipsBox")
core:require_module("CoreModesBox")
core:require_module("CoreSongProject")
core:require_module("CoreSongExporter")
core:require_module("CoreClass")
core:require_module("CoreEvent")
TOOLHUB_NAME = "Music Editor"
if not CoreMusicEditor2 then
	CoreMusicEditor2 = CoreClass.class()
end
CoreMusicEditor2.init = function(l_1_0)
	l_1_0._song_project = nil
	l_1_0._database = ProjectDatabase
	l_1_0:_create_main_frame()
end

CoreMusicEditor2._create_main_frame = function(l_2_0)
	l_2_0._frame = EWS:Frame(TOOLHUB_NAME, Vector3(100, 400, 0), Vector3(690, 470, 0), "FRAME_FLOAT_ON_PARENT,DEFAULT_FRAME_STYLE", Global.frame)
	local l_2_1 = EWS:BoxSizer("VERTICAL")
	local l_2_2 = EWS:SplitterWindow(l_2_0._frame, "", "")
	local l_2_3 = EWS:SplitterWindow(l_2_2, "", "")
	local l_2_4 = EWS:SplitterWindow(l_2_3, "", "")
	local l_2_5 = EWS:Notebook(l_2_0._frame, "", "")
	l_2_0:_create_menu(l_2_0._frame)
	l_2_0._met = {}
	local l_2_6 = l_2_0._met
	local l_2_7, l_2_8 = CoreStartStopBox.StartStopBox:new, CoreStartStopBox.StartStopBox
	local l_2_9 = {}
	l_2_9.parent = l_2_5
	l_2_7 = l_2_7(l_2_8, l_2_9)
	l_2_6.startstop = l_2_7
	l_2_6 = l_2_0._met
	l_2_7 = CoreModeCrossfadeBox
	l_2_7 = l_2_7.ModeCrossfadeBox
	l_2_7, l_2_8 = l_2_7:new, l_2_7
	l_2_7, l_2_9 = l_2_7(l_2_8, l_2_9), {parent = l_2_5}
	l_2_6.modecrossfade = l_2_7
	l_2_6 = l_2_0._met
	l_2_7 = CoreModeTimingBox
	l_2_7 = l_2_7.ModeTimingBox
	l_2_7, l_2_8 = l_2_7:new, l_2_7
	l_2_7, l_2_9 = l_2_7(l_2_8, l_2_9), {parent = l_2_5}
	l_2_6.modetiming = l_2_7
	l_2_6 = l_2_0._met
	l_2_7 = CoreSongCrossfadeBox
	l_2_7 = l_2_7.SongCrossfadeBox
	l_2_7, l_2_8 = l_2_7:new, l_2_7
	l_2_7, l_2_9 = l_2_7(l_2_8, l_2_9), {parent = l_2_5}
	l_2_6.songcrossfade = l_2_7
	l_2_6 = l_2_0._met
	l_2_7 = CoreMarkerEditBox
	l_2_7 = l_2_7.MarkerEditBox
	l_2_7, l_2_8 = l_2_7:new, l_2_7
	l_2_7, l_2_9 = l_2_7(l_2_8, l_2_9), {parent = l_2_3}
	l_2_6.marker_edit = l_2_7
	l_2_6 = l_2_0._met
	l_2_7 = CoreMarkersBox
	l_2_7 = l_2_7.MarkersBox
	l_2_7, l_2_8 = l_2_7:new, l_2_7
	l_2_7, l_2_9 = l_2_7(l_2_8, l_2_9), {parent = l_2_2, marker_edit = l_2_0._met.marker_edit, modecrossfade = l_2_0._met.modecrossfade, main_redraw_cb = CoreEvent.callback(l_2_0, l_2_0, "_global_redraw")}
	l_2_6.markers = l_2_7
	l_2_6 = l_2_0._met
	l_2_7 = CoreClipsBox
	l_2_7 = l_2_7.ClipsBox
	l_2_7, l_2_8 = l_2_7:new, l_2_7
	l_2_7, l_2_9 = l_2_7(l_2_8, l_2_9), {parent = l_2_4, markers = l_2_0._met.markers, marker_edit = l_2_0._met.marker_edit}
	l_2_6.clips = l_2_7
	l_2_6 = l_2_0._met
	l_2_7 = CoreModesBox
	l_2_7 = l_2_7.ModesBox
	l_2_7, l_2_8 = l_2_7:new, l_2_7
	l_2_7, l_2_9 = l_2_7(l_2_8, l_2_9), {parent = l_2_4, clips = l_2_0._met.clips, markers = l_2_0._met.markers, startstop = l_2_0._met.startstop, modetiming = l_2_0._met.modetiming, songcrossfade = l_2_0._met.songcrossfade}
	l_2_6.modes = l_2_7
	l_2_6, l_2_7 = l_2_2:split_vertically, l_2_2
	l_2_8 = l_2_3
	l_2_9 = l_2_0._met
	l_2_9 = l_2_9.markers
	l_2_9 = l_2_9.panel
	l_2_6(l_2_7, l_2_8, l_2_9, "")
	l_2_6, l_2_7 = l_2_2:set_minimum_pane_size, l_2_2
	l_2_8 = 50
	l_2_6(l_2_7, l_2_8)
	l_2_6, l_2_7 = l_2_2:set_sash_gravity, l_2_2
	l_2_8 = 1
	l_2_6(l_2_7, l_2_8)
	l_2_6, l_2_7 = l_2_2:set_sash_position, l_2_2
	l_2_8 = 550
	l_2_9 = true
	l_2_6(l_2_7, l_2_8, l_2_9)
	l_2_6, l_2_7 = l_2_3:split_horizontally, l_2_3
	l_2_8 = l_2_4
	l_2_9 = l_2_0._met
	l_2_9 = l_2_9.marker_edit
	l_2_9 = l_2_9.panel
	l_2_6(l_2_7, l_2_8, l_2_9, "")
	l_2_6, l_2_7 = l_2_3:set_minimum_pane_size, l_2_3
	l_2_8 = 100
	l_2_6(l_2_7, l_2_8)
	l_2_6, l_2_7 = l_2_3:set_sash_gravity, l_2_3
	l_2_8 = 1
	l_2_6(l_2_7, l_2_8)
	l_2_6, l_2_7 = l_2_3:set_sash_position, l_2_3
	l_2_8 = 140
	l_2_9 = true
	l_2_6(l_2_7, l_2_8, l_2_9)
	l_2_6, l_2_7 = l_2_4:split_vertically, l_2_4
	l_2_8 = l_2_0._met
	l_2_8 = l_2_8.modes
	l_2_8 = l_2_8.panel
	l_2_9 = l_2_0._met
	l_2_9 = l_2_9.clips
	l_2_9 = l_2_9.panel
	l_2_6(l_2_7, l_2_8, l_2_9, "")
	l_2_6, l_2_7 = l_2_4:set_minimum_pane_size, l_2_4
	l_2_8 = 50
	l_2_6(l_2_7, l_2_8)
	l_2_6, l_2_7 = l_2_4:set_sash_position, l_2_4
	l_2_8 = 110
	l_2_9 = true
	l_2_6(l_2_7, l_2_8, l_2_9)
	l_2_6, l_2_7 = l_2_5:add_page, l_2_5
	l_2_8 = l_2_0._met
	l_2_8 = l_2_8.startstop
	l_2_8 = l_2_8.panel
	l_2_9 = "Mode Start/Stop"
	l_2_6(l_2_7, l_2_8, l_2_9, true)
	l_2_6, l_2_7 = l_2_5:add_page, l_2_5
	l_2_8 = l_2_0._met
	l_2_8 = l_2_8.modecrossfade
	l_2_8 = l_2_8.panel
	l_2_9 = "Mode Change"
	l_2_6(l_2_7, l_2_8, l_2_9, false)
	l_2_6, l_2_7 = l_2_5:add_page, l_2_5
	l_2_8 = l_2_0._met
	l_2_8 = l_2_8.modetiming
	l_2_8 = l_2_8.panel
	l_2_9 = "Mode Timing"
	l_2_6(l_2_7, l_2_8, l_2_9, false)
	l_2_6, l_2_7 = l_2_5:add_page, l_2_5
	l_2_8 = l_2_0._met
	l_2_8 = l_2_8.songcrossfade
	l_2_8 = l_2_8.panel
	l_2_9 = "Song Change"
	l_2_6(l_2_7, l_2_8, l_2_9, false)
	l_2_6, l_2_7 = l_2_1:add, l_2_1
	l_2_8 = l_2_2
	l_2_9 = 1
	l_2_6(l_2_7, l_2_8, l_2_9, 0, "EXPAND")
	l_2_6, l_2_7 = l_2_1:add, l_2_1
	l_2_8 = l_2_5
	l_2_9 = 0
	l_2_6(l_2_7, l_2_8, l_2_9, 0, "EXPAND")
	l_2_6 = l_2_0._frame
	l_2_6, l_2_7 = l_2_6:set_sizer, l_2_6
	l_2_8 = l_2_1
	l_2_6(l_2_7, l_2_8)
	l_2_6 = l_2_0._frame
	l_2_6, l_2_7 = l_2_6:set_visible, l_2_6
	l_2_8 = true
	l_2_6(l_2_7, l_2_8)
end

CoreMusicEditor2._create_menu = function(l_3_0, l_3_1)
	local l_3_2 = EWS:Menu("")
	l_3_2:append_item("NEW", "New\tCtrl+N", "")
	l_3_2:append_item("OPEN", "Open\tCtrl+O", "")
	l_3_2:append_item("SAVE", "Save (and Export)\tCtrl+S", "")
	l_3_2:append_item("SAVE_AS", "Save As (and Export)", "")
	l_3_2:append_item("EXIT", "Exit", "")
	l_3_0.edit_menu = EWS:Menu("")
	l_3_0.edit_menu:append_item("UNDO", "Undo\tCtrl+Z", "")
	l_3_0.edit_menu:append_item("REDO", "Redo\tCtrl+Y", "")
	l_3_0.edit_menu:set_enabled("UNDO", false)
	l_3_0.edit_menu:set_enabled("REDO", false)
	local l_3_3 = EWS:MenuBar()
	l_3_3:append(l_3_2, "File")
	l_3_3:append(l_3_0.edit_menu, "Edit")
	l_3_1:set_menu_bar(l_3_3)
	l_3_1:connect("NEW", "EVT_COMMAND_MENU_SELECTED", CoreEvent.callback(l_3_0, l_3_0, "_on_new"), "")
	l_3_1:connect("OPEN", "EVT_COMMAND_MENU_SELECTED", CoreEvent.callback(l_3_0, l_3_0, "_on_open"), "")
	l_3_1:connect("SAVE", "EVT_COMMAND_MENU_SELECTED", CoreEvent.callback(l_3_0, l_3_0, "_on_save"), "")
	l_3_1:connect("SAVE_AS", "EVT_COMMAND_MENU_SELECTED", CoreEvent.callback(l_3_0, l_3_0, "_on_save_as"), "")
	l_3_1:connect("EXIT", "EVT_COMMAND_MENU_SELECTED", CoreEvent.callback(l_3_0, l_3_0, "_on_close"), "")
	l_3_1:connect("", "EVT_CLOSE_WINDOW", CoreEvent.callback(l_3_0, l_3_0, "_on_close"), "")
	l_3_1:connect("UNDO", "EVT_COMMAND_MENU_SELECTED", CoreEvent.callback(l_3_0, l_3_0, "_on_undo"), "")
	l_3_1:connect("REDO", "EVT_COMMAND_MENU_SELECTED", CoreEvent.callback(l_3_0, l_3_0, "_on_redo"), "")
end

CoreMusicEditor2.close = function(l_4_0)
	if l_4_0._frame then
		l_4_0._frame:destroy()
	end
	l_4_0._song_project = nil
end

CoreMusicEditor2.set_position = function(l_5_0, l_5_1)
	if l_5_0._frame then
		l_5_0._frame:set_position(l_5_1)
	end
end

CoreMusicEditor2.update = function(l_6_0, l_6_1, l_6_2)
	if l_6_0._song_project_browser and l_6_0._song_project_browser:update(l_6_1, l_6_2) then
		l_6_0._song_project_browser = nil
		l_6_0._frame:set_focus()
	end
end

CoreMusicEditor2._global_redraw = function(l_7_0, l_7_1)
	l_7_0._met.modes:global_redraw(l_7_1)
	l_7_0._met.clips:global_redraw(l_7_1)
	l_7_0._met.markers:global_redraw(l_7_1)
	l_7_0._met.marker_edit:global_redraw(l_7_1)
	l_7_0._met.startstop:global_redraw(l_7_1)
	l_7_0._met.modecrossfade:global_redraw(l_7_1)
	l_7_0._met.modetiming:global_redraw(l_7_1)
	l_7_0._met.songcrossfade:global_redraw(l_7_1)
end

CoreMusicEditor2._on_close = function(l_8_0)
	if l_8_0:_ok_loose_data() then
		managers.toolhub:close(TOOLHUB_NAME)
	end
end

CoreMusicEditor2._on_new = function(l_9_0)
	if l_9_0:_ok_loose_data() then
		local l_9_1, l_9_2 = CoreSongProject.SongProject:new, CoreSongProject.SongProject
		local l_9_3 = {}
		l_9_3.song_modified_cb = CoreEvent.callback(l_9_0, l_9_0, "_on_song_project_modified")
		l_9_1 = l_9_1(l_9_2, l_9_3)
		l_9_0._song_project = l_9_1
		l_9_0._open_entry = nil
		l_9_1, l_9_2 = l_9_0:_on_song_project_modified, l_9_0
		l_9_1(l_9_2)
		l_9_1, l_9_2 = l_9_0:_global_redraw, l_9_0
		l_9_3 = l_9_0._song_project
		l_9_1(l_9_2, l_9_3)
	end
end

CoreMusicEditor2._on_open = function(l_10_0)
	if l_10_0:_ok_loose_data() then
		l_10_0._song_project_browser = _G.CoreDBDialog:new("song_project", l_10_0, l_10_0._open_song_project, l_10_0._database)
	end
end

CoreMusicEditor2._open_song_project = function(l_11_0)
	l_11_0._open_entry = l_11_0._song_project_browser:get_value()
	assert(l_11_0._open_entry:valid())
	local l_11_1 = l_11_0._database:load_node(l_11_0._open_entry)
	local l_11_2, l_11_3 = CoreSongProject.SongProject:new, CoreSongProject.SongProject
	local l_11_4 = {}
	l_11_4.node = l_11_1
	l_11_4.song_modified_cb = CoreEvent.callback(l_11_0, l_11_0, "_on_song_project_modified")
	l_11_2 = l_11_2(l_11_3, l_11_4)
	l_11_0._song_project = l_11_2
	l_11_2, l_11_3 = l_11_0:_on_song_project_modified, l_11_0
	l_11_2(l_11_3)
	l_11_2, l_11_3 = l_11_0:_global_redraw, l_11_0
	l_11_4 = l_11_0._song_project
	l_11_2(l_11_3, l_11_4)
end

CoreMusicEditor2._ok_loose_data = function(l_12_0)
	if not l_12_0._song_project or l_12_0._song_project:get_number_undo() <= 0 and l_12_0._song_project:get_number_redo() > 0 then
		local l_12_9 = nil
		local l_12_10 = nil
		return EWS:MessageDialog(l_12_0._frame, "You have unsaved changes, continue and loose information?", "Unsaved Data", ""):show_modal() == "ID_OK"
	end
	return true
end

CoreMusicEditor2._on_save = function(l_13_0)
	if l_13_0._song_project then
		if l_13_0._open_entry == nil then
			l_13_0:_on_save_as()
		end
	else
		local l_13_1 = l_13_0._song_project:get_song()
		l_13_0._database:save_node(l_13_1, l_13_0._open_entry)
		l_13_0._database:save()
		l_13_0._song_project:clear_undo()
		l_13_0:_export()
	end
end

CoreMusicEditor2._on_save_as = function(l_14_0)
	if l_14_0._song_project then
		local l_14_1 = ""
		if l_14_0._open_entry then
			l_14_1 = l_14_0._open_entry:name()
		end
		while 1 do
			local l_14_2 = false
			while 1 do
				while 1 do
					if not l_14_2 then
						l_14_1 = EWS:get_text_from_user(l_14_0._frame, "Enter new Song Project name:", "Save as", l_14_1, Vector3(-1, -1, 0), true)
						if l_14_1 == nil or l_14_1 == "" then
							return 
						end
						local l_14_3 = "OBS!\n"
						l_14_3 = l_14_3 .. "For each Song Project there will be a Song\n"
						l_14_3 = l_14_3 .. "with the same name created when the Song project is Exported.\n"
						local l_14_4 = false
						if l_14_0._database:has("song_project", l_14_1) then
							l_14_3 = string.format("%s\nSong Project '%s' already exist in database, overwrite?\n", l_14_3, l_14_1)
							l_14_4 = true
						end
						if l_14_0._database:has("song", l_14_1) then
							l_14_3 = string.format("%s\nSong '%s' already exist in database, overwrite on Export?\n", l_14_3, l_14_1)
							l_14_4 = true
						end
						if l_14_4 and EWS:MessageDialog(l_14_0._frame, l_14_3, "Overwrite?", ""):show_modal() == "ID_OK" then
							l_14_2 = true
						end
					end
					l_14_2 = true
				end
				if l_14_0._database:has("song_project", l_14_1) then
					l_14_0._open_entry = l_14_0._database:lookup("song_project", l_14_1)
				else
					l_14_0._open_entry = l_14_0._database:add("song_project", l_14_1, {}, "xml")
				end
				local l_14_5 = l_14_0._song_project:get_song()
				l_14_0._database:save_node(l_14_5, l_14_0._open_entry)
				l_14_0._database:save()
				l_14_0._song_project:clear_undo()
				l_14_0:_export()
			end
			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

CoreMusicEditor2._export = function(l_15_0)
	local l_15_9, l_15_10, l_15_11 = nil
	local l_15_1 = (l_15_0._open_entry:name())
	local l_15_2 = nil
	if l_15_0._database:has("song", l_15_1) then
		l_15_2 = l_15_0._database:lookup("song", l_15_1)
	else
		l_15_2 = l_15_0._database:add("song", l_15_1, {}, "xml")
	end
	local l_15_3 = CoreSongExporter.SongExporter:new(l_15_0._song_project, l_15_0._database)
	local l_15_4 = l_15_3:export(l_15_2)
	if l_15_4 and #l_15_4 > 0 then
		local l_15_5 = "Your Song was saved, but not Exported. Please Correct the following problems and try again:\n\n"
		for i_0,i_1 in pairs(l_15_4) do
			l_15_5 = l_15_5 .. i_0 .. ":" .. i_1 .. "\n\n"
		end
		EWS:MessageDialog(l_15_0._frame, l_15_5, "Export Error", ""):show_modal()
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreMusicEditor2._on_undo = function(l_16_0)
	if l_16_0._song_project ~= nil then
		l_16_0._song_project:undo()
		l_16_0:_global_redraw()
	end
end

CoreMusicEditor2._on_redo = function(l_17_0)
	if l_17_0._song_project ~= nil then
		l_17_0._song_project:redo()
		l_17_0:_global_redraw()
	end
end

CoreMusicEditor2._on_song_project_modified = function(l_18_0)
	local l_18_1 = false
	local l_18_2 = false
	local l_18_3 = "<new song project>"
	local l_18_4 = ""
	if l_18_0._song_project:get_number_undo() <= 0 then
		l_18_1 = l_18_0._song_project == nil
	end
	l_18_2 = l_18_0._song_project:get_number_redo() > 0
	if l_18_0._open_entry then
		l_18_3 = l_18_0._open_entry:name()
	end
	if l_18_1 or l_18_2 then
		l_18_4 = "*"
	end
	l_18_0.edit_menu:set_enabled("UNDO", l_18_1)
	l_18_0.edit_menu:set_enabled("REDO", l_18_2)
	l_18_0._frame:set_title(string.format("%s - [%s%s]", TOOLHUB_NAME, l_18_4, l_18_3))
end


