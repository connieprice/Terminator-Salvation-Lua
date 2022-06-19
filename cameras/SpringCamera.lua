require("shared/camera/SharedCamera")
local l_0_0 = mvector3.add
local l_0_1 = mvector3.subtract
local l_0_2 = mvector3.multiply
local l_0_3 = mvector3.negate
local l_0_4 = mvector3.set_zero
local l_0_5 = mvector3.set
local l_0_6 = mvector3.set_static
local l_0_7 = mvector3.copy
local l_0_8 = mvector3.rotate_with
if not SpringCamera then
	SpringCamera = class(SharedCamera)
end
SpringCamera.init = function(l_1_0, l_1_1)
	SharedCamera.init(l_1_0, l_1_1)
	l_1_0._spring = Vector3(tweak_data.spring_camera.SPRING_CONSTANT.xy, tweak_data.spring_camera.SPRING_CONSTANT.xy, tweak_data.spring_camera.SPRING_CONSTANT.z)
	l_1_0._damping = Vector3(tweak_data.spring_camera.DAMPING_CONSTANT.xy, tweak_data.spring_camera.DAMPING_CONSTANT.xy, tweak_data.spring_camera.DAMPING_CONSTANT.z)
	l_1_0._max_displacement = Vector3(tweak_data.spring_camera.MAX_OFFSET.xy, tweak_data.spring_camera.MAX_OFFSET.xy, tweak_data.spring_camera.MAX_OFFSET.z)
	l_1_0._force_scale = Vector3(1, 1, 1)
	l_1_0._force = Vector3(0, 0, 0)
	l_1_0._force_applicant = nil
	l_1_0._integrator_func = nil
	l_1_0:reset()
end

SpringCamera.on_activate = function(l_2_0, l_2_1)
	if l_2_1 then
		l_2_0:reset()
	end
end

SpringCamera.parse_parameters = function(l_3_0, l_3_1)
	SharedCamera.parse_parameters(l_3_0, l_3_1)
	if l_3_1.spring then
		l_3_0._spring = math.string_to_vector(l_3_1.spring)
	end
	if l_3_1.max_displacement then
		l_3_0._max_displacement = math.string_to_vector(l_3_1.max_displacement)
	end
	if l_3_1.damping then
		l_3_0._damping = math.string_to_vector(l_3_1.damping)
	end
	if l_3_1.force_scale then
		l_3_0._force_scale = math.string_to_vector(l_3_1.force_scale)
	end
	if l_3_1.force then
		if l_3_1.force == "acceleration" then
			l_3_0._force_applicant = SpringCameraAcceleration:new()
		elseif l_3_1.force == "velocity" then
			l_3_0._force_applicant = SpringCameraVelocity:new()
		elseif l_3_1.force == "position" then
			l_3_0._force_applicant = SpringCameraPosition:new()
		end
	else
		l_3_0._force_applicant = SpringCameraPosition:new()
	end
	if l_3_1.integrator then
		if l_3_1.integrator == "euler" then
			l_3_0._integrator_func = SpringCamera.euler_integration
		elseif l_3_1.integrator == "rk2" then
			l_3_0._integrator_func = SpringCamera.rk2_integration
		elseif l_3_1.integrator == "rk4" then
			l_3_0._integrator_func = SpringCamera.rk4_integration
		end
	else
		l_3_0._integrator_func = SpringCamera.rk2_integration
	end
end

SpringCamera.acceleration = function(l_4_0, l_4_1, l_4_2, l_4_3)
	local l_4_4 = l_4_0._spring
	local l_4_5 = l_4_0._damping
	local l_4_6 = Vector3
	local l_4_7 = -(l_4_1.x * l_4_4.x) - l_4_5.x * l_4_2.x + l_4_3.x
	local l_4_8 = -(l_4_1.y * l_4_4.y) - l_4_5.y * l_4_2.y + l_4_3.y
	local l_4_11 = -(l_4_1.z * l_4_4.z)
	l_4_11 = l_4_11 - l_4_5.z * l_4_2.z
	local l_4_10 = l_4_3.z
	l_4_11 = l_4_11 + l_4_10
	local l_4_9 = nil
	return l_4_6(l_4_7, l_4_8, l_4_11)
end

SpringCamera.euler_integration = function(l_5_0, l_5_1, l_5_2)
	local l_5_3 = l_5_0._displacement
	local l_5_4 = l_5_0._velocity
	local l_5_5 = l_5_0:acceleration(l_5_3, l_5_4, l_5_2)
	l_5_0._displacement = l_5_4 + l_5_5 * l_5_1
	l_5_0._velocity = position + l_5_4 * l_5_1 + 0.5 * l_5_5 * l_5_1 * l_5_1
