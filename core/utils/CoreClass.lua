core:module("CoreClass")
__class_names = {}
function class(...)
	local L1_1, L2_2
	L1_1 = (...)
	L2_2 = select
	L2_2 = L2_2("#", ...)
	if L2_2 >= 1 and L1_1 == nil then
		L2_2 = error
		L2_2("trying to inherit from nil", 2)
	end
	L2_2 = {}
	L2_2.super = L1_1
	L2_2.__index = L2_2
	setmetatable(L2_2, L1_1)
	function L2_2.new(A0_3, ...)
		local L2_5
		L2_5 = {}
		setmetatable(L2_5, _UPVALUE0_)
		if L2_5.init then
			return L2_5, L2_5:init(...)
		end
		return L2_5
	end
	return L2_2
end
function class_name(A0_6)
	if not __class_names[A0_6] then
		for 