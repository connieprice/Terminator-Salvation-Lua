OptionSettingsManager = OptionSettingsManager or class({})
OptionSettingsManager._settings_apply_functions = {
	brightness = function(A0_0)
		Application:set_brightness(A0_0)
	end,
	subtitles_enabled = function(A0_1)
		managers.subtitle:set_enabled(A0_1)
		managers.menu._ingame_gui:enable_subtitles(A0_1)
	end
}
OptionSettingsManager._sound_settings_apply_functions = {
	music_volume = function(A0_2)
		managers.volume:set_master_vol("music", A0_2)
	end,
	sfx_volume = function(A0_3)
		OptionSettingsManager:_set_sfx_volume(A0_3)
	end,
	dialogue_volume = function(A0_4)
		managers.volume:set_master_vol("dialogue", A0_4)
	end
}
function OptionSettingsManager.init(A0_5)
	A0_5._set_values = {}
end
function OptionSettingsManager.update(A0_6, A1_7, A2_8)
	local L3_9
	L3_9 = managers
	L3_9 = L3_9.save
	L3_9 = L3_9.primary_profile_is_ready
	L3_9 = L3_9(L3_9)
	if not L3_9 then
		return
	end
	L3_9 = managers
	L3_9 = L3_9.save
	L3_9 = L3_9.profile
	L3_9 = L3_9(L3_9)
	if L3_9 then
		A0_6:set_option_settings(OptionSettingsManager._settings_apply_functions, L3_9)
		A0_6:set_option_settings(OptionSettingsManager._sound_settings_apply_functions, L3_9.sound_settings)
	end
end
function OptionSettingsManager.set_option_settings(A0_10, A1_11, A2_12)
	for 