end

SpringCamera.rk2_integration = function(l_6_0, l_6_1, l_6_2)
	-- upvalues: l_0_2 , l_0_0 , l_0_5
	local l_6_3 = l_6_0._displacement
	local l_6_4 = l_6_0._velocity
	local l_6_5 = mvector3.copy(l_6_3)
	local l_6_6 = mvector3.copy(l_6_4)
	local l_6_7 = mvector3.copy(l_6_6)
	l_0_2(l_6_7, 0.5 * l_6_1)
	l_0_0(l_6_7, l_6_5)
	local l_6_8 = l_6_0:acceleration(l_6_5, l_6_6, l_6_2)
	local l_6_9 = mvector3.copy(l_6_8)
	l_0_2(l_6_9, 0.5 * l_6_1)
	l_0_0(l_6_9, l_6_6)
	l_0_5(l_6_3, l_6_9)
	l_0_2(l_6_3, l_6_1)
	l_0_0(l_6_3, l_6_5)
	l_0_5(l_6_8, l_6_0:acceleration(l_6_7, l_6_9, l_6_2))
	l_0_5(l_6_4, l_6_8)
	l_0_2(l_6_4, l_6_1)
	l_0_0(l_6_4, l_6_6)
end

SpringCamera.rk4_integration = function(l_7_0, l_7_1, l_7_2)
	local l_7_3 = l_7_0._displacement
	local l_7_4 = l_7_0._velocity
	local l_7_5 = l_7_0:acceleration(l_7_3, l_7_4, l_7_2)
	local l_7_6 = l_7_3 + 0.5 * l_7_4 * l_7_1
	local l_7_7 = l_7_4 + 0.5 * l_7_5 * l_7_1
	local l_7_8 = l_7_0:acceleration(l_7_6, l_7_7, l_7_2)
	local l_7_9 = l_7_3 + 0.5 * l_7_7 * l_7_1
	local l_7_10 = l_7_4 + 0.5 * l_7_8 * l_7_1
	local l_7_11 = l_7_0:acceleration(l_7_9, l_7_10, l_7_2)
	local l_7_12 = l_7_3 + l_7_10 * l_7_1
	local l_7_13 = l_7_4 + l_7_11 * l_7_1
	local l_7_14 = l_7_0:acceleration(l_7_12, l_7_13, l_7_2)
	local l_7_15 = l_7_3 + l_7_1 / 6 * (l_7_4 + 2 * l_7_7 + 2 * l_7_10 + l_7_13)
	l_7_0._velocity = l_7_4 + l_7_1 / 6 * (l_7_5 + 2 * l_7_8 + 2 * l_7_11 + l_7_14)
end

SpringCamera.update = function(l_8_0, l_8_1, l_8_2, l_8_3, l_8_4)
	-- upvalues: l_0_6 , l_0_5
	local l_8_5 = l_8_0._displacement
	local l_8_6 = l_8_0._max_displacement
	local l_8_7 = l_8_0._force
	local l_8_8 = l_8_0._force_scale
	l_8_0._force_applicant:force(l_8_1, l_8_2, l_8_7, l_8_3, l_8_4)
	l_0_6(l_8_7, l_8_7.x * l_8_8.x, l_8_7.y * l_8_8.y, l_8_7.z * l_8_8.z)
	l_8_0:_integrator_func(l_8_2, l_8_7)
	l_0_6(l_8_5, math.clamp(l_8_5.x, -l_8_6.x, l_8_6.x), math.clamp(l_8_5.y, -l_8_6.y, l_8_6.y), math.clamp(l_8_5.z, -l_8_6.z, l_8_6.z))
	l_0_5(l_8_0._local_position, l_8_5)
	SharedCamera.update(l_8_0, l_8_1, l_8_2, l_8_3, l_8_4)
end

SpringCamera.reset = function(l_9_0)
	l_9_0._velocity = Vector3(0, 0, 0)
	l_9_0._displacement = Vector3(0, 0, 0)
	if l_9_0._force_applicant then
		l_9_0._force_applicant:reset()
	end
end

