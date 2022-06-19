require("menu/OverlayGui")
require("menu/ingame/IntroCredits")
require("menu/ingame/ChapterText")
require("menu/ingame/IoIconPanel")
require("units/beings/player/new_gui/TutorialPanel")
require("units/beings/player/new_gui/HudUtility")
require("units/beings/player/new_gui/MissionObjectivePanel")
require("units/beings/player/gui/Subtitles")
require("units/beings/player_tank/gui/BackgroundPanel")
IngameGui = IngameGui or class(OverlayGui)
function IngameGui.init(A0_0)
	OverlayGui.init(A0_0)
	A0_0:_preload_textures()
end
function IngameGui._setup_resources(A0_1)
	OverlayGui._setup_resources(A0_1)
	A0_1._full_screen_panel = A0_1._workspace:panel({valign = "grow", halign = "grow"})
	A0_1._safe_panel = A0_1._full_screen_panel:panel({
		name = "safe_panel",
		valign = "grow",
		halign = "grow"
	})
	A0_1._safe_panel:set_shape(A0_1:safe_rect().x, A0_1:safe_rect().y, A0_1:safe_rect().w, A0_1:safe_rect().h)
	A0_1._save_panel = IoIconPanel:new(A0_1._safe_panel, "gui_saving_icon", tweak_data.player.new_hud.io_icon_panel.SAVE_SPIN_SPEED)
	A0_1._load_panel = IoIconPanel:new(A0_1._safe_panel, "gui_loading_icon", tweak_data.player.new_hud.io_icon_panel.LOAD_SPIN_SPEED)
	A0_1._shared_components_full_screen_panel = A0_1._full_screen_panel:panel({valign = "grow", halign = "grow"})
	A0_1._shared_components_safe_panel = A0_1._safe_panel:panel({valign = "grow", halign = "grow"})
	A0_1._tank_background_panel = BackgroundPanel:new(A0_1._full_screen_panel)
	A0_1._subtitles = Subtitles:new(A0_1._shared_components_safe_panel)
	A0_1._tutorial_panel = TutorialPanel:new(A0_1._shared_components_full_screen_panel, A0_1._safe_panel)
	A0_1._mission_obj_panel = MissionObjectivePanel:new(A0_1._shared_components_full_screen_panel, A0_1._safe_panel)
end
function IngameGui._shutdown_resources(A0_2)
	if A0_2._chapter_text then
		A0_2:hide_chapter_text()
	end
	OverlayGui._shutdown_resources(A0_2)
end
function IngameGui._preload_textures(A0_3)
	local L1_4, L2_5, L3_6, L4_7, L5_8, L6_9
	L1_4 = Overlay
	L1_4 = L1_4.gui
	L1_4 = L1_4(L2_5)
	L1_4 = L1_4.preload_font
	L1_4(L2_5, L3_6)
	L1_4 = {
		L2_5,
		L3_6,
		L4_7,
		L5_8,
		L6_9,
		"gui_tutorial_photo_spider1",
		"gui_tutorial_photo_spider2",
		"gui_tutorial_photo_blindfire",
		"gui_tutorial_photo_grenade",
		"gui_tutorial_note_ammo",
		"gui_tutorial_note_flanking",
		"gui_tutorial_photo_spider",
		"gui_tutorial_photo_flare",
		"gui_tutorial_photo_quickmove",
		"gui_tutorial_photo_quickmove_2",
		"gui_tutorial_note_quickmove_icon",
		"gui_tutorial_photo_rpg",
		"gui_tutorial_note_grenade",
		"gui_saving_icon",
		"gui_loading_icon",
		"gui_saving_hilight",
		"gui_mission_objectivebox_completed",
		"gui_mission_objectivebox_not_completed",
		"gui_screenborder_filter"
	}
	L5_8 = "gui_tutorial_photo_switchweapons"
	L6_9 = "gui_tutorial_photo_takeweapon"
	for L5_8, L6_9 in L2_5(L3_6) do
		Overlay:gui():preload_texture(L6_9)
	end
end
function IngameGui.show_chapter_text(A0_10, A1_11)
	assert(not A0_10._chapter_text)
	A0_10._chapter_text = ChapterText:new(A0_10._shared_components_safe_panel, A1_11)
end
function IngameGui.hide_chapter_text(A0_12)
	assert(A0_12._chapter_text)
	A0_12._chapter_text:destroy()
	A0_12._chapter_text = nil
end
function IngameGui.enable_subtitles(A0_13, A1_14)
	A0_13._subtitles:enable_subtitles(A1_14)
end
function IngameGui._common_update(A0_15, A1_16)
	OverlayGui.update(A0_15, A1_16)
	if A0_15._save_panel:next_update(A1_16) then
		if managers.save:is_busy_saving() then
			A0_15._save_panel:show()
		else
			A0_15._save_panel:hide()
		end
		if A0_15._save_panel:visible() then
			A0_15._save_panel:update(A1_16)
		else
			A0_15._save_panel:use_low_frequency_update(A1_16)
		end
	end
	if A0_15._load_panel:next_update(A1_16) then
		if managers.save:is_busy_loading() then
			A0_15._load_panel:show()
		else
			A0_15._load_panel:hide()
		end
		if A0_15._load_panel:visible() then
			A0_15._load_panel:update(A1_16)
		else
			A0_15._load_panel:use_low_frequency_update(A1_16)
		end
	end
