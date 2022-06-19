require("user/pc/PcUserId")
if not PcUserIdHandler then
	PcUserIdHandler = class()
end
PcUserIdHandler.init = function(l_1_0)
	Network:set_receiver("PcUserIdHandler", l_1_0)
	l_1_0._next_local_id = 0
	l_1_0._user_id_to_pc_user_id = {}
end

PcUserIdHandler.send_id = function(l_2_0, l_2_1, l_2_2)
	local l_2_3 = l_2_0:user_id_from_platform_specific_user_id(l_2_2)
	if not l_2_3 then
		l_2_0._next_local_id = l_2_0._next_local_id + 1
		l_2_3 = l_2_0._next_local_id
		l_2_0._user_id_to_pc_user_id[l_2_3] = l_2_2
	end
	l_2_1:set_id_to_pc_user_id_lookup(l_2_3, l_2_2.user_id)
end

PcUserIdHandler.set_id_to_pc_user_id_lookup = function(l_3_0, l_3_1, l_3_2, l_3_3)
	l_3_0._user_id_to_pc_user_id[l_3_1] = PcUserId:new(l_3_2)
end

PcUserIdHandler.user_id_from_platform_specific_user_id = function(l_4_0, l_4_1)
	local l_4_2, l_4_5, l_4_6, l_4_7 = nil
	for i_0,i_1 in pairs(l_4_0._user_id_to_pc_user_id) do
		if l_4_1.user_id == i_1.user_id then
			l_4_2 = i_0
	else
		end
	end
	return l_4_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

PcUserIdHandler.platform_specific_user_id_from_user_id = function(l_5_0, l_5_1)
	local l_5_2 = l_5_0._user_id_to_pc_user_id[l_5_1]
	assert(l_5_2)
	return l_5_2
end


