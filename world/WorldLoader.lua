require("effects/EffectsLoader")
base_require("utils/dev/FreeFlight", nil, "RELEASE")
if not WorldLoader then
	WorldLoader = class()
end
WorldLoader.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._is_done = false
	l_1_0:_load(l_1_1, l_1_2)
end

WorldLoader._load = function(l_2_0, l_2_1, l_2_2)
	assert(l_2_1)
	if not l_2_2 then
		l_2_2 = "stage1"
	end
	l_2_0._world = WorldHolder:new("\\data\\levels\\" .. l_2_1 .. "\\world.level")
	l_2_0._world:create_world("world", "all", Vector3(0, 0, 0))
	managers.world:parse("data\\levels\\" .. l_2_1 .. "\\mission.xml", l_2_2)
	managers.ai_graph:load("data\\levels\\" .. l_2_1 .. "\\")
	 -- WARNING: undefined locals caused missing assignments!
end

WorldLoader.update = function(l_3_0, l_3_1)
end

WorldLoader.is_done = function(l_4_0)
	return l_4_0._is_done
end


