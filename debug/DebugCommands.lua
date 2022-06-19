DebugCommands = DebugCommands or class()
function DebugCommands.init(A0_0)
	local L1_1
end
function DebugCommands.set_god_mode(A0_2, A1_3)
	A0_2:_for_each_player(function(A0_4)
		if A0_4:damage() then
			A0_4:damage():set_immune_to_damage(_UPVALUE0_)
		end
	end)
end
function DebugCommands.show_huds(A0_5, A1_6)
	local L2_7
	L2_7 = managers
	L2_7 = L2_7.user_viewport
	L2_7 = L2_7.viewports
	L2_7 = L2_7(L2_7)
	A0_5:_for_each(L2_7, function(A0_8)
		if _UPVALUE0_ then
			A0_8:add_hud()
		else
			A0_8:remove_hud()
		end
	end)
end
function DebugCommands.kill_all_living_enemies(A0_9)
	A0_9:_for_each_enemy(function(A0_10)
		if alive(A0_10) and A0_10:damage() then
			A0_10:damage():set_fully_damaged()
		end
	end)
end
function DebugCommands.drop_player_at_camera_position(A0_11)
	local L1_12, L2_13, L3_14
	L2_13 = A0_11
	L1_12 = A0_11._first_user
	L1_12 = L1_12(L2_13)
	L3_14 = A0_11
	L2_13 = A0_11._camera
	L2_13 = L2_13(L3_14)
	if L1_12 and L2_13 then
		L3_14 = L1_12.assigned_unit
		L3_14 = L3_14(L1_12)
		if L3_14 then
			UnitSpawnUtility.warp_to(L3_14, L3_14:rotation(), L2_13:position())
		end
	end
end
function DebugCommands.control_unit(A0_15, A1_16)
	local L2_17
	if A1_16 then
		L2_17 = select_character
		L2_17 = L2_17()
		if L2_17 then
			view_unit(L2_17)
			control_unit(L2_17)
		end
	else
		L2_17 = reset_view_and_control
		L2_17()
	end
end
function DebugCommands._for_each(A0_18, A1_19, A2_20)
	local L3_21, L4_22, L5_23, L6_24, L7_25
	for L6_24, L7_25 in L3_21(L4_22) do
		A2_20(L7_25)
	end
end
function DebugCommands._for_each_player(A0_26, A1_27)
	local L2_28
	L2_28 = managers
	L2_28 = L2_28.player
	L2_28 = L2_28.human_players
	L2_28 = L2_28(L2_28)
	A0_26:_for_each(L2_28, A1_27)
end
function DebugCommands._for_each_enemy(A0_29, A1_30)
	local L2_31
	L2_31 = World
	L2_31 = L2_31.find_units_quick
	L2_31 = L2_31(L2_31, "all", managers.slot:get_mask("enemies"))
	A0_29:_for_each(L2_31, A1_30)
end
function DebugCommands._for_each_friend(A0_32, A1_33)
	local L2_34
	L2_34 = World
	L2_34 = L2_34.find_units_quick
	L2_34 = L2_34(L2_34, "all", managers.slot:get_mask("players"))
	A0_32:_for_each(L2_34, A1_33)
end
function DebugCommands._first_user(A0_35)
	local L1_36
	L1_36 = 1
	if managers.player_slot:slot(L1_36) then
		return managers.player_slot:slot(L1_36):user()
	end
	return nil
end
function DebugCommands._camera(A0_37)
	local L1_38
	L1_38 = script_debug
	L1_38 = L1_38._freeflight
	L1_38 = L1_38.in_focus
	L1_38 = L1_38(L1_38)
	if L1_38 then
		L1_38 = script_debug
		L1_38 = L1_38._freeflight
		L1_38 = L1_38._camera
		return L1_38
	else
		L1_38 = A0_37._first_user
		L1_38 = L1_38(A0_37)
		if L1_38 then
			return managers.user_viewport:viewport(L1_38):engine_camera()
		end
	end
	L1_38 = nil
	return L1_38
end
function DebugCommands.infinite_ammo(A0_39)
	return script_debug.infinite_ammo
end
function DebugCommands.set_infinite_ammo(A0_40, A1_41)
	script_debug.infinite_ammo = A1_41
end
function DebugCommands.enable_fixed_delta_time(A0_42)
	Application:set_forced_timestep(1 / setup.fps)
	Application:cap_framerate(setup.fps)
end
function DebugCommands.disable_fixed_delta_time(A0_43)
	Application:set_forced_timestep(0)
	Application:cap_framerate(0)
end
