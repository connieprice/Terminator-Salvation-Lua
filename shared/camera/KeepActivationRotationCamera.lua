require("shared/camera/SharedCamera")
if not KeepActivationRotationCamera then
	KeepActivationRotationCamera = class(SharedCamera)
end
KeepActivationRotationCamera.init = function(l_1_0, l_1_1)
	SharedCamera.init(l_1_0, l_1_1)
	l_1_0._activation_rotation = Rotation()
end

KeepActivationRotationCamera.on_activate = function(l_2_0, l_2_1)
	SharedCamera.on_activate(l_2_0, l_2_1)
	if l_2_1 then
		local l_2_2 = l_2_0._root_unit:camera()._camera_data.rotation
		do
			local l_2_3, l_2_5, l_2_8, l_2_9 = l_2_0._keep_yaw and l_2_2:roll() or 0
		do
			end
			local l_2_4, l_2_6, l_2_10 = , l_2_0._keep_pitch and l_2_2:yaw() or 0
		do
			end
			local l_2_7, l_2_11 = nil
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_2_0._activation_rotation = Rotation(l_2_11, l_2_0._keep_roll and l_2_2:pitch() or 0, l_2_7)
	end
end

KeepActivationRotationCamera.parse_parameters = function(l_3_0, l_3_1)
	SharedCamera.parse_parameters(l_3_0, l_3_1)
	l_3_0._keep_yaw = l_3_1.keep_yaw
	l_3_0._keep_pitch = l_3_1.keep_pitch
	l_3_0._keep_roll = l_3_1.keep_roll
end

KeepActivationRotationCamera.update = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4)
	l_4_0:set_local_rotation_from_world_rotation(l_4_0._activation_rotation)
	SharedCamera.update(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4)
end


