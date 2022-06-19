local L0_0
L0_0 = require
L0_0("shared/camera/SharedCamera")
L0_0 = mvector3
L0_0 = L0_0.add
SpringCamera = SpringCamera or class(SharedCamera)
function SpringCamera.init(A0_1, A1_2)
	SharedCamera.init(A0_1, A1_2)
	A0_1._spring = Vector3(tweak_data.spring_camera.SPRING_CONSTANT.xy, tweak_data.spring_camera.SPRING_CONSTANT.xy, tweak_data.spring_camera.SPRING_CONSTANT.z)
	A0_1._damping = Vector3(tweak_data.spring_camera.DAMPING_CONSTANT.xy, tweak_data.spring_camera.DAMPING_CONSTANT.xy, tweak_data.spring_camera.DAMPING_CONSTANT.z)
	A0_1._max_displacement = Vector3(tweak_data.spring_camera.MAX_OFFSET.xy, tweak_data.spring_camera.MAX_OFFSET.xy, tweak_data.spring_camera.MAX_OFFSET.z)
	A0_1._force_scale = Vector3(1, 1, 1)
	A0_1._force = Vector3(0, 0, 0)
	A0_1._force_applicant = nil
	A0_1._integrator_func = nil
	A0_1:reset()
end
function SpringCamera.on_activate(A0_3, A1_4)
	if A1_4 then
		A0_3:reset()
	end
end
function SpringCamera.parse_parameters(A0_5, A1_6)
	SharedCamera.parse_parameters(A0_5, A1_6)
	if A1_6.spring then
		A0_5._spring = math.string_to_vector(A1_6.spring)
	end
	if A1_6.max_displacement then
		A0_5._max_displacement = math.string_to_vector(A1_6.max_displacement)
	end
	if A1_6.damping then
		A0_5._damping = math.string_to_vector(A1_6.damping)
	end
	if A1_6.force_scale then
		A0_5._force_scale = math.string_to_vector(A1_6.force_scale)
	end
	if A1_6.force then
		if A1_6.force == "acceleration" then
			A0_5._force_applicant = SpringCameraAcceleration:new()
		elseif A1_6.force == "velocity" then
			A0_5._force_applicant = SpringCameraVelocity:new()
		elseif A1_6.force == "position" then
			A0_5._force_applicant = SpringCameraPosition:new()
		end
	else
		A0_5._force_applicant = SpringCameraPosition:new()
	end
	if A1_6.integrator then
		if A1_6.integrator == "euler" then
			A0_5._integrator_func = SpringCamera.euler_integration
		elseif A1_6.integrator == "rk2" then
			A0_5._integrator_func = SpringCamera.rk2_integration
		elseif A1_6.integrator == "rk4" then
			A0_5._integrator_func = SpringCamera.rk4_integration
		end
	else
		A0_5._integrator_func = SpringCamera.rk2_integration
	end
end
function SpringCamera.acceleration(A0_7, A1_8, A2_9, A3_10)
	local L4_11, L5_12
	L4_11 = A0_7._spring
	L5_12 = A0_7._damping
	return Vector3(-(A1_8.x * L4_11.x) - L5_12.x * A2_9.x + A3_10.x, -(A1_8.y * L4_11.y) - L5_12.y * A2_9.y + A3_10.y, -(A1_8.z * L4_11.z) - L5_12.z * A2_9.z + A3_10.z)
end
function SpringCamera.euler_integration(A0_13, A1_14, A2_15)
	local L3_16, L4_17
	L3_16 = A0_13._displacement
	L4_17 = A0_13._velocity
	A0_13._displacement = L4_17 + A0_13:acceleration(L3_16, L4_17, A2_15) * A1_14
	A0_13._velocity = position + L4_17 * A1_14 + 0.5 * A0_13:acceleration(L3_16, L4_17, A2_15) * A1_14 * A1_14
