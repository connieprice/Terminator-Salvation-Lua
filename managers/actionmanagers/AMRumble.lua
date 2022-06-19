AMRumble = AMRumble or class(CoreActionElement)
function AMRumble.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
end
function AMRumble.activate_now(A0_3)
	managers.rumble:play(A0_3.preset, A0_3.position)
	if A0_3.camera_shake then
		for 