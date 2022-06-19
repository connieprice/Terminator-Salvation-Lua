CoreEnvironmentAreaManager = CoreEnvironmentAreaManager or class()
function CoreEnvironmentAreaManager.init(A0_0)
	A0_0._areas = {}
	A0_0._current_area = nil
	A0_0._area_iterator = 1
	A0_0._areas_per_frame = 1
	A0_0._blocks = 0
	A0_0.GAME_DEFAULT_ENVIRONMENT = "default"
	A0_0._default_environment = A0_0.GAME_DEFAULT_ENVIRONMENT
	A0_0._current_environment = A0_0.GAME_DEFAULT_ENVIRONMENT
	A0_0:set_to_default()
	A0_0._environments = A0_0:_environments()
	A0_0._environment_changed_callback = {}
	A0_0:set_default_transition_time(0.1)
	A0_0.POSITION_OFFSET = 50
end
function CoreEnvironmentAreaManager.set_default_transition_time(A0_1, A1_2)
	A0_1._default_transition_time = A1_2
end
function CoreEnvironmentAreaManager.default_transition_time(A0_3)
	local L1_4
	L1_4 = A0_3._default_transition_time
	return L1_4
end
function CoreEnvironmentAreaManager.areas(A0_5)
	local L1_6
	L1_6 = A0_5._areas
	return L1_6
end
function CoreEnvironmentAreaManager._environments(A0_7)
	local L1_8
	L1_8 = managers
	L1_8 = L1_8.environment
	L1_8 = L1_8.getall
	L1_8 = L1_8(L1_8)
	table.sort(L1_8)
	return L1_8
end
function CoreEnvironmentAreaManager.environments(A0_9)
	local L1_10
	L1_10 = A0_9._environments
	return L1_10
end
function CoreEnvironmentAreaManager.game_default_environment(A0_11)
	local L1_12
	L1_12 = A0_11.GAME_DEFAULT_ENVIRONMENT
	return L1_12
end
function CoreEnvironmentAreaManager.default_environment(A0_13)
	local L1_14
	L1_14 = A0_13._default_environment
	return L1_14
end
function CoreEnvironmentAreaManager.set_default_environment(A0_15, A1_16, A2_17, A3_18)
	local L4_19, L5_20, L6_21, L7_22, L8_23
	A0_15._default_environment = A1_16
	if not L4_19 then
		if not A3_18 then
			L8_23 = L5_20(L6_21)
			for L7_22, L8_23 in L4_19(L5_20, L6_21, L7_22, L8_23, L5_20(L6_21)) do
				A0_15:_set_environment(A0_15._default_environment, A2_17, L8_23)
			end
		else
			L7_22 = A2_17
			L8_23 = A3_18
			L4_19(L5_20, L6_21, L7_22, L8_23)
		end
	end
end
function CoreEnvironmentAreaManager.set_to_current_environment(A0_24, A1_25)
	A0_24:_set_environment(A0_24._current_environment, nil, A1_25)
end
function CoreEnvironmentAreaManager._set_environment(A0_26, A1_27, A2_28, A3_29)
	A0_26._current_environment = A1_27
	A3_29:set_environment(A1_27, A2_28)
end
function CoreEnvironmentAreaManager.current_environment(A0_30)
	local L1_31
	L1_31 = A0_30._current_environment
	return L1_31
end
function CoreEnvironmentAreaManager.set_to_default(A0_32)
	local L1_33, L2_34, L3_35, L4_36, L5_37, L6_38
	L1_33 = managers
	L1_33 = L1_33.viewport
	L1_33 = L1_33.active_viewports
	L1_33 = L1_33(L2_34)
	for L5_37, L6_38 in L2_34(L3_35) do
		A0_32:set_default_environment(A0_32.GAME_DEFAULT_ENVIRONMENT, nil, L6_38)
	end
end
function CoreEnvironmentAreaManager.add_area(A0_39, A1_40)
	local L2_41
	L2_41 = EnvironmentArea
	L2_41 = L2_41.new
	L2_41 = L2_41(L2_41, A1_40)
	table.insert(A0_39._areas, L2_41)
	return L2_41