end
function IngameGui.update(A0_17, A1_18)
	A0_17:_common_update(A1_18)
	if managers.game:is_paused() or managers.game:is_frozen() then
		if not A0_17._hidden then
			A0_17:_hide_ingame_gui()
			A0_17._hidden = true
		end
	else
		if A0_17._hidden then
			A0_17:_show_ingame_gui()
			A0_17._hidden = false
		end
		if A0_17._subtitles then
			A0_17._subtitles:update(A1_18)
		end
		if managers.game:is_in_game() and A0_17._chapter_text and A0_17._chapter_text:update(A1_18) then
			A0_17:hide_chapter_text()
		end
		A0_17:_update_user_interaction(A1_18)
		A0_17:_update_mission_objectives(A1_18)
		if managers.worldcamera:current_world_camera() then
			if not A0_17._cutscene_hidden then
				A0_17:_hide_ingame_gui_cutscene()
				A0_17._cutscene_hidden = true
			end
		else
			A0_17:_update_tutorial_panel(A1_18)
			A0_17._cutscene_hidden = false
		end
		if managers.tank_display:is_active() then
			A0_17:_update_tank_background_panel(A1_18)
		end
	end
end
function IngameGui._update_tutorial_panel(A0_19, A1_20)
	local L2_21
	L2_21 = A0_19._tutorial_panel
	L2_21 = L2_21.next_update
	L2_21 = L2_21(L2_21, A1_20)
	if L2_21 then
		L2_21 = managers
		L2_21 = L2_21.tutorial
		L2_21 = L2_21.get_current_tutorial
		L2_21 = L2_21(L2_21)
		if L2_21 then
			if HudUtility.is_split_screen() then
				A0_19._tutorial_panel:use_splitscreen_position()
			else
				A0_19._tutorial_panel:use_single_player_position()
			end
			if not managers.localizer_mapping:skip_tutorial(L2_21) then
				A0_19._tutorial_panel:show(L2_21)
				A0_19._tutorial_panel:update(A1_20)
			end
		elseif A0_19._tutorial_panel:visible() then
			A0_19._tutorial_panel:hide()
			A0_19._tutorial_panel:update(A1_20)
		else
			A0_19._tutorial_panel:use_low_frequency_update()
		end
	end
end
function IngameGui._update_mission_objectives(A0_22, A1_23)
	local L2_24, L3_25
	L2_24 = A0_22._mission_obj_panel
	L3_25 = L2_24
	L2_24 = L2_24.next_update
	L2_24 = L2_24(L3_25, A1_23)
	if L2_24 then
		L2_24 = next
		L3_25 = managers
		L3_25 = L3_25.assigned_mission_objective
		L3_25 = L3_25.assigned_objectives
		L3_25 = L3_25(L3_25)
		L3_25 = L2_24(L3_25, L3_25(L3_25))
		if L3_25 then
			A0_22._mission_obj_panel:show(L3_25)
			if HudUtility.is_split_screen() then
				A0_22._mission_obj_panel:use_splitscreen_position()
			else
				A0_22._mission_obj_panel:use_single_player_position()
			end
		end
		if A0_22._show_current_mission_objective then
			A0_22._mission_obj_panel:show_current_mission_objective()
		elseif not A0_22._show_current_mission_objective then
			A0_22._mission_obj_panel:hide_current_mission_objective()
			A0_22._current_mission_objective_is_showing = false
		end
		if A0_22._mission_obj_panel:have_mission_objective() then
			A0_22._mission_obj_panel:update(A1_23)
		end
		if not A0_22._mission_obj_panel:visible() then
			A0_22._mission_obj_panel:use_low_frequency_update()
		end
	end
end
function IngameGui._update_tank_background_panel(A0_26, A1_27)
	if not A0_26._startup_initated and managers.tank_display:wants_to_startup() then
		A0_26._tank_background_panel:startup(0, 1)
		A0_26._startup_initated = true
	end
	if A0_26._startup_initated and not A0_26._startup_done then
		A0_26._startup_done = A0_26._tank_background_panel.startup_done
		if A0_26._startup_done then
			managers.tank_display:set_startup_done()
		end
	end
	if not A0_26._shuting_down and managers.tank_display:wants_to_shutdown() then
		A0_26._tank_background_panel:shutdown(1.5, false)
		A0_26._shuting_down = true
	end
	if A0_26._startup_initated and not A0_26._startup_done or A0_26._shuting_down then
		A0_26._tank_background_panel:update(A1_27)
	end
end
function IngameGui.full_screen_panel(A0_28)
	local L1_29
	L1_29 = A0_28._full_screen_panel
	return L1_29
end
function IngameGui.use_normal_font(A0_30)
	A0_30._subtitles:use_normal_font()
end
function IngameGui.use_small_font(A0_31)
	A0_31._subtitles:use_small_font()
end
function IngameGui._hide_ingame_gui(A0_32)
	A0_32._shared_components_full_screen_panel:hide()
	A0_32._shared_components_safe_panel:hide()
end
function IngameGui._show_ingame_gui(A0_33)
	A0_33._shared_components_full_screen_panel:show()
	A0_33._shared_components_safe_panel:show()
	if managers.tank_display:is_active() then
		A0_33._tank_background_panel:show()
	end
end
function IngameGui._hide_ingame_gui_cutscene(A0_34)
	HudUtility.hide_panel(A0_34._tutorial_panel:panel(), true)
end
function IngameGui._update_user_interaction(A0_35)
	local L1_36
	L1_36 = managers
	L1_36 = L1_36.local_user
	L1_36 = L1_36.users
	L1_36 = L1_36(L1_36)
	for 