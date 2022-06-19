if not CoreCutsceneKey then
	local l_0_0 = {}
	l_0_0._classes = {}
end
 -- DECOMPILER ERROR: Confused about usage of registers!

CoreCutsceneKey = l_0_0
CoreCutsceneKey.create = function(l_1_0, l_1_1, l_1_2)
	local l_1_6 = assert
	local l_1_7 = l_1_0._classes[l_1_1]
	l_1_6 = l_1_6(l_1_7, "Element name \"" .. tostring(l_1_1) .. "\" does not match any registered cutscene key type.")
	l_1_6, l_1_7 = l_1_6:new, l_1_6
	local l_1_3, l_1_4 = nil
	l_1_3 = l_1_2
	local l_1_5 = nil
	return l_1_6(l_1_7, l_1_3)
end

CoreCutsceneKey.register_class = function(l_2_0, l_2_1)
	require(l_2_1)
	local l_2_2 = assert(string.match(l_2_1, ".*[\\/](.*)"), "Malformed class path supplied for cutscene key type.")
	local l_2_3 = assert(rawget(_G, l_2_2), "The class should be named like the file.")
	local l_2_4 = assert(l_2_3.ELEMENT_NAME, "Class does not have required ELEMENT_NAME string member.")
	if Application:ews_enabled() and not l_2_3.COLOUR then
		l_2_3.COLOUR = l_2_0:next_available_colour()
	end
	CoreCutsceneKey._classes[l_2_4] = l_2_3
end

CoreCutsceneKey.types = function(l_3_0)
	local l_3_5, l_3_6, l_3_7, l_3_8 = nil
	local l_3_1 = {}
	for i_0,i_1 in pairs(l_3_0._classes) do
		table.insert(l_3_1, i_1)
	end
	table.sort(l_3_1, function(l_4_0, l_4_1)
		return l_4_0.NAME < l_4_1.NAME
  end)
	return l_3_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutsceneKey.next_available_colour = function(l_4_0)
	l_4_0._colour_index = (l_4_0._colour_index or 0) + 1
	if #l_4_0:colour_palette() < l_4_0._colour_index then
		l_4_0._colour_index = 1
	end
	return l_4_0:colour_palette()[l_4_0._colour_index]
end

CoreCutsceneKey.colour_palette = function(l_5_0)
	if l_5_0._colour_palette == nil then
		local l_5_1 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

	end
	return l_5_0._colour_palette
	 -- WARNING: undefined locals caused missing assignments!
end

CoreCutsceneKey:register_class("core/managers/cutscene/keys/CoreChangeCameraAttributeCutsceneKey")
CoreCutsceneKey:register_class("core/managers/cutscene/keys/CoreChangeCameraCutsceneKey")
CoreCutsceneKey:register_class("core/managers/cutscene/keys/CoreChangeEnvCutsceneKey")
CoreCutsceneKey:register_class("core/managers/cutscene/keys/CoreDepthOfFieldCutsceneKey")
CoreCutsceneKey:register_class("core/managers/cutscene/keys/CoreDiscontinuityCutsceneKey")
CoreCutsceneKey:register_class("core/managers/cutscene/keys/CoreGuiCallbackCutsceneKey")
CoreCutsceneKey:register_class("core/managers/cutscene/keys/CoreGuiCutsceneKey")
CoreCutsceneKey:register_class("core/managers/cutscene/keys/CoreLocatorConstraintCutsceneKey")
CoreCutsceneKey:register_class("core/managers/cutscene/keys/CoreObjectVisibleCutsceneKey")
CoreCutsceneKey:register_class("core/managers/cutscene/keys/CoreOverlayFXCutsceneKey")
CoreCutsceneKey:register_class("core/managers/cutscene/keys/CoreSequenceCutsceneKey")
CoreCutsceneKey:register_class("core/managers/cutscene/keys/CoreShakeCameraCutsceneKey")
CoreCutsceneKey:register_class("core/managers/cutscene/keys/CoreSimpleAnimationCutsceneKey")
CoreCutsceneKey:register_class("core/managers/cutscene/keys/CoreSoundCutsceneKey")
CoreCutsceneKey:register_class("core/managers/cutscene/keys/CoreSpawnUnitCutsceneKey")
CoreCutsceneKey:register_class("core/managers/cutscene/keys/CoreSubtitleCutsceneKey")
CoreCutsceneKey:register_class("core/managers/cutscene/keys/CoreTimerSpeedCutsceneKey")
CoreCutsceneKey:register_class("core/managers/cutscene/keys/CoreUnitCallbackCutsceneKey")
CoreCutsceneKey:register_class("core/managers/cutscene/keys/CoreUnitVisibleCutsceneKey")
CoreCutsceneKey:register_class("core/managers/cutscene/keys/CoreVideoCutsceneKey")
CoreCutsceneKey:register_class("core/managers/cutscene/keys/CoreVisualFXCutsceneKey")
CoreCutsceneKey:register_class("core/managers/cutscene/keys/CoreVolumeSetCutsceneKey")
CoreCutsceneKey:register_class("core/managers/cutscene/keys/CoreZoomCameraCutsceneKey")
CoreCutsceneKey:register_class("core/managers/cutscene/keys/CoreChangeShadowCutsceneKey")
CoreCutsceneKey:register_class("core/managers/cutscene/keys/CoreLightGroupCutsceneKey")

