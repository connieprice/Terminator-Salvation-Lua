local L0_0
L0_0 = getmetatable
L0_0 = L0_0(_G)
if L0_0 == nil then
	L0_0 = {}
	setmetatable(_G, L0_0)
end
L0_0.__declared = {}
function L0_0.__newindex(A0_1, A1_2, A2_3)
	if not _UPVALUE0_.__declared[A1_2] then
		if debug.getinfo(2, "S") and debug.getinfo(2, "S").what ~= "main" and debug.getinfo(2, "S").what ~= "C" then
			error("cannot assign undeclared global '" .. tostring(A1_2) .. "'", 2)
		end
		_UPVALUE0_.__declared[A1_2] = true
	end
	rawset(A0_1, A1_2, A2_3)
end
function L0_0.__index(A0_4, A1_5)
	if not _UPVALUE0_.__declared[A1_5] and debug.getinfo(2, "S") and debug.getinfo(2, "S").what ~= "main" and debug.getinfo(2, "S").what ~= "C" then
		error("cannot use undeclared global '" .. tostring(A1_5) .. "'", 2)
	end
end
managers = managers or {}
core_setup = core_setup or {}
script_debug = script_debug or {}
function toboolean(A0_6)
	if type(A0_6) == "string" then
		return A0_6 == "true"
	elseif type(A0_6) == "number" then
		return A0_6 == 1
	end
end
function iff(A0_7, A1_8, A2_9)
	if A0_7 then
		return A1_8
	else
		return A2_9
	end
end
function Vector3.__concat(A0_10, A1_11)
	return tostring(A0_10) .. tostring(A1_11)
end
function Vector3.flat(A0_12, A1_13)
	return math.cross(math.cross(A1_13, A0_12), A1_13)
end
function Vector3.orthogonal(A0_14, A1_15)
	return A0_14:orthogonal_func()(A1_15)
end
function Vector3.orthogonal_func(A0_16, A1_17)
	return function(A0_18)
		return (-_UPVALUE0_:z() * math.cos(180 + 360 * A0_18) + _UPVALUE0_:x() * math.cos(90 + 360 * A0_18)):normalized()
	end
end
function Vector3.unpack(A0_19)
	local L1_20, L2_21, L3_22
	L1_20 = A0_19.x
	L2_21 = A0_19.y
	L3_22 = A0_19.z
	return L1_20, L2_21, L3_22
end
function Color.unpack(A0_23)
	local L1_24, L2_25, L3_26
	L1_24 = A0_23.r
	L2_25 = A0_23.g
	L3_26 = A0_23.b
	return L1_24, L2_25, L3_26
end
getmetatable(Application).draw_box = function(A0_27, A1_28, A2_29, A3_30, A4_31, A5_32)
	Application:draw_line(A1_28, Vector3(A2_29.x, A1_28.y, A1_28.z), A3_30, A4_31, A5_32)
	Application:draw_line(A1_28, Vector3(A1_28.x, A2_29.y, A1_28.z), A3_30, A4_31, A5_32)
	Application:draw_line(Vector3(A2_29.x, A2_29.y, A1_28.z), Vector3(A1_28.x, A2_29.y, A1_28.z), A3_30, A4_31, A5_32)
	Application:draw_line(Vector3(A2_29.x, A2_29.y, A1_28.z), Vector3(A2_29.x, A1_28.y, A1_28.z), A3_30, A4_31, A5_32)
	Application:draw_line(A1_28, Vector3(A1_28.x, A1_28.y, A2_29.z), A3_30, A4_31, A5_32)
	Application:draw_line(Vector3(A1_28.x, A2_29.y, A1_28.z), Vector3(A1_28.x, A2_29.y, A2_29.z), A3_30, A4_31, A5_32)
	Application:draw_line(Vector3(A2_29.x, A1_28.y, A1_28.z), Vector3(A2_29.x, A1_28.y, A2_29.z), A3_30, A4_31, A5_32)
	Application:draw_line(Vector3(A2_29.x, A2_29.y, A1_28.z), Vector3(A2_29.x, A2_29.y, A2_29.z), A3_30, A4_31, A5_32)
	Application:draw_line(Vector3(A1_28.x, A1_28.y, A2_29.z), Vector3(A2_29.x, A1_28.y, A2_29.z), A3_30, A4_31, A5_32)
	Application:draw_line(Vector3(A1_28.x, A1_28.y, A2_29.z), Vector3(A1_28.x, A2_29.y, A2_29.z), A3_30, A4_31, A5_32)
	Application:draw_line(Vector3(A2_29.x, A2_29.y, A2_29.z), Vector3(A1_28.x, A2_29.y, A2_29.z), A3_30, A4_31, A5_32)
	Application:draw_line(Vector3(A2_29.x, A2_29.y, A2_29.z), Vector3(A2_29.x, A1_28.y, A2_29.z), A3_30, A4_31, A5_32)
