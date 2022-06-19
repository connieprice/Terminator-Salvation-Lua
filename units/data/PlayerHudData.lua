if not PlayerHudData then
	PlayerHudData = class()
end
PlayerHudData.init = function(l_1_0, l_1_1)
	l_1_0._default_reticule_type = "circle_reticule"
end

PlayerHudData.texture_name = function(l_2_0)
	return l_2_0._texture_name
end

PlayerHudData.small_texture_name = function(l_3_0)
	return l_3_0._small_texture_name
end

PlayerHudData.reticule_type = function(l_4_0)
	if not l_4_0._reticule_type then
		return l_4_0._default_reticule_type
	end
end


