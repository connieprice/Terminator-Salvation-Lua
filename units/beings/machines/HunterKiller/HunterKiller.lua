if not HunterKiller then
	HunterKiller = class()
end
HunterKiller.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_1:set_animation_lod(1, 100000, 10000000, 10000000)
end