SpringCamera.debug_render = function(l_10_0, l_10_1, l_10_2)
	SharedCamera.debug_render(l_10_0, l_10_1, l_10_2)
	local l_10_3 = Draw:brush(Color(0.3, 1, 0, 0))
	local l_10_4 = Draw:brush(Color(0.3, 0, 1, 0))
	local l_10_5 = (Draw:pen(Color(0.3, 1, 1, 1)))
	local l_10_6 = nil
	l_10_3:sphere(l_10_0:parent_camera():position(), 10)
	l_10_4:sphere(l_10_0:position(), 10)
	l_10_5:line(l_10_0:parent_camera():position(), l_10_0:position())
	local l_10_7 = Draw:pen(Color(0.3, 1, 0, 1))
	l_10_7:line(l_10_0:position(), l_10_0:position() + l_10_0._force)
end

if not SpringCameraForce then
	SpringCameraForce = class()
end
SpringCameraForce.init = function(l_11_0)
end

SpringCameraForce.force = function(l_12_0, l_12_1, l_12_2, l_12_3, l_12_4, l_12_5)
end

SpringCameraForce.reset = function(l_13_0)
end

if not SpringCameraPosition then
	SpringCameraPosition = class(SpringCameraForce)
end
SpringCameraPosition.init = function(l_14_0)
	l_14_0:reset()
end

SpringCameraPosition.force = function(l_15_0, l_15_1, l_15_2, l_15_3, l_15_4, l_15_5)
	-- upvalues: l_0_5 , l_0_1 , l_0_8 , l_0_3 , l_0_4
	if not l_15_0._reset then
		l_0_5(l_15_3, l_15_4)
		l_0_1(l_15_3, l_15_0._previous_parent_position)
		l_0_8(l_15_3, l_15_5:inverse())
		l_0_3(l_15_3)
	else
		l_0_4(l_15_3)
		l_15_0._reset = false
	end
	l_0_5(l_15_0._previous_parent_position, l_15_4)
end

SpringCameraPosition.reset = function(l_16_0)
	l_16_0._reset = true
	l_16_0._previous_parent_position = Vector3(0, 0, 0)
end

if not SpringCameraVelocity then
	SpringCameraVelocity = class(SpringCameraForce)
end
SpringCameraVelocity.init = function(l_17_0)
	l_17_0:reset()
end

SpringCameraVelocity.force = function(l_18_0, l_18_1, l_18_2, l_18_3, l_18_4, l_18_5)
	-- upvalues: l_0_5 , l_0_1 , l_0_2 , l_0_7 , l_0_8 , l_0_3 , l_0_4
	if not l_18_0._reset then
		l_0_5(l_18_3, l_18_4)
		l_0_1(l_18_3, l_18_0._previous_parent_position)
		l_0_2(l_18_3, 1 / l_18_2)
		local l_18_6 = l_0_7(l_18_3)
		l_0_1(l_18_3, l_18_0._velocity)
		l_0_5(l_18_0._velocity, l_18_6)
		l_0_8(l_18_3, l_18_5:inverse())
		l_0_3(l_18_3)
	else
		l_0_4(l_18_3)
		l_0_4(l_18_0._velocity)
		l_18_0._reset = false
	end
	l_0_5(l_18_0._previous_parent_position, l_18_4)
end

SpringCameraVelocity.reset = function(l_19_0)
	l_19_0._reset = true
	l_19_0._velocity = Vector3(0, 0, 0)
	l_19_0._previous_parent_position = Vector3(0, 0, 0)
end

if not SpringCameraAcceleration then
	SpringCameraAcceleration = class(SpringCameraForce)
end
SpringCameraAcceleration.init = function(l_20_0)
	l_20_0:reset()
end

SpringCameraAcceleration.force = function(l_21_0, l_21_1, l_21_2, l_21_3, l_21_4, l_21_5)
	-- upvalues: l_0_5 , l_0_1 , l_0_2 , l_0_7 , l_0_8 , l_0_3 , l_0_4
	if not l_21_0._reset then
		l_0_5(l_21_3, l_21_4)
		l_0_1(l_21_3, l_21_0._previous_parent_position)
		l_0_2(l_21_3, 1 / l_21_2)
		local l_21_6 = l_0_7(l_21_3)
		l_0_1(l_21_3, l_21_0._velocity)
		l_0_2(l_21_3, 1 / l_21_2)
		l_0_5(l_21_0._velocity, l_21_6)
		l_0_8(l_21_3, l_21_5:inverse())
		l_0_3(l_21_3)
	else
		l_0_4(l_21_3)
		l_0_4(l_21_0._velocity)
		l_21_0._reset = false
	end
	l_0_5(l_21_0._previous_parent_position, l_21_4)
end

SpringCameraAcceleration.reset = function(l_22_0)
	l_22_0._reset = true
	l_22_0._velocity = Vector3(0, 0, 0)
	l_22_0._previous_parent_position = Vector3(0, 0, 0)
end


