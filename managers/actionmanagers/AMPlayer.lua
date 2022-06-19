AMPlayer = AMPlayer or class(CoreActionElement)
function AMPlayer.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
	World:preload_unit("player")
end
function AMPlayer.activate_now(A0_3)
	A0_3._unit = World:spawn_unit("player", A0_3.position, A0_3.rotation)
	script_data.player = A0_3._unit
	if A0_3.player_start then
		A0_3._unit:player_data().spawning_id = A0_3.player_start.spawner_id[1]
	end
	A0_3:deactivate_now()
end
