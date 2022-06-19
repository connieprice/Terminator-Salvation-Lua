if not AMVolumeSet then
	AMVolumeSet = class(CoreActionElement)
end
AMVolumeSet.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMVolumeSet.activate_now = function(l_2_0)
	if l_2_0._mode == "activate" then
		managers.volume:activate_set(l_2_0.volume_set)
	elseif l_2_0._mode == "deactivate" then
		managers.volume:deactivate_set(l_2_0.volume_set)
	end
	l_2_0:deactivate_now()
end


