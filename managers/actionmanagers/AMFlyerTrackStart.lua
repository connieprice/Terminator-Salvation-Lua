require("shared/Bezier")
AMFlyerTrackStart = AMFlyerTrackStart or class(CoreActionElement)
function AMFlyerTrackStart.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
	World:preload_unit("rail_path")
	managers.unit_scripting:define_unit(A0_0._name, "no_group")
end
function AMFlyerTrackStart.activate_now(A0_3)
	if A0_3._mode == "spawn" then
		A0_3:_spawn()
	elseif A0_3._mode == "kill_flyers" then
		A0_3:_kill_flyers()
	else
		Application:error("No action for unit spawner! (" .. A0_3._name .. ")")
		A0_3:_spawn()
	end
end
function AMFlyerTrackStart._spawn(A0_4)
	A0_4._path_unit = World:spawn_unit("rail_path", A0_4.position, A0_4.rotation)
	A0_4._path_unit:path():set(Bezier:new(A0_4.waypoints, 6):get_curve_points())
	A0_4._path_unit:path()._namex = A0_4._name
	managers.unit_scripting:register_unit(A0_4._name, A0_4._path_unit)
	A0_4:deactivate_now()
end
function AMFlyerTrackStart._kill_flyers(A0_5)
	managers.unit_scripting:get_unit_by_name(A0_5._name):path():despawn_users()
	A0_5:deactivate_now()
end
