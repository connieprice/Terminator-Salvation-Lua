require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
if not CoreSimpleAnimationCutsceneKey then
	CoreSimpleAnimationCutsceneKey = class(CoreCutsceneKeyBase)
end
CoreSimpleAnimationCutsceneKey.ELEMENT_NAME = "simple_animation"
CoreSimpleAnimationCutsceneKey.NAME = "Simple Animation"
CoreSimpleAnimationCutsceneKey:register_serialized_attribute("unit_name", "")
CoreSimpleAnimationCutsceneKey:register_serialized_attribute("group", "")
CoreSimpleAnimationCutsceneKey:attribute_affects("unit_name", "group")
CoreSimpleAnimationCutsceneKey.control_for_group = CoreCutsceneKeyBase.standard_combo_box_control
CoreSimpleAnimationCutsceneKey.__tostring = function(l_1_0)
	return "Trigger simple animation \"" .. l_1_0:group() .. "\" on \"" .. l_1_0:unit_name() .. "\"."
end

CoreSimpleAnimationCutsceneKey.skip = function(l_2_0, l_2_1)
	local l_2_2 = l_2_0:_unit(l_2_0:unit_name())
	local l_2_3 = l_2_0:group()
	l_2_2:anim_play(l_2_3, 0)
	l_2_2:anim_set_time(l_2_3, l_2_2:anim_length(l_2_3))
end

CoreSimpleAnimationCutsceneKey.evaluate = function(l_3_0, l_3_1, l_3_2)
	l_3_0:_unit(l_3_0:unit_name()):anim_play(l_3_0:group(), 0)
end

CoreSimpleAnimationCutsceneKey.revert = function(l_4_0, l_4_1)
	local l_4_2 = l_4_0:_unit(l_4_0:unit_name())
	local l_4_3 = l_4_0:group()
	if l_4_2:anim_is_playing(l_4_3) then
		l_4_2:anim_set_time(l_4_3, 0)
		l_4_2:anim_stop(l_4_3)
	end
end

CoreSimpleAnimationCutsceneKey.update = function(l_5_0, l_5_1, l_5_2)
	l_5_0:_unit(l_5_0:unit_name()):anim_set_time(l_5_0:group(), l_5_2)
end

CoreSimpleAnimationCutsceneKey.is_valid_unit_name = function(l_6_0, l_6_1)
	return not l_6_0.super.is_valid_unit_name(l_6_0, l_6_1) or #l_6_0:_unit_animation_groups(l_6_1) > 0
end

CoreSimpleAnimationCutsceneKey.is_valid_group = function(l_7_0, l_7_1)
	local l_7_2 = table.contains
	local l_7_5, l_7_6 = l_7_0:_unit_animation_groups, l_7_0
	l_7_5 = l_7_5(l_7_6, l_7_0:unit_name())
	local l_7_3 = nil
	l_7_6 = l_7_1
	local l_7_4 = nil
	return l_7_2(l_7_5, l_7_6)
end

CoreSimpleAnimationCutsceneKey.refresh_control_for_group = function(l_8_0, l_8_1)
	l_8_1:freeze()
	l_8_1:clear()
	local l_8_7, l_8_8 = l_8_0:_unit_animation_groups, l_8_0
	l_8_7 = l_8_7(l_8_8, l_8_0:unit_name())
	local l_8_2 = nil
	l_8_8 = table
	l_8_8 = l_8_8.empty
	l_8_2 = l_8_7
	l_8_8 = l_8_8(l_8_2)
	if not l_8_8 then
		l_8_8, l_8_2 = l_8_1:set_enabled, l_8_1
		l_8_8(l_8_2, true)
		l_8_8, l_8_2 = l_8_0:group, l_8_0
		l_8_8 = l_8_8(l_8_2)
		local l_8_3 = nil
		l_8_2 = ipairs
		l_8_3 = l_8_7
		l_8_2 = l_8_2(l_8_3)
		for i_0,i_1 in l_8_2 do
			l_8_1:append(l_8_6)
			if l_8_6 == l_8_8 then
				l_8_1:set_value(l_8_6)
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		l_8_8(l_8_1, false)
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_8_8(l_8_1)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


