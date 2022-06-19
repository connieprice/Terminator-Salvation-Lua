require("managers/actionmanagers/AiUnitSpawn")
if not AMPlayerTankStart then
	AMPlayerTankStart = class(AiUnitSpawn)
end
AMPlayerTankStart.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4)
	AiUnitSpawn.init(l_1_0, l_1_1, l_1_2, l_1_3)
	if not l_1_4 then
		l_1_4 = "player_tank"
	end
	l_1_0:setup(l_1_4)
	l_1_0._is_persistent = true
end

AMPlayerTankStart._spawn = function(l_2_0)
	if not l_2_0._player_slot then
		l_2_0._player_slot = 1
	end
	local l_2_1 = nil
	if l_2_0._is_persistent then
		local l_2_2 = managers.drama_scene:unit_name_to_script_name(l_2_0._spawn_unit_name)
		if l_2_2 then
			l_2_1 = managers.unit_scripting:get_unit_by_name(l_2_2)
		end
	else
		l_2_1 = managers.unit_scripting:get_unit_by_name(l_2_0._name)
	end
	local l_2_3, l_2_4 = nil, nil
	l_2_3 = UnitSpawnUtility.spawn_position(l_2_0.waypoint_paths, l_2_0.position, l_2_0.rotation)
	if alive(l_2_1) then
		local l_2_5 = managers.unit_scripting:unit_script_name(l_2_1)
		managers.unit_scripting:register_new_unit_name(l_2_5, l_2_0._name, l_2_1)
		managers.drama_scene:set_unit_name_to_script_name(l_2_0._spawn_unit_name, l_2_0._name)
		l_2_0:deactivate_now()
		return 
	end
	l_2_1 = World:spawn_unit(l_2_0._spawn_unit_name, l_2_3, l_2_4)
	if l_2_0._player_slot then
		assert(not managers.player_slot:slot(l_2_0._player_slot):spawned_unit())
		managers.player_slot:set_unit(l_2_0._player_slot, l_2_1, l_2_1:name(), l_2_3, l_2_4, false, true)
	end
	managers.unit_scripting:register_unit(l_2_0._name, l_2_1)
	managers.drama_scene:set_unit_name_to_script_name(l_2_0._spawn_unit_name, l_2_0._name)
	l_2_0:deactivate_now()
end


