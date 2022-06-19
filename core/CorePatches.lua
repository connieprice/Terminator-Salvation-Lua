if getmetatable(_G) == nil then
	local l_0_0, l_0_1, l_0_2, l_0_3, l_0_4, l_0_5, l_0_6, l_0_7, l_0_8, l_0_9, l_0_10, l_0_11, l_0_12, l_0_13 = {}
	l_0_1 = setmetatable
	l_0_2 = _G
	l_0_3 = l_0_0
	l_0_1(l_0_2, l_0_3)
end
 -- DECOMPILER ERROR: Confused about usage of registers!

l_0_0.__declared = {}
 -- DECOMPILER ERROR: Confused about usage of registers!

l_0_0.__newindex = function(l_1_0, l_1_1, l_1_2)
	-- upvalues: l_0_0
	if not l_0_0.__declared[l_1_1] then
		local l_1_3 = debug.getinfo(2, "S")
		if l_1_3 and l_1_3.what ~= "main" and l_1_3.what ~= "C" then
			error("cannot assign undeclared global '" .. tostring(l_1_1) .. "'", 2)
		end
		l_0_0.__declared[l_1_1] = true
	end
	rawset(l_1_0, l_1_1, l_1_2)
end

 -- DECOMPILER ERROR: Confused about usage of registers!

l_0_0.__index = function(l_2_0, l_2_1)
	-- upvalues: l_0_0
	if not l_0_0.__declared[l_2_1] then
		local l_2_2 = debug.getinfo(2, "S")
	if l_2_2 then
		end
	if l_2_2.what ~= "main" then
		end
	if l_2_2.what ~= "C" then
		end
		error("cannot use undeclared global '" .. tostring(l_2_1) .. "'", 2)
	end
end

if not managers then
	managers = {}
end
if not core_setup then
	core_setup = {}
end
if not script_debug then
	script_debug = {}
end
toboolean = function(l_3_0)
		if l_3_0 ~= "true" then
			return type(l_3_0) ~= "string"
		end
		do return end
		if l_3_0 ~= 1 then
			return type(l_3_0) ~= "number"
		end
  end
iff = function(l_4_0, l_4_1, l_4_2)
	if l_4_0 then
		return l_4_1
	end
	do return end
	return l_4_2
end

Vector3.__concat = function(l_5_0, l_5_1)
	return tostring(l_5_0) .. tostring(l_5_1)
end

Vector3.flat = function(l_6_0, l_6_1)
	local l_6_2 = math.cross
	local l_6_5 = math.cross
	l_6_5 = l_6_5(l_6_1, l_6_0)
	local l_6_3 = nil
	l_6_3 = l_6_1
	local l_6_4 = nil
	return l_6_2(l_6_5, l_6_3)
end

Vector3.orthogonal = function(l_7_0, l_7_1)
	local l_7_2 = l_7_0:orthogonal_func()
	local l_7_3 = l_7_1
	return l_7_2(l_7_3)
end

Vector3.orthogonal_func = function(l_8_0, l_8_1)
	local l_8_2 = Rotation
	local l_8_3 = l_8_0
	do
		if not l_8_1 then
			l_8_2 = l_8_2(l_8_3, Vector3(0, 0, -1))
		end
		l_8_3 = function(l_9_0)
			-- upvalues: l_8_2
			local l_9_4 = -l_8_2:z() * math.cos(180 + 360 * l_9_0)
			local l_9_3 = l_8_2:x()
			l_9_3 = l_9_3 * math.cos(90 + 360 * l_9_0)
			l_9_4 = l_9_4 + l_9_3
			l_9_4, l_9_3 = l_9_4:normalized, l_9_4
			local l_9_1, l_9_2 = nil
			return l_9_4(l_9_3)
    end
		return l_8_3
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Vector3.unpack = function(l_9_0)
	return l_9_0.x, l_9_0.y, l_9_0.z
end

Color.unpack = function(l_10_0)
	return l_10_0.r, l_10_0.g, l_10_0.b
