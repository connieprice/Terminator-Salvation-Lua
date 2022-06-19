local L0_0
L0_0 = MenuUtility
L0_0 = L0_0 or {}
MenuUtility = L0_0
L0_0 = MenuUtility
function L0_0.safe_rect()
	local L0_1, L1_2, L2_3, L3_4
	L0_1 = 1280
	L1_2 = core_setup
	L1_2 = L1_2.aspect_ratio
	L1_2 = 1.7777778 / L1_2
	L1_2 = 720 * L1_2
	L2_3 = {}
	L3_4 = tweak_data
	L3_4 = L3_4.SAFE_RECT
	L3_4 = L3_4.x
	L3_4 = L0_1 * L3_4
	L2_3.w = L3_4
	L3_4 = tweak_data
	L3_4 = L3_4.SAFE_RECT
	L3_4 = L3_4.y
	L3_4 = L1_2 * L3_4
	L2_3.h = L3_4
	L3_4 = L2_3.w
	L3_4 = L0_1 - L3_4
	L3_4 = 0.5 * L3_4
	L2_3.x = L3_4
	L3_4 = L2_3.h
	L3_4 = L1_2 - L3_4
	L3_4 = 0.5 * L3_4
	L2_3.y = L3_4
	return L2_3
end
