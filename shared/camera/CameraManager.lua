require("shared/camera/CameraSetupNode")
if not CameraManager then
	CameraManager = class()
end
local l_0_0 = "depends_on"
local l_0_1 = "unit"
CameraManager.init = function(l_1_0)
	l_1_0._camera_setup_nodes = {}
	l_1_0._listeners = {}
	l_1_0._listeners_id = 0
	l_1_0._listeners_count = 0
	l_1_0._effects = {}
	l_1_0._effects_id = 0
	l_1_0._effects_count = 0
end

CameraManager.load_cameras = function(l_2_0, l_2_1)
	local l_2_2 = assert
	l_2_2(not l_2_1 or l_2_1 ~= "")
	l_2_2 = File
	 -- DECOMPILER ERROR: Overwrote pending register.

	assert(l_2_2, "No file named: " .. l_2_1)
	local l_2_4 = File:new_parse_xml(l_2_1)
	local l_2_11, l_2_12 = assert, l_2_4:name() == "camera"
	l_2_11(l_2_12, l_2_4:name())
	l_2_11, l_2_12 = l_2_4:parameter, l_2_4
	l_2_11 = l_2_11(l_2_12, "name")
	l_2_12 = assert
	local l_2_7 = nil
	l_2_7 = not l_2_11 or l_2_11 ~= ""
	l_2_12(l_2_7)
	l_2_12, l_2_7 = l_2_0:_parse_cameras_xml_node, l_2_0
	l_2_12 = l_2_12(l_2_7, l_2_4)
	l_2_7 = l_2_0._camera_setup_nodes
	l_2_7 = l_2_7[l_2_11]
	if l_2_7 then
		l_2_7 = ipairs
		l_2_7 = l_2_7(l_2_12)
		for i_0,i_1 in l_2_7 do
			table.insert(l_2_0._camera_setup_nodes[l_2_11], i_1)
		end
	else
		l_2_0._camera_setup_nodes[l_2_11] = l_2_12
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CameraManager._parse_cameras_xml_node = function(l_3_0, l_3_1)
	local l_3_7, l_3_8 = nil
	local l_3_2 = {}
	local l_3_3 = l_3_1:children()
	local l_3_4 = l_3_3
	for i_0 in l_3_4 do
		if l_3_0:_parse_xml_node(i_0) then
			table.insert(l_3_2, l_3_0:_parse_xml_node(i_0))
		end
	end
	return l_3_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CameraManager._parse_xml_node = function(l_4_0, l_4_1)
	-- upvalues: l_0_0 , l_0_1
	do
		local l_4_2 = l_4_1:name()
		if l_4_2 == l_0_0 then
			local l_4_3 = l_4_1:parameter(l_0_1)
			local l_4_4 = assert
			do
				l_4_4(not l_4_3 or l_4_3 ~= "")
				l_4_4 = World
				l_4_4(l_4_4, l_4_3)
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		else
			return l_4_0:_create_setup_node(l_4_1)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CameraManager._create_setup_node = function(l_5_0, l_5_1)
	-- upvalues: l_0_0
	local l_5_11, l_5_12 = nil
	local l_5_2 = l_5_1:name()
	local l_5_3 = assert
	l_5_3(l_5_2 ~= l_0_0)
	local l_5_6 = l_5_1:parameters()
	local l_5_7 = l_5_1:children()
	local l_5_8 = l_5_7
	for i_0 in l_5_8 do
		if l_5_0:_parse_xml_node(i_0) then
			table.insert(l_5_3, l_5_0:_parse_xml_node(i_0))
		end
	end
	assert(not l_5_1:parameter("class") or l_5_1:parameter("class") ~= "")
	assert(_G[l_5_1:parameter("class")])
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if _G[l_5_1:parameter("class")].preload_units then
		_G[l_5_1:parameter("class")].preload_units(l_5_6)
	end
	return CameraSetupNode:new(l_5_1:parameter("class"), l_5_6, l_5_3)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

local l_0_3 = function(l_6_0, l_6_1)
	-- upvalues: l_0_2
	local l_6_5, l_6_6, l_6_7, l_6_8, l_6_9, l_6_10, l_6_11, l_6_12 = nil
	for i_0,i_1 in pairs(l_6_0) do
		if i_1:settings().name == l_6_1 then
			return i_1
		end
		for l_6_13,i_1 in l_6_2 do
			local l_6_15 = nil
			if l_0_2(i_1:children(), l_6_1) then
				return l_0_2(i_1:children(), l_6_1)
			end
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

do
	local l_0_4 = function(l_11_0, l_11_1)
	local l_11_2 = math.clamp
	local l_11_3 = l_11_0 / l_11_1
	local l_11_4 = 0
	local l_11_5 = 1
	return l_11_2(l_11_3, l_11_4, l_11_5)
end

end
 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

 -- WARNING: undefined locals caused missing assignments!

