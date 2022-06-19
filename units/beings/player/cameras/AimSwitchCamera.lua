require("shared/camera/SharedCamera")
AimSwitchCamera = AimSwitchCamera or class(SwitchCamera)
function AimSwitchCamera.init(A0_0, A1_1)
	SwitchCamera.init(A0_0, A1_1)
end
function AimSwitchCamera.activate(A0_2)
	SwitchCamera.activate(A0_2)
	A0_2:switch_to_camera("follow")
end
function AimSwitchCamera._set_root_unit(A0_3, A1_4, A2_5)
	SharedCamera._set_root_unit(A0_3, A1_4, A2_5)
	A0_3._player_data = A2_5:player_data()
end
function AimSwitchCamera.update(A0_6, A1_7, A2_8, A3_9)
	SwitchCamera.update(A0_6, A1_7, A2_8, A3_9)
	if not A0_6._player_data then
		return
	end
	if A0_6._player_data.is_precision_aiming and not A0_6._is_precision_aiming then
		A0_6:switch_to_camera("aiming")
		A0_6._is_precision_aiming = true
	elseif not A0_6._player_data.is_precision_aiming and A0_6._is_precision_aiming then
		A0_6:switch_to_camera("follow")
		A0_6._is_precision_aiming = false
	end
end
