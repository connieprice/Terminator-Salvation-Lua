if not MenuUtility then
	MenuUtility = {}
end
MenuUtility.safe_rect = function()
	local l_1_0 = 1280
	local l_1_1 = 720 * (1.7777778 / core_setup.aspect_ratio)
	local l_1_2 = {}
	l_1_2.w = l_1_0 * tweak_data.SAFE_RECT.x
	l_1_2.h = l_1_1 * tweak_data.SAFE_RECT.y
	l_1_2.x = 0.5 * (l_1_0 - l_1_2.w)
	l_1_2.y = 0.5 * (l_1_1 - l_1_2.h)
	return l_1_2
end