end
getmetatable(Application).draw_rotation_size = function(A0_33, A1_34, A2_35, A3_36)
	if script_debug.draw_enabled then
		Application:draw_line(A1_34, A1_34 + A2_35:x() * A3_36, 1, 0, 0)
		Application:draw_line(A1_34, A1_34 + A2_35:y() * A3_36, 0, 1, 0)
		Application:draw_line(A1_34, A1_34 + A2_35:z() * A3_36, 0, 0, 1)
	end
end
getmetatable(Application).draw_arrow = function(A0_37, A1_38, A2_39, A3_40, A4_41, A5_42, A6_43)
	local L7_44, L8_45, L9_46
	L7_44 = script_debug
	L7_44 = L7_44.draw_enabled
	if L7_44 then
		A6_43 = A6_43 or 1
		L7_44 = A2_39 - A1_38
		L8_45 = L7_44
		L7_44 = L7_44.length
		L7_44 = L7_44(L8_45)
		L8_45 = A2_39 - A1_38
		L9_46 = L8_45
		L8_45 = L8_45.normalized
		L8_45 = L8_45(L9_46)
		L9_46 = 100 * A6_43
		L9_46 = L7_44 - L9_46
		L9_46 = L8_45 * L9_46
		L9_46 = A1_38 + L9_46
		Application:draw_cylinder(A1_38, L9_46, 10 * A6_43, A3_40, A4_41, A5_42)
		Application:draw_cone(A2_39, L9_46, 40 * A6_43, A3_40, A4_41, A5_42)
	end
end
getmetatable(Application).toggle_safe_rect = function(A0_47)
	if managers.viewport then
		managers.viewport:toggle_safe_rect()
	end
end
getmetatable(Application).stack_dump_error = function(A0_48, ...)
	Application:error(...)
	cat_stack_dump("debug")
end
Draw:pen()
function Pen.arrow(A0_50, A1_51, A2_52, A3_53)
	local L4_54, L5_55, L6_56
	L4_54 = script_debug
	L4_54 = L4_54.draw_enabled
	if L4_54 then
		A3_53 = A3_53 or 1
		L4_54 = A2_52 - A1_51
		L5_55 = L4_54
		L4_54 = L4_54.length
		L4_54 = L4_54(L5_55)
		L5_55 = A2_52 - A1_51
		L6_56 = L5_55
		L5_55 = L5_55.normalized
		L5_55 = L5_55(L6_56)
		L6_56 = 100 * A3_53
		L6_56 = L4_54 - L6_56
		L6_56 = L5_55 * L6_56
		L6_56 = A1_51 + L6_56
		A0_50:cylinder(A1_51, L6_56, 10 * A3_53)
		A0_50:cone(A2_52, L6_56, 40 * A3_53)
	end
end
function Rotation.__add(A0_57, A1_58)
	return Rotation(A0_57:yaw() + A1_58:yaw(), A0_57:pitch() + A1_58:pitch(), A0_57:roll() + A1_58:roll())
end
function Rotation.__sub(A0_59, A1_60)
	return Rotation(A0_59:yaw() - A1_60:yaw(), A0_59:pitch() - A1_60:pitch(), A0_59:roll() - A1_60:roll())
end
function Rotation.__div(A0_61, A1_62)
	return Rotation(A0_61:yaw() / A1_62:yaw(), A0_61:pitch() / A1_62:pitch(), A0_61:roll() / A1_62:roll())
end
function Rotation.__mod(A0_63, A1_64)
	return Rotation(A0_63:yaw() % A1_64:yaw(), A0_63:pitch() % A1_64:pitch(), A0_63:roll() % A1_64:roll())
end
function Rotation.__unm(A0_65)
	return Rotation(-A0_65:yaw(), -A0_65:pitch(), -A0_65:roll())
end
function Rotation.__concat(A0_66, A1_67)
	return tostring(A0_66) .. tostring(A1_67)
end
function Rotation.rotate_with(A0_68, A1_69)
	local L2_70
	L2_70 = Rotation
	return L2_70(A0_68:y():rotate_with(A1_69), A0_68:z():rotate_with(A1_69))
end
function app_func(A0_71, A1_72)
	getmetatable(Application)[A0_71] = function(...)
		local L1_74, L2_75
		L1_74 = _UPVALUE0_
		L2_75 = ...
		L1_74(L2_75)
	end
end
