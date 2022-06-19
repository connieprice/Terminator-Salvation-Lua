require("cover/CoverBox")
require("utils/ListHelper")
if not CoverBody then
	CoverBody = class()
end
CoverBody.init = function(l_1_0, l_1_1)
	l_1_0._body = l_1_1
	l_1_0:_extract_cover_boxes()
end

CoverBody.get_covers = function(l_2_0)
	local l_2_5, l_2_6 = nil
	if not l_2_0._body:enabled() then
		return {}
	end
	local l_2_1 = {}
	for i_0,i_1 in ipairs(l_2_0._cover_boxes) do
		l_2_1 = ListHelper.concat_lists(l_2_1, i_1:get_covers())
	end
	return l_2_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoverBody._extract_cover_boxes = function(l_3_0)
	l_3_0._cover_boxes = {}
	local l_3_1 = l_3_0._body:oobb()
	local l_3_2 = CoverBox:new(l_3_1:center(), l_3_0._body:rotation(), l_3_1:size() * 0.5)
	table.insert(l_3_0._cover_boxes, l_3_2)
end

CoverBody.register = function(l_4_0, l_4_1, l_4_2)
	local l_4_6, l_4_7, l_4_8, l_4_9 = nil
	for i_0,i_1 in pairs(l_4_0._cover_boxes) do
		i_1:register(l_4_1, l_4_2)
	end
end

CoverBody.unregister = function(l_5_0, l_5_1)
	local l_5_5, l_5_6, l_5_7, l_5_8 = nil
	for i_0,i_1 in pairs(l_5_0._cover_boxes) do
		i_1:unregister(l_5_1)
	end
end


