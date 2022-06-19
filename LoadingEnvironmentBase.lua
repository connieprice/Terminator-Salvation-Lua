local L0_0, L1_1
L0_0 = class
L0_0 = L0_0 or function(...)
	local L1_3, L2_4
	L1_3 = (...)
	L2_4 = select
	L2_4 = L2_4("#", ...)
	if L2_4 >= 1 and L1_3 == nil then
		L2_4 = error
		L2_4("trying to inherit from nil", 2)
	end
	L2_4 = {}
	L2_4.super = L1_3
	L2_4.__index = L2_4
	setmetatable(L2_4, L1_3)
	function L2_4.new(A0_5, ...)
		local L2_7
		L2_7 = {}
		setmetatable(L2_7, _UPVALUE0_)
		if L2_7.init then
			return L2_7, L2_7:init(...)
		end
		return L2_7
	end
	return L2_4
end
class = L0_0
L0_0 = math
L1_1 = math
L1_1 = L1_1.lerp
L1_1 = L1_1 or function(A0_8, A1_9, A2_10)
	local L3_11, L4_12
	L3_11 = 1 - A2_10
	L3_11 = A0_8 * L3_11
	L4_12 = A1_9 * A2_10
	L3_11 = L3_11 + L4_12
	return L3_11
end
L0_0.lerp = L1_1
