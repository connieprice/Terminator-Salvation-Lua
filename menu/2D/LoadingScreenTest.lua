require("menu/loading_screen/LevelLoadingScreen")
require("menu/loading_screen/MenuLoadingScreen")
if not LoadingScreenTest then
	LoadingScreenTest = class()
end
LoadingScreenTest.init = function(l_1_0, l_1_1)
	local l_1_6, l_1_7 = World:find_units_quick, World
	l_1_6 = l_1_6(l_1_7, "all", managers.slot:get_mask("all"))
	local l_1_2 = nil
	l_1_7 = pairs
	l_1_2 = l_1_6
	l_1_7 = l_1_7(l_1_2)
	for i_0,i_1 in l_1_7 do
		l_1_5:set_slot(0)
	end
	l_1_0._viewport:set_camera(World:create_camera())
	l_1_0._viewport:set_active(true)
	local l_1_8 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_1_9 = managers.menu:_get_rotation_controller_info("look"):safe_rect()
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_0._viewport:set_environment()
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_0._viewport:set_dof("loading_screen".DOF_AMOUNT, loading_screen_tweak_data.DOF_NEAR_MIN, loading_screen_tweak_data.DOF_NEAR_MAX, loading_screen_tweak_data.DOF_FAR_MIN, loading_screen_tweak_data.DOF_FAR_MAX)
	local l_1_10 = Overlay:newgui()
	do
		local l_1_11 = l_1_10:create_screen_workspace()
		l_1_0._loading_screen = LevelLoadingScreen:new({head = World:spawn_unit("loading_head", Vector3(0, 0, 0), Rotation(0, 0, 0)), low_pivot = World:spawn_unit("loading_head", Vector3(0, 0, 0), Rotation(0, 0, 0)):get_object("pivot_low"), high_pivot = World:spawn_unit("loading_head", Vector3(0, 0, 0), Rotation(0, 0, 0)):get_object("Point_high")}, World:create_camera(), l_1_11, function()
		return 0
  end, l_1_8, l_1_9)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

LoadingScreenTest.destroy = function(l_2_0)
	l_2_0._loading_screen:destroy()
end

LoadingScreenTest.stop = function(l_3_0)
	l_3_0._loading_screen:fade_down()
end

LoadingScreenTest.fade_down_done = function(l_4_0)
	local l_4_1, l_4_2 = l_4_0._loading_screen:fade_down_done, l_4_0._loading_screen
	return l_4_1(l_4_2)
end

LoadingScreenTest.update = function(l_5_0, l_5_1)
	managers.viewport:set_active_vp(l_5_0._viewport)
	l_5_0._loading_screen:update(l_5_1)
end


