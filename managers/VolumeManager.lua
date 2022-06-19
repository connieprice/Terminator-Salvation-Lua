VolumeManager = VolumeManager or class(CoreVolumeManager)
VolumeManager._category_pause_exclusions = {
	menu = true,
	menu_only = true,
	music = true,
	stingers = true
}
function VolumeManager.init(A0_0, ...)
	local L2_2, L3_3, L4_4, L5_5
	L5_5 = ...
	L2_2(L3_3, L4_4, L5_5, ...)
	A0_0._paused_category_list = L2_2
	for L5_5, 