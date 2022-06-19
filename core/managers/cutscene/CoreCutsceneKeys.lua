CoreCutsceneKey = CoreCutsceneKey or {
	_classes = {}
}
function CoreCutsceneKey.create(A0_0, A1_1, A2_2)
	return assert(A0_0._classes[A1_1], "Element name \"" .. tostring(A1_1) .. "\" does not match any registered cutscene key type."):new(A2_2)
end
function CoreCutsceneKey.register_class(A0_3, A1_4)
	local L2_5
	L2_5 = require
	L2_5(A1_4)
	L2_5 = assert
	L2_5 = L2_5(string.match(A1_4, ".*[\\/](.*)"), "Malformed class path supplied for cutscene key type.")
	if Application:ews_enabled() then
		assert(rawget(_G, L2_5), "The class should be named like the file.").COLOUR = assert(rawget(_G, L2_5), "The class should be named like the file.").COLOUR or A0_3:next_available_colour()
	end
	CoreCutsceneKey._classes[assert(assert(rawget(_G, L2_5), "The class should be named like the file.").ELEMENT_NAME, "Class does not have required ELEMENT_NAME string member.")] = assert(rawget(_G, L2_5), "The class should be named like the file.")
end
function CoreCutsceneKey.types(A0_6)
	local L1_7, L2_8, L3_9, L4_10, L5_11, L6_12
	L1_7 = {}
	for L5_11, L6_12 in L2_8(L3_9) do
		table.insert(L1_7, L6_12)
	end
	L2_8(L3_9, L4_10)
	return L1_7
end
function CoreCutsceneKey.next_available_colour(A0_13)
	A0_13._colour_index = (A0_13._colour_index or 0) + 1
	if A0_13._colour_index > #A0_13:colour_palette() then
		A0_13._colour_index = 1
	end
	return A0_13:colour_palette()[A0_13._colour_index]
end
function CoreCutsceneKey.colour_palette(A0_14)
	local L1_15
	L1_15 = A0_14._colour_palette
	if L1_15 == nil then
		L1_15 = {
			"468966",
			"FFF0A5",
			"FFB03B",
			"B64926",
			"445878",
			"046380",
			"ADCF4F",
			"4A1A2C",
			"8E3557",
			"CCB689",
			"7EBE74",
			"756D43",
			"664689",
			"A5FFF0",
			"3BFFB0",
			"26B649",
			"784458",
			"800463",
			"4FADCF",
			"2C4A1A",
			"578E35",
			"89CCB6",
			"747EBE",
			"43756D",
			"896646",
			"F0A5FF",
			"B03BFF",
			"4926B6",
			"587844",
			"638004",
			"CF4FAD",
			"1A2C4A",
			"35578E",
			"B689CC",
			"BE747E",
			"6D4375"
		}
		A0_14._colour_palette = table.collect(L1_15, function(A0_16)
			return Color(A0_16)
		end)
	end
	L1_15 = A0_14._colour_palette
	return L1_15
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
