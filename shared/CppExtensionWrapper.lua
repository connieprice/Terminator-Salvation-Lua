local L1_0
function L1_0(A0_1)
	local L1_2
	L1_2 = {}
	function L1_2.init(A0_3, ...)
		local L2_5, L3_6
		L2_5 = _UPVALUE0_
		L3_6 = L2_5
		L2_5 = L2_5.new
		L2_5 = L2_5(L3_6, ...)
		A0_3.cpp_class_instance = L2_5
		L3_6 = {}
		function L3_6.__index(A0_7, A1_8)
			local L2_9, L3_10
			L2_9 = _UPVALUE0_
			L2_9 = L2_9[A1_8]
			if L2_9 then
				function L3_10(A0_11, ...)
					local L2_13, L3_14, L4_15
					L2_13 = _UPVALUE0_
					L3_14 = _UPVALUE1_
					L4_15 = ...
					return L2_13(L3_14, L4_15)
				end
				return L3_10
			else
				L3_10 = nil
				return L3_10
			end
		end
		setmetatable(A0_3, L3_6)
	end
	L1_2.__index = L1_2
	return L1_2
end
cpp_extension_wrapper = L1_0
