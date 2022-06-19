if not AMPlayer then
	AMPlayer = class(CoreActionElement)
end
AMPlayer.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
	World:preload_unit("player")
end

AMPlayer.activate_now = function(l_2_0)
	l_2_0._unit = World:spawn_unit("player", l_2_0.position, l_2_0.rotation)
	script_data.player = l_2_0._unit
	if l_2_0.player_start then
		l_2_0._unit:player_data().spawning_id = l_2_0.player_start.spawner_id[1]
	end
	l_2_0:deactivate_now()
end


