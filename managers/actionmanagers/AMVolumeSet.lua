AMVolumeSet = AMVolumeSet or class(CoreActionElement)
function AMVolumeSet.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
end
function AMVolumeSet.activate_now(A0_3)
	if A0_3._mode == "activate" then
		managers.volume:activate_set(A0_3.volume_set)
	elseif A0_3._mode == "deactivate" then
		managers.volume:deactivate_set(A0_3.volume_set)
	end
	A0_3:deactivate_now()
end
