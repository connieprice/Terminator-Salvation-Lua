require("shared/ArrayAlgorithms")
if not DirectorManager then
	DirectorManager = class()
end
DirectorManager.init = function(l_1_0)
	l_1_0._acting_directors = {}
end

DirectorManager.update = function(l_2_0, l_2_1, l_2_2)
	local l_2_6, l_2_7, l_2_8, l_2_9 = nil
	for i_0,i_1 in pairs(l_2_0._acting_directors) do
		i_1:update(l_2_1, l_2_2)
	end
end

DirectorManager.add_ai_unit = function(l_3_0, l_3_1)
	local l_3_5, l_3_6, l_3_7, l_3_8 = nil
	for i_0,i_1 in pairs(l_3_0._acting_directors) do
		i_1:add_ai_unit(l_3_1)
	end
end

DirectorManager.remove_ai_unit = function(l_4_0, l_4_1)
	local l_4_5, l_4_6, l_4_7, l_4_8 = nil
	for i_0,i_1 in pairs(l_4_0._acting_directors) do
		i_1:remove_ai_unit(l_4_1)
	end
end

DirectorManager.add_non_ai_unit = function(l_5_0, l_5_1)
	local l_5_5, l_5_6, l_5_7, l_5_8, l_5_9, l_5_10 = nil
	for i_0,i_1 in pairs(l_5_0._acting_directors) do
		if i_1.add_non_ai_unit then
			i_1:add_non_ai_unit(l_5_1)
		end
	end
end

DirectorManager.remove_non_ai_unit = function(l_6_0, l_6_1)
	local l_6_5, l_6_6, l_6_7, l_6_8, l_6_9, l_6_10 = nil
	for i_0,i_1 in pairs(l_6_0._acting_directors) do
		if i_1.remove_non_ai_unit then
			i_1:remove_non_ai_unit(l_6_1)
		end
	end
end

DirectorManager.register_acting_director = function(l_7_0, l_7_1, l_7_2)
	assert(not l_7_0[l_7_1])
	l_7_0[l_7_1] = l_7_2
	table.insert(l_7_0._acting_directors, l_7_2)
end


