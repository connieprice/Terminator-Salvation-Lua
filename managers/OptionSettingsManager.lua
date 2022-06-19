if not OptionSettingsManager then
	OptionSettingsManager = class({})
end
local l_0_0 = OptionSettingsManager
local l_0_1 = {}
l_0_1.brightness = function(l_1_0)
	Application:set_brightness(l_1_0)
end

l_0_1.subtitles_enabled = function(l_2_0)
	managers.subtitle:set_enabled(l_2_0)
	managers.menu._ingame_gui:enable_subtitles(l_2_0)
end

l_0_0._settings_apply_functions = l_0_1
l_0_0 = OptionSettingsManager
l_0_0._sound_settings_apply_functions, l_0_1 = l_0_1, {music_volume = function(l_3_0)
	managers.volume:set_master_vol("music", l_3_0)
end
, sfx_volume = function(l_4_0)
	OptionSettingsManager:_set_sfx_volume(l_4_0)
end
, dialogue_volume = function(l_5_0)
	managers.volume:set_master_vol("dialogue", l_5_0)
end
}
l_0_0 = OptionSettingsManager
l_0_1 = function(l_6_0)
	l_6_0._set_values = {}
end

l_0_0.init = l_0_1
l_0_0 = OptionSettingsManager
l_0_1 = function(l_7_0, l_7_1, l_7_2)
	if not managers.save:primary_profile_is_ready() then
		return 
	end
	local l_7_3 = managers.save:profile()
	if l_7_3 then
		l_7_0:set_option_settings(OptionSettingsManager._settings_apply_functions, l_7_3)
		l_7_0:set_option_settings(OptionSettingsManager._sound_settings_apply_functions, l_7_3.sound_settings)
	end
end

l_0_0.update = l_0_1
l_0_0 = OptionSettingsManager
l_0_1 = function(l_8_0, l_8_1, l_8_2)
	local l_8_6, l_8_7, l_8_8, l_8_9, l_8_10, l_8_11, l_8_12, l_8_13, l_8_14 = nil
	for i_0,i_1 in pairs(l_8_1) do
		if l_8_0._set_values[i_0] ~= l_8_2[i_0] then
			l_8_0._set_values[i_0] = l_8_2[i_0]
			l_8_1[i_0](l_8_2[i_0])
		end
	end
end

l_0_0.set_option_settings = l_0_1
l_0_0 = OptionSettingsManager
l_0_1 = function(l_9_0, l_9_1)
	managers.volume:set_master_vol("foley", l_9_1)
	managers.volume:set_master_vol("sfx", l_9_1)
	managers.volume:set_master_vol("pfx", l_9_1)
	managers.volume:set_master_vol("gunfire", l_9_1)
	managers.volume:set_master_vol("ambience", l_9_1)
	managers.volume:set_master_vol("ui", l_9_1)
	managers.volume:set_master_vol("menu", l_9_1)
	managers.volume:set_master_vol("cutscene", l_9_1)
	managers.volume:set_master_vol("menu_only", l_9_1)
	managers.volume:set_master_vol("stingers", l_9_1)
	managers.volume:set_master_vol("bink", l_9_1)
end

l_0_0._set_sfx_volume = l_0_1

