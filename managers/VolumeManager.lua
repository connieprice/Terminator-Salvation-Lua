if not VolumeManager then
	VolumeManager = class(CoreVolumeManager)
end
local l_0_0 = VolumeManager
local l_0_1 = {}
l_0_1.menu = true
l_0_1.menu_only = true
l_0_1.music = true
l_0_1.stingers = true
l_0_0._category_pause_exclusions = l_0_1
l_0_0 = VolumeManager
l_0_1 = function(l_1_0, ...)
	local l_1_4, l_1_5 = CoreVolumeManager.init, l_1_0
	l_1_4(l_1_5, ...)
	l_1_0._paused_category_list, l_1_4 = l_1_4, {}
	l_1_4 = pairs
	l_1_5 = l_1_0._categories
	l_1_4 = l_1_4(l_1_5)
	for i_0,i_1 in l_1_4 do
		if not l_1_0._category_pause_exclusions[l_1_3] then
			table.insert(l_1_0._paused_category_list, l_1_3)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.init = l_0_1
l_0_0 = VolumeManager
l_0_1 = function(l_2_0, l_2_1, l_2_2)
	if l_2_0:is_active("game_over") and l_2_1 ~= "pause" then
		return 
	end
	CoreVolumeManager.activate_set(l_2_0, l_2_1, l_2_2)
end

l_0_0.activate_set = l_0_1

