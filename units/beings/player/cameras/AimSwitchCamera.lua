require("shared/camera/SharedCamera")
if not AimSwitchCamera then
	AimSwitchCamera = class(SwitchCamera)
end
AimSwitchCamera.init = function(l_1_0, l_1_1)
	SwitchCamera.init(l_1_0, l_1_1)
end

AimSwitchCamera.activate = function(l_2_0)
	SwitchCamera.activate(l_2_0)
	l_2_0:switch_to_camera("follow")
end

AimSwitchCamera._set_root_unit = function(l_3_0, l_3_1, l_3_2)
	SharedCamera._set_root_unit(l_3_0, l_3_1, l_3_2)
	l_3_0._player_data = l_3_2:player_data()
end

AimSwitchCamera.update = function(l_4_0, l_4_1, l_4_2, l_4_3)
	SwitchCamera.update(l_4_0, l_4_1, l_4_2, l_4_3)
	if not l_4_0._player_data then
		return 
	end
	if l_4_0._player_data.is_precision_aiming and not l_4_0._is_precision_aiming then
		l_4_0:switch_to_camera("aiming")
		l_4_0._is_precision_aiming = true
	else
		if not l_4_0._player_data.is_precision_aiming and l_4_0._is_precision_aiming then
			l_4_0:switch_to_camera("follow")
			l_4_0._is_precision_aiming = false
		end
	end
end


