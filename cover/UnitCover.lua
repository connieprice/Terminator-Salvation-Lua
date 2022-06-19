require("cover/CoverBody")
require("utils/ListHelper")
if not UnitCover then
	UnitCover = class()
end
if Application:editor() and not UnitCover.update then
	UnitCover.update = function(l_1_0)
	local l_1_1 = l_1_0._unit:position()
	local l_1_2 = l_1_0._unit:rotation()
	if l_1_1 ~= l_1_0._position or l_1_2 ~= l_1_0._rotation then
		l_1_0:_unregister()
		l_1_0:_register()
	end
end

end
UnitCover.init = function(l_2_0, l_2_1)
	l_2_0._unit = l_2_1
	l_2_0:_register()
end

UnitCover.destroy = function(l_3_0)
	l_3_0:_unregister()
end

UnitCover.get_covers = function(l_4_0)
	local l_4_5, l_4_6 = nil
	local l_4_1 = {}
	for i_0,i_1 in ipairs(l_4_0._cover_bodies) do
		l_4_1 = ListHelper.concat_lists(l_4_1, i_1:get_covers())
	end
	return l_4_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

UnitCover._register = function(l_5_0)
	l_5_0._cover_manager = managers.cover
	l_5_0._cover_bodies = {}
	local l_5_1 = l_5_0._unit:num_bodies()
	if l_5_1 == 0 then
		return 
	end
	for l_5_5 = 0, l_5_1 - 1 do
		local l_5_6 = l_5_0._unit:body(l_5_5)
		local l_5_7 = l_5_6:name()
		if string.find(l_5_7, "cover_") then
			local l_5_8 = CoverBody:new(l_5_6)
			l_5_8:register(l_5_0._cover_manager, l_5_0._unit)
			table.insert(l_5_0._cover_bodies, l_5_8)
		end
	end
	l_5_0._position = l_5_0._unit:position()
	l_5_0._rotation = l_5_0._unit:rotation()
end

UnitCover._unregister = function(l_6_0)
	local l_6_4, l_6_5, l_6_6, l_6_7 = nil
	for i_0,i_1 in pairs(l_6_0._cover_bodies) do
		i_1:unregister(l_6_0._cover_manager)
	end
	l_6_0._cover_bodies = {}
	l_6_0._cover_manager = nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


