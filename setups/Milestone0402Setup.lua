Milestone0402Setup = Milestone0402Setup or class()
function Milestone0402Setup.init(A0_0)
	local L1_1
	L1_1 = {}
	L1_1.default = "high"
	L1_1.gui = "high"
	L1_1.character = "high"
	L1_1.vehicle = "high"
	L1_1.weapon = "high"
	L1_1.cover = "high"
	L1_1.architecture = "high"
	L1_1.backdrop = "high"
	L1_1.vegetation = "high"
	L1_1.alpha = "high"
	L1_1.rail = "high"
	L1_1.tint = "high"
	L1_1.nm = "high"
	L1_1.vehicles_df = "high"
	L1_1.vehicles_gsm = "high"
	L1_1.vehicles_nm = "high"
	A0_0:set_render_settings(L1_1)
end
function Milestone0402Setup.set_render_settings(A0_2, A1_3)
	local L2_4, L3_5, L4_6, L5_7, L6_8, L7_9
	for L5_7, L6_8 in L2_4(L3_5) do
		L7_9 = "texture_quality_"
		L7_9 = L7_9 .. L5_7
		RenderSettings[L7_9] = L6_8
		cat_print("debug", "Setting render setting ", L7_9, " to ", L6_8)
	end
end
