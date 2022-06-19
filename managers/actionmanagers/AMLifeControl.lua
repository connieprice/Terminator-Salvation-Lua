if not AMLifeControl then
	AMLifeControl = class(CoreActionElement)
end
AMLifeControl.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMLifeControl.activate_now = function(l_2_0)
	if l_2_0._mode == "invulnerable" then
		l_2_0:_invulnerable()
	elseif l_2_0._mode == "normal" then
		l_2_0:_normal()
	elseif l_2_0._mode == "unprotected" then
		l_2_0:_unprotected()
	end
	l_2_0:deactivate_now()
end

AMLifeControl._invulnerable = function(l_3_0)
	local l_3_4, l_3_5, l_3_6, l_3_7 = nil
	cat_print("debug", "Invulnerable!!")
	for i_0,i_1 in pairs(l_3_0.units) do
		if alive(managers.unit_scripting:get_unit_by_name(i_1.script_name)) then
			managers.unit_scripting:get_unit_by_name(i_1.script_name):damage():set_can_die(false)
			l_3_0:_enable_stun(managers.unit_scripting:get_unit_by_name(i_1.script_name), false)
		end
	end
end

AMLifeControl._normal = function(l_4_0)
	local l_4_4, l_4_5, l_4_6, l_4_7 = nil
	cat_print("debug", "Normal!!")
	for i_0,i_1 in pairs(l_4_0.units) do
		if alive(managers.unit_scripting:get_unit_by_name(i_1.script_name)) then
			managers.unit_scripting:get_unit_by_name(i_1.script_name):damage_data():scale_health(tweak_data.ai.humans.ai_player.damage.HEALTH)
			managers.unit_scripting:get_unit_by_name(i_1.script_name):damage():set_can_die(true)
			l_4_0:_enable_stun(managers.unit_scripting:get_unit_by_name(i_1.script_name), true)
		end
	end
end

AMLifeControl._unprotected = function(l_5_0)
	local l_5_4, l_5_5, l_5_6, l_5_7 = nil
	cat_print("debug", "Unprotected!!")
	for i_0,i_1 in pairs(l_5_0.units) do
		if alive(managers.unit_scripting:get_unit_by_name(i_1.script_name)) then
			managers.unit_scripting:get_unit_by_name(i_1.script_name):damage_data():scale_health(5)
			managers.unit_scripting:get_unit_by_name(i_1.script_name):damage():set_can_die(true)
			managers.unit_scripting:get_unit_by_name(i_1.script_name):damage():set_immune_to_damage(false)
			l_5_0:_enable_stun(managers.unit_scripting:get_unit_by_name(i_1.script_name), true)
		end
	end
end

AMLifeControl._enable_stun = function(l_6_0, l_6_1)
	local l_6_2 = l_6_1:enemy_data()
	if l_6_2 then
		l_6_2.can_be_stunned = false
	end
end


