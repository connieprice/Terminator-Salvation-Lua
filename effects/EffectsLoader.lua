if not EffectsLoader then
	EffectsLoader = class()
end
EffectsLoader.init = function(l_1_0)
	cat_print("debug", "Preloading effects...")
	local l_1_1 = File:new_parse_xml("data/effects/global_effects.xml")
	l_1_0:load_effects(l_1_1:children())
	l_1_0._effect_manager = World:effect_manager()
end

EffectsLoader.load_effects = function(l_2_0, l_2_1)
	local l_2_5, l_2_6 = nil
	local l_2_2 = l_2_1
	for i_0 in l_2_2 do
		l_2_0:load_effect(i_0:parameter("name"))
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

EffectsLoader.load_effect = function(l_3_0, l_3_1)
	World:effect_manager():load(l_3_1)
end


