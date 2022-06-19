require("shared/Bezier")
if not AMFlyerTrackStart then
	AMFlyerTrackStart = class(CoreActionElement)
end
AMFlyerTrackStart.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
	World:preload_unit("rail_path")
	managers.unit_scripting:define_unit(l_1_0._name, "no_group")
end

AMFlyerTrackStart.activate_now = function(l_2_0)
	if l_2_0._mode == "spawn" then
		l_2_0:_spawn()
	elseif l_2_0._mode == "kill_flyers" then
		l_2_0:_kill_flyers()
	else
		Application:error("No action for unit spawner! (" .. l_2_0._name .. ")")
		l_2_0:_spawn()
	end
end

AMFlyerTrackStart._spawn = function(l_3_0)
	l_3_0._path_unit = World:spawn_unit("rail_path", l_3_0.position, l_3_0.rotation)
	local l_3_1 = Bezier:new(l_3_0.waypoints, 6)
	l_3_0._path_unit:path():set(l_3_1:get_curve_points())
	l_3_0._path_unit:path()._namex = l_3_0._name
	managers.unit_scripting:register_unit(l_3_0._name, l_3_0._path_unit)
	l_3_0:deactivate_now()
end

AMFlyerTrackStart._kill_flyers = function(l_4_0)
	local l_4_1 = managers.unit_scripting:get_unit_by_name(l_4_0._name)
	l_4_1:path():despawn_users()
	l_4_0:deactivate_now()
end


