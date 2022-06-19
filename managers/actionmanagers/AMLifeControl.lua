AMLifeControl = AMLifeControl or class(CoreActionElement)
function AMLifeControl.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
end
function AMLifeControl.activate_now(A0_3)
	if A0_3._mode == "invulnerable" then
		A0_3:_invulnerable()
	elseif A0_3._mode == "normal" then
		A0_3:_normal()
	elseif A0_3._mode == "unprotected" then
		A0_3:_unprotected()
	end
	A0_3:deactivate_now()
end
function AMLifeControl._invulnerable(A0_4)
	local L1_5, L2_6, L3_7, L4_8, L5_9, L6_10
	L1_5(L2_6, L3_7)
	for L4_8, L5_9 in L1_5(L2_6) do
		L6_10 = managers
		L6_10 = L6_10.unit_scripting
		L6_10 = L6_10.get_unit_by_name
		L6_10 = L6_10(L6_10, L5_9.script_name)
		if alive(L6_10) then
			L6_10:damage():set_can_die(false)
			A0_4:_enable_stun(L6_10, false)
		end
	end
end
function AMLifeControl._normal(A0_11)
	local L1_12, L2_13, L3_14, L4_15, L5_16, L6_17
	L1_12(L2_13, L3_14)
	for L4_15, L5_16 in L1_12(L2_13) do
		L6_17 = managers
		L6_17 = L6_17.unit_scripting
		L6_17 = L6_17.get_unit_by_name
		L6_17 = L6_17(L6_17, L5_16.script_name)
		if alive(L6_17) then
			L6_17:damage_data():scale_health(tweak_data.ai.humans.ai_player.damage.HEALTH)
			L6_17:damage():set_can_die(true)
			A0_11:_enable_stun(L6_17, true)
		end
	end
end
function AMLifeControl._unprotected(A0_18)
	local L1_19, L2_20, L3_21, L4_22, L5_23, L6_24
	L1_19(L2_20, L3_21)
	for L4_22, L5_23 in L1_19(L2_20) do
		L6_24 = managers
		L6_24 = L6_24.unit_scripting
		L6_24 = L6_24.get_unit_by_name
		L6_24 = L6_24(L6_24, L5_23.script_name)
		if alive(L6_24) then
			L6_24:damage_data():scale_health(5)
			L6_24:damage():set_can_die(true)
			L6_24:damage():set_immune_to_damage(false)
			A0_18:_enable_stun(L6_24, true)
		end
	end
end
function AMLifeControl._enable_stun(A0_25, A1_26)
	if A1_26:enemy_data() then
		A1_26:enemy_data().can_be_stunned = false
	end
end