end
function SpringCamera.rk2_integration(A0_18, A1_19, A2_20)
	local L3_21, L4_22, L5_23, L6_24, L7_25, L8_26, L9_27
	L3_21 = A0_18._displacement
	L4_22 = A0_18._velocity
	L5_23 = mvector3
	L5_23 = L5_23.copy
	L6_24 = L3_21
	L5_23 = L5_23(L6_24)
	L6_24 = mvector3
	L6_24 = L6_24.copy
	L7_25 = L4_22
	L6_24 = L6_24(L7_25)
	L7_25 = mvector3
	L7_25 = L7_25.copy
	L8_26 = L6_24
	L7_25 = L7_25(L8_26)
	L8_26 = _UPVALUE0_
	L9_27 = L7_25
	L8_26(L9_27, 0.5 * A1_19)
	L8_26 = _UPVALUE1_
	L9_27 = L7_25
	L8_26(L9_27, L5_23)
	L9_27 = A0_18
	L8_26 = A0_18.acceleration
	L8_26 = L8_26(L9_27, L5_23, L6_24, A2_20)
	L9_27 = mvector3
	L9_27 = L9_27.copy
	L9_27 = L9_27(L8_26)
	_UPVALUE0_(L9_27, 0.5 * A1_19)
	_UPVALUE1_(L9_27, L6_24)
	_UPVALUE2_(L3_21, L9_27)
	_UPVALUE0_(L3_21, A1_19)
	_UPVALUE1_(L3_21, L5_23)
	_UPVALUE2_(L8_26, A0_18:acceleration(L7_25, L9_27, A2_20))
	_UPVALUE2_(L4_22, L8_26)
	_UPVALUE0_(L4_22, A1_19)
	_UPVALUE1_(L4_22, L6_24)
end
function SpringCamera.rk4_integration(A0_28, A1_29, A2_30)
	local L3_31, L4_32, L5_33, L6_34, L7_35, L8_36, L9_37, L10_38, L11_39, L12_40, L13_41
	L3_31 = A0_28._displacement
	L4_32 = A0_28._velocity
	L6_34 = A0_28
	L5_33 = A0_28.acceleration
	L7_35 = L3_31
	L8_36 = L4_32
	L9_37 = A2_30
	L5_33 = L5_33(L6_34, L7_35, L8_36, L9_37)
	L6_34 = 0.5 * L4_32
	L6_34 = L6_34 * A1_29
	L6_34 = L3_31 + L6_34
	L7_35 = 0.5 * L5_33
	L7_35 = L7_35 * A1_29
	L7_35 = L4_32 + L7_35
	L9_37 = A0_28
	L8_36 = A0_28.acceleration
	L10_38 = L6_34
	L11_39 = L7_35
	L12_40 = A2_30
	L8_36 = L8_36(L9_37, L10_38, L11_39, L12_40)
	L9_37 = 0.5 * L7_35
	L9_37 = L9_37 * A1_29
	L9_37 = L3_31 + L9_37
	L10_38 = 0.5 * L8_36
	L10_38 = L10_38 * A1_29
	L10_38 = L4_32 + L10_38
	L12_40 = A0_28
	L11_39 = A0_28.acceleration
	L13_41 = L9_37
	L11_39 = L11_39(L12_40, L13_41, L10_38, A2_30)
	L12_40 = L10_38 * A1_29
	L12_40 = L3_31 + L12_40
	L13_41 = L11_39 * A1_29
	L13_41 = L4_32 + L13_41
	A0_28._velocity, A0_28._displacement = L4_32 + A1_29 / 6 * (L5_33 + 2 * L8_36 + 2 * L11_39 + A0_28:acceleration(L12_40, L13_41, A2_30)), L3_31 + A1_29 / 6 * (L4_32 + 2 * L7_35 + 2 * L10_38 + L13_41)
end
function SpringCamera.update(A0_42, A1_43, A2_44, A3_45, A4_46)
	local L5_47, L6_48, L7_49, L8_50
	L5_47 = A0_42._displacement
	L6_48 = A0_42._max_displacement
	L7_49 = A0_42._force
	L8_50 = A0_42._force_scale
	A0_42._force_applicant:force(A1_43, A2_44, L7_49, A3_45, A4_46)
	_UPVALUE0_(L7_49, L7_49.x * L8_50.x, L7_49.y * L8_50.y, L7_49.z * L8_50.z)
	A0_42:_integrator_func(A2_44, L7_49)
	_UPVALUE0_(L5_47, math.clamp(L5_47.x, -L6_48.x, L6_48.x), math.clamp(L5_47.y, -L6_48.y, L6_48.y), math.clamp(L5_47.z, -L6_48.z, L6_48.z))
	_UPVALUE1_(A0_42._local_position, L5_47)
	SharedCamera.update(A0_42, A1_43, A2_44, A3_45, A4_46)
end
function SpringCamera.reset(A0_51)
	A0_51._velocity = Vector3(0, 0, 0)
	A0_51._displacement = Vector3(0, 0, 0)
	if A0_51._force_applicant then
		A0_51._force_applicant:reset()
	end
end
function SpringCamera.debug_render(A0_52, A1_53, A2_54)
	SharedCamera.debug_render(A0_52, A1_53, A2_54)
	Draw:brush(Color(0.3, 1, 0, 0)):sphere(A0_52:parent_camera():position(), 10)
	Draw:brush(Color(0.3, 0, 1, 0)):sphere(A0_52:position(), 10)
	Draw:pen(Color(0.3, 1, 1, 1)):line(A0_52:parent_camera():position(), A0_52:position())
	Draw:pen(Color(0.3, 1, 0, 1)):line(A0_52:position(), A0_52:position() + A0_52._force)
end
SpringCameraForce = SpringCameraForce or class()
function SpringCameraForce.init(A0_55)
	local L1_56
end
function SpringCameraForce.force(A0_57, A1_58, A2_59, A3_60, A4_61, A5_62)
end
function SpringCameraForce.reset(A0_63)
	local L1_64
end
SpringCameraPosition = SpringCameraPosition or class(SpringCameraForce)
function SpringCameraPosition.init(A0_65)
	A0_65:reset()
end
function SpringCameraPosition.force(A0_66, A1_67, A2_68, A3_69, A4_70, A5_71)
	if not A0_66._reset then
		_UPVALUE0_(A3_69, A4_70)
		_UPVALUE1_(A3_69, A0_66._previous_parent_position)
		_UPVALUE2_(A3_69, A5_71:inverse())
		_UPVALUE3_(A3_69)
	else
		_UPVALUE4_(A3_69)
		A0_66._reset = false
	end
	_UPVALUE0_(A0_66._previous_parent_position, A4_70)
end
function SpringCameraPosition.reset(A0_72)
	A0_72._reset = true
	A0_72._previous_parent_position = Vector3(0, 0, 0)
end
SpringCameraVelocity = SpringCameraVelocity or class(SpringCameraForce)
function SpringCameraVelocity.init(A0_73)
	A0_73:reset()
end
function SpringCameraVelocity.force(A0_74, A1_75, A2_76, A3_77, A4_78, A5_79)
	local L6_80
	L6_80 = A0_74._reset
	if not L6_80 then
		L6_80 = _UPVALUE0_
		L6_80(A3_77, A4_78)
		L6_80 = _UPVALUE1_
		L6_80(A3_77, A0_74._previous_parent_position)
		L6_80 = _UPVALUE2_
		L6_80(A3_77, 1 / A2_76)
		L6_80 = _UPVALUE3_
		L6_80 = L6_80(A3_77)
		_UPVALUE1_(A3_77, A0_74._velocity)
		_UPVALUE0_(A0_74._velocity, L6_80)
		_UPVALUE4_(A3_77, A5_79:inverse())
		_UPVALUE5_(A3_77)
	else
		L6_80 = _UPVALUE6_
		L6_80(A3_77)
		L6_80 = _UPVALUE6_
		L6_80(A0_74._velocity)
		A0_74._reset = false
	end
	L6_80 = _UPVALUE0_
	L6_80(A0_74._previous_parent_position, A4_78)
end
function SpringCameraVelocity.reset(A0_81)
	A0_81._reset = true
	A0_81._velocity = Vector3(0, 0, 0)
	A0_81._previous_parent_position = Vector3(0, 0, 0)
end
SpringCameraAcceleration = SpringCameraAcceleration or class(SpringCameraForce)
function SpringCameraAcceleration.init(A0_82)
	A0_82:reset()
end
function SpringCameraAcceleration.force(A0_83, A1_84, A2_85, A3_86, A4_87, A5_88)
	local L6_89
	L6_89 = A0_83._reset
	if not L6_89 then
		L6_89 = _UPVALUE0_
		L6_89(A3_86, A4_87)
		L6_89 = _UPVALUE1_
		L6_89(A3_86, A0_83._previous_parent_position)
		L6_89 = _UPVALUE2_
		L6_89(A3_86, 1 / A2_85)
		L6_89 = _UPVALUE3_
		L6_89 = L6_89(A3_86)
		_UPVALUE1_(A3_86, A0_83._velocity)
		_UPVALUE2_(A3_86, 1 / A2_85)
		_UPVALUE0_(A0_83._velocity, L6_89)
		_UPVALUE4_(A3_86, A5_88:inverse())
		_UPVALUE5_(A3_86)
	else
		L6_89 = _UPVALUE6_
		L6_89(A3_86)
		L6_89 = _UPVALUE6_
		L6_89(A0_83._velocity)
		A0_83._reset = false
	end
	L6_89 = _UPVALUE0_
	L6_89(A0_83._previous_parent_position, A4_87)
end
function SpringCameraAcceleration.reset(A0_90)
	A0_90._reset = true
	A0_90._velocity = Vector3(0, 0, 0)
	A0_90._previous_parent_position = Vector3(0, 0, 0)
end
