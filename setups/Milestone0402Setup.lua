if not Milestone0402Setup then
	Milestone0402Setup = class()
end
Milestone0402Setup.init = function(l_1_0)
	local l_1_1 = {}
	l_1_1.default = "high"
	l_1_1.gui = "high"
	l_1_1.character = "high"
	l_1_1.vehicle = "high"
	l_1_1.weapon = "high"
	l_1_1.cover = "high"
	l_1_1.architecture = "high"
	l_1_1.backdrop = "high"
	l_1_1.vegetation = "high"
	l_1_1.alpha = "high"
	l_1_1.rail = "high"
	l_1_1.tint = "high"
	l_1_1.nm = "high"
	l_1_1.vehicles_df = "high"
	l_1_1.vehicles_gsm = "high"
	l_1_1.vehicles_nm = "high"
	l_1_0:set_render_settings(l_1_1)
end

Milestone0402Setup.set_render_settings = function(l_2_0, l_2_1)
	local l_2_5, l_2_6, l_2_7 = nil
	for i_0,i_1 in pairs(l_2_1) do
		RenderSettings["texture_quality_" .. i_0] = i_1
		 -- DECOMPILER ERROR: Confused about usage of registers!

		cat_print("debug", "Setting render setting ", "texture_quality_" .. i_0, " to ", i_1)
	end
end