end
function CoreEnvironmentAreaManager.remove_area(A0_42, A1_43)
	if A1_43 == A0_42._current_area then
		A0_42:_leave_current_area(A0_42._current_area:transition_time())
	end
	table.delete(A0_42._areas, A1_43)
	A0_42._area_iterator = 1
end
function CoreEnvironmentAreaManager.update(A0_44, A1_45, A2_46)
	local L3_47, L4_48, L5_49, L6_50, L7_51, L8_52, L9_53, L10_54, L11_55, L12_56
	L3_47 = managers
	L3_47 = L3_47.viewport
	L3_47 = L3_47.active_viewports
	L3_47 = L3_47(L4_48)
	for L7_51, L8_52 in L4_48(L5_49) do
		L10_54 = L8_52
		L9_53 = L8_52.camera
		L9_53 = L9_53(L10_54)
		if not L9_53 then
			return
		end
		L10_54 = A0_44._blocks
		if L10_54 > 0 then
			return
		end
		L11_55 = L9_53
		L10_54 = L9_53.position
		L10_54 = L10_54(L11_55)
		L12_56 = L9_53
		L11_55 = L9_53.new_rotation
		L11_55 = L11_55(L12_56)
		L12_56 = L11_55
		L11_55 = L11_55.y
		L11_55 = L11_55(L12_56)
		L12_56 = A0_44.POSITION_OFFSET
		L11_55 = L11_55 * L12_56
		L10_54 = L10_54 + L11_55
		L11_55 = nil
		L12_56 = A0_44._current_area
		if L12_56 then
			L12_56 = A0_44._current_area
			L12_56 = L12_56.still_inside
			L12_56 = L12_56(L12_56, L10_54)
			L11_55 = L12_56
			if L11_55 then
				return
			end
			L12_56 = A0_44._current_area
			L12_56 = L12_56.transition_time
			L12_56 = L12_56(L12_56)
			A0_44._current_area = nil
			A0_44:_check_inside(L10_54, L8_52)
			if A0_44._current_area then
				return
			end
			A0_44:_leave_current_area(L12_56, L8_52)
		end
		L12_56 = A0_44._check_inside
		L12_56(A0_44, L10_54, L8_52)
	end
end
function CoreEnvironmentAreaManager._check_inside(A0_57, A1_58, A2_59)
	local L3_60, L4_61, L5_62, L6_63, L7_64, L8_65
	if L3_60 > 0 then
		for L6_63 = 1, A0_57._areas_per_frame do
			L7_64 = A0_57._areas
			L8_65 = A0_57._area_iterator
			L7_64 = L7_64[L8_65]
			L8_65 = math
			L8_65 = L8_65.mod
			L8_65 = L8_65(A0_57._area_iterator, #A0_57._areas)
			L8_65 = L8_65 + 1
			A0_57._area_iterator = L8_65
			L8_65 = L7_64.is_inside
			L8_65 = L8_65(L7_64, A1_58)
			if L8_65 then
				L8_65 = L7_64.environment
				L8_65 = L8_65(L7_64)
				if L8_65 ~= A0_57._current_environment then
					L8_65 = L7_64.transition_time
					L8_65 = L8_65(L7_64)
					if L7_64:permanent() then
						A0_57:set_default_environment(L7_64:environment(), L8_65, A2_59)
						return
					else
						A0_57:_set_environment(L7_64:environment(), L8_65, A2_59)
					end
				end
				A0_57._current_area = L7_64
				break
			end
		end
	end
end
function CoreEnvironmentAreaManager._leave_current_area(A0_66, A1_67, A2_68)
	A0_66._current_area = nil
	if A0_66._default_environment ~= A0_66._current_environment then
		A0_66:_set_environment(A0_66._default_environment, A1_67, A2_68)
	end
end
function CoreEnvironmentAreaManager.environment_at_position(A0_69, A1_70)
	local L2_71
	L2_71 = A0_69._default_environment
	for 