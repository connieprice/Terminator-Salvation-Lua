require("shared/TableAlgorithms")
local l_0_0 = mvector3.add
local l_0_1 = mvector3.subtract
local l_0_2 = mvector3.multiply
local l_0_3 = mvector3.copy
local l_0_4 = mrotation.slerp
if not CameraMixer then
	CameraMixer = class()
end
CameraMixer.init = function(l_1_0)
	l_1_0._cameras = {}
end

CameraMixer.add_camera = function(l_2_0, l_2_1, l_2_2)
	local l_2_3 = 0
	if l_2_2 == nil or l_2_2 == 0 or #l_2_0._cameras == 0 then
		l_2_2 = 1
		l_2_3 = 1
	end
	local l_2_4 = table.insert
	local l_2_5 = l_2_0._cameras
	local l_2_6 = {}
	l_2_6.camera = l_2_1
	l_2_6.blend_time = l_2_2
	l_2_6.time = l_2_3
	l_2_4(l_2_5, l_2_6)
end

CameraMixer.update = function(l_3_0, l_3_1, l_3_2)
	-- upvalues: l_0_3 , l_0_1 , l_0_2 , l_0_0 , l_0_4
	local l_3_7, l_3_8, l_3_9, l_3_10, l_3_11, l_3_12, l_3_13, l_3_14, l_3_15, l_3_16, l_3_17, l_3_18 = nil
	l_3_1.position = Vector3(0, 0, 0)
	l_3_1.rotation = Rotation()
	l_3_1.constraint_yaw = nil
	l_3_1.constraint_pitch = nil
	l_3_1.constraint_rot = nil
	l_3_1.fov = 0
	l_3_1.dof = nil
	local l_3_3 = 1
	for i_0,i_1 in ipairs(l_3_0._cameras) do
		i_1.time = i_1.time + l_3_2
		local l_3_21 = math.sin(math.clamp(i_1.time / i_1.blend_time, 0, 1) * 90)
		local l_3_22 = nil
		l_0_1(l_0_3(i_1.camera:position()), l_3_1.position)
		l_0_2(l_0_3(i_1.camera:position()), l_3_21)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_0_0(l_3_1.position, l_0_3(i_1.camera:position()))
		local l_3_23 = nil
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_0_4(l_3_1.rotation, l_3_1.rotation, l_3_22:rotation(), l_3_21)
		local l_3_24 = nil
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_3_1.fov = l_3_1.fov + (l_3_22:camera_fov() - l_3_1.fov) * l_3_21
		local l_3_26 = nil
		if l_3_1.dof then
			if not l_3_22:camera_dof() then
				local l_3_27 = nil
				local l_3_25 = {}
				l_3_25.far_min = 1000000
				 -- DECOMPILER ERROR: Confused about usage of registers!

				l_3_25.far_max = 1000000
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_3_1.dof.amount = l_3_1.dof.amount + (l_3_25.amount - l_3_1.dof.amount) * l_3_21
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_3_1.dof.near_min = l_3_1.dof.near_min + (l_3_25.near_min - l_3_1.dof.near_min) * l_3_21
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_3_1.dof.near_max = l_3_1.dof.near_max + (l_3_25.near_max - l_3_1.dof.near_max) * l_3_21
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_3_1.dof.far_min = l_3_1.dof.far_min + (l_3_25.far_min - l_3_1.dof.far_min) * l_3_21
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_3_1.dof.far_max = l_3_1.dof.far_max + (l_3_25.far_max - l_3_1.dof.far_max) * l_3_21
		 -- DECOMPILER ERROR: Confused about usage of registers!

		elseif l_3_25 then
			l_3_1.dof = {}
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_3_1.dof.amount = l_3_25.amount
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_3_1.dof.near_min = l_3_25.near_min
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_3_1.dof.near_max = l_3_25.near_max
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_3_1.dof.far_min = l_3_25.far_min
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_3_1.dof.far_max = l_3_25.far_max
		end
		local l_3_28, l_3_29, l_3_30 = nil
		if l_3_22:camera_constraints() and l_3_1.constraint_rot then
			l_3_1.constraint_rot = l_3_1.constraint_rot:slerp(l_3_22:camera_constraints(), l_3_21)
		else
			l_3_1.constraint_rot = l_3_22:camera_constraints()
		end
		if l_3_22 and l_3_1.constraint_yaw then
			l_3_1.constraint_yaw = l_3_1.constraint_yaw + (l_3_22 - l_3_1.constraint_yaw) * l_3_21
		else
			l_3_1.constraint_yaw = l_3_22
		end
		if l_3_1.dof.far_max and l_3_1.constraint_pitch then
			l_3_1.constraint_pitch = l_3_1.constraint_pitch + (l_3_22 - l_3_1.constraint_pitch) * l_3_21
		else
			l_3_1.constraint_pitch = l_3_1.dof.far_max
		end
		if l_3_21 >= 1 then
			l_3_3 = l_3_19
		end
	end
	for i = 1, l_3_3 - 1 do
		table.insert({}, l_3_0._cameras[1].camera)
		table.remove(l_3_0._cameras, 1)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return {}
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CameraMixer.active_camera = function(l_4_0)
	local l_4_1 = #l_4_0._cameras
	if l_4_1 == 0 then
		return nil
	end
	return l_4_0._cameras[l_4_1].camera
end

CameraMixer.cameras = function(l_5_0)
	local l_5_5, l_5_6, l_5_7, l_5_8 = nil
	local l_5_1 = {}
	for i_0,i_1 in ipairs(l_5_0._cameras) do
		table.insert(l_5_1, i_1.camera)
	end
	return l_5_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


