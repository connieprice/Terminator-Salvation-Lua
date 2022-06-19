require("debug/DebugUserJoin")
if not DebugSettings then
	DebugSettings = class()
end
DebugSettings.init = function(l_1_0, l_1_1)
	local l_1_2 = {}
	l_1_2.default_controller = l_1_0._parse_default_controller
	local l_1_8 = assert
	l_1_8(File:config_exists(l_1_1))
	l_1_8 = File
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_1_3 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_1_4 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	for i_0 in l_1_4 do
		local l_1_9 = l_1_7:name()
		local l_1_10 = l_1_2[l_1_9]
		if not l_1_10 then
			Application:error("Unknown setting: " .. l_1_9)
		end
		l_1_10(l_1_0, l_1_7)
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if not l_1_4.level_info then
		cat_print("debug", "NOTE: Global.level_info not set in DebugSettings!!")
	end
	if Global.level_info or Application:editor() then
		l_1_0._user_join = DebugUserJoin:new(l_1_0._default_controller_type)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

DebugSettings.default_controller_type = function(l_2_0)
	return l_2_0._default_controller_type
end

DebugSettings._parse_default_controller = function(l_3_0, l_3_1)
	local l_3_2 = "type"
	assert(l_3_1:has_parameter(l_3_2))
	l_3_0._default_controller_type = l_3_1:parameter(l_3_2)
end

DebugSettings.update = function(l_4_0, l_4_1)
	if l_4_0._user_join then
		l_4_0._user_join:update(l_4_1)
	end
end