end

local l_0_14 = nil
getmetatable(Application).draw_box = function(l_11_0, l_11_1, l_11_2, l_11_3, l_11_4, l_11_5)
	Application:draw_line(l_11_1, Vector3(l_11_2.x, l_11_1.y, l_11_1.z), l_11_3, l_11_4, l_11_5)
	Application:draw_line(l_11_1, Vector3(l_11_1.x, l_11_2.y, l_11_1.z), l_11_3, l_11_4, l_11_5)
	Application:draw_line(Vector3(l_11_2.x, l_11_2.y, l_11_1.z), Vector3(l_11_1.x, l_11_2.y, l_11_1.z), l_11_3, l_11_4, l_11_5)
	Application:draw_line(Vector3(l_11_2.x, l_11_2.y, l_11_1.z), Vector3(l_11_2.x, l_11_1.y, l_11_1.z), l_11_3, l_11_4, l_11_5)
	Application:draw_line(l_11_1, Vector3(l_11_1.x, l_11_1.y, l_11_2.z), l_11_3, l_11_4, l_11_5)
	Application:draw_line(Vector3(l_11_1.x, l_11_2.y, l_11_1.z), Vector3(l_11_1.x, l_11_2.y, l_11_2.z), l_11_3, l_11_4, l_11_5)
	Application:draw_line(Vector3(l_11_2.x, l_11_1.y, l_11_1.z), Vector3(l_11_2.x, l_11_1.y, l_11_2.z), l_11_3, l_11_4, l_11_5)
	Application:draw_line(Vector3(l_11_2.x, l_11_2.y, l_11_1.z), Vector3(l_11_2.x, l_11_2.y, l_11_2.z), l_11_3, l_11_4, l_11_5)
	Application:draw_line(Vector3(l_11_1.x, l_11_1.y, l_11_2.z), Vector3(l_11_2.x, l_11_1.y, l_11_2.z), l_11_3, l_11_4, l_11_5)
	Application:draw_line(Vector3(l_11_1.x, l_11_1.y, l_11_2.z), Vector3(l_11_1.x, l_11_2.y, l_11_2.z), l_11_3, l_11_4, l_11_5)
	Application:draw_line(Vector3(l_11_2.x, l_11_2.y, l_11_2.z), Vector3(l_11_1.x, l_11_2.y, l_11_2.z), l_11_3, l_11_4, l_11_5)
	Application:draw_line(Vector3(l_11_2.x, l_11_2.y, l_11_2.z), Vector3(l_11_2.x, l_11_1.y, l_11_2.z), l_11_3, l_11_4, l_11_5)
end

getmetatable(Application).draw_rotation_size = function(l_12_0, l_12_1, l_12_2, l_12_3)
	if script_debug.draw_enabled then
		Application:draw_line(l_12_1, l_12_1 + l_12_2:x() * l_12_3, 1, 0, 0)
		Application:draw_line(l_12_1, l_12_1 + l_12_2:y() * l_12_3, 0, 1, 0)
		Application:draw_line(l_12_1, l_12_1 + l_12_2:z() * l_12_3, 0, 0, 1)
	end
end

getmetatable(Application).draw_arrow = function(l_13_0, l_13_1, l_13_2, l_13_3, l_13_4, l_13_5, l_13_6)
	if script_debug.draw_enabled then
		if not l_13_6 then
			l_13_6 = 1
		end
		local l_13_7 = l_13_2 - l_13_1:length()
		local l_13_8 = l_13_2 - l_13_1:normalized()
		local l_13_9 = l_13_1 + l_13_8 * (l_13_7 - 100 * l_13_6)
		Application:draw_cylinder(l_13_1, l_13_9, 10 * l_13_6, l_13_3, l_13_4, l_13_5)
		Application:draw_cone(l_13_2, l_13_9, 40 * l_13_6, l_13_3, l_13_4, l_13_5)
	end
end

getmetatable(Application).toggle_safe_rect = function(l_14_0)
	if managers.viewport then
		managers.viewport:toggle_safe_rect()
	end
end

getmetatable(Application).stack_dump_error = function(l_15_0, ...)
	Application:error(...)
	cat_stack_dump("debug")
end

Draw:pen()
Pen.arrow = function(l_16_0, l_16_1, l_16_2, l_16_3)
	if script_debug.draw_enabled then
		if not l_16_3 then
			l_16_3 = 1
		end
		local l_16_4 = l_16_2 - l_16_1:length()
		local l_16_5 = l_16_2 - l_16_1:normalized()
		local l_16_6 = l_16_1 + l_16_5 * (l_16_4 - 100 * l_16_3)
		l_16_0:cylinder(l_16_1, l_16_6, 10 * l_16_3)
		l_16_0:cone(l_16_2, l_16_6, 40 * l_16_3)
	end
end

Rotation.__add = function(l_17_0, l_17_1)
	local l_17_2 = Rotation
	local l_17_3 = l_17_0:yaw() + l_17_1:yaw()
	local l_17_4 = l_17_0:pitch() + l_17_1:pitch()
	local l_17_7 = l_17_0:roll()
	local l_17_6 = l_17_1:roll()
	l_17_7 = l_17_7 + l_17_6
	local l_17_5 = nil
	return l_17_2(l_17_3, l_17_4, l_17_7)
end

Rotation.__sub = function(l_18_0, l_18_1)
	local l_18_2 = Rotation
	local l_18_3 = l_18_0:yaw() - l_18_1:yaw()
	local l_18_4 = l_18_0:pitch() - l_18_1:pitch()
	local l_18_7 = l_18_0:roll()
	local l_18_6 = l_18_1:roll()
	l_18_7 = l_18_7 - l_18_6
	local l_18_5 = nil
	return l_18_2(l_18_3, l_18_4, l_18_7)
end

Rotation.__div = function(l_19_0, l_19_1)
	local l_19_2 = Rotation
	local l_19_3 = l_19_0:yaw() / l_19_1:yaw()
	local l_19_4 = l_19_0:pitch() / l_19_1:pitch()
	local l_19_7 = l_19_0:roll()
	local l_19_6 = l_19_1:roll()
	l_19_7 = l_19_7 / l_19_6
	local l_19_5 = nil
	return l_19_2(l_19_3, l_19_4, l_19_7)
end

Rotation.__mod = function(l_20_0, l_20_1)
	local l_20_2 = Rotation
	local l_20_3 = l_20_0:yaw() % l_20_1:yaw()
	local l_20_4 = l_20_0:pitch() % l_20_1:pitch()
	local l_20_7 = l_20_0:roll()
	local l_20_6 = l_20_1:roll()
	l_20_7 = l_20_7 % l_20_6
	local l_20_5 = nil
	return l_20_2(l_20_3, l_20_4, l_20_7)
end

Rotation.__unm = function(l_21_0)
	local l_21_1 = Rotation
	local l_21_2 = -l_21_0:yaw()
	local l_21_3 = -l_21_0:pitch()
	local l_21_5 = l_21_0:roll
	l_21_5 = l_21_5(l_21_0)
	l_21_5 = -l_21_5
	local l_21_4 = nil
	return l_21_1(l_21_2, l_21_3, l_21_5)
end

Rotation.__concat = function(l_22_0, l_22_1)
	return tostring(l_22_0) .. tostring(l_22_1)
end

Rotation.rotate_with = function(l_23_0, l_23_1)
	local l_23_2 = Rotation
	local l_23_3 = l_23_0:y():rotate_with(l_23_1)
	local l_23_4, l_23_5, l_23_6 = l_23_0:z():rotate_with(l_23_1), .end
	return l_23_2(l_23_3, l_23_4, l_23_5, l_23_6)
end

app_func = function(l_24_0, l_24_1)
	getmetatable(Application)[l_24_0] = function(...)
		-- upvalues: l_24_1
		l_24_1(...)
  end
end


