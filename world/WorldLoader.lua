require("effects/EffectsLoader")
base_require("utils/dev/FreeFlight", nil, "RELEASE")
WorldLoader = WorldLoader or class()
function WorldLoader.init(A0_0, A1_1, A2_2)
	A0_0._is_done = false
	A0_0:_load(A1_1, A2_2)
end
function WorldLoader._load(A0_3, A1_4, A2_5)
	assert(A1_4)
	A2_5 = A2_5 or "stage1"
	A0_3._world = WorldHolder:new("\\data\\levels\\" .. A1_4 .. "\\world.level")
	A0_3._world:create_world("world", "all", Vector3(0, 0, 0))
	managers.world:parse("data\\levels\\" .. A1_4 .. "\\mission.xml", A2_5)
	managers.ai_graph:load("data\\levels\\" .. A1_4 .. "\\")
	A0_3._is_done = true
end
function WorldLoader.update(A0_6, A1_7)
end
function WorldLoader.is_done(A0_8)
	local L1_9
	L1_9 = A0_8._is_done
	return L1_9
end
