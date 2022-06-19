EffectsLoader = EffectsLoader or class()
function EffectsLoader.init(A0_0)
	cat_print("debug", "Preloading effects...")
	A0_0:load_effects(File:new_parse_xml("data/effects/global_effects.xml"):children())
	A0_0._effect_manager = World:effect_manager()
end
function EffectsLoader.load_effects(A0_1, A1_2)
	local L2_3, L3_4, L4_5, L6_6, L7_7
	for L6_6 in A1_2, nil, nil do
		L7_7 = A0_1.load_effect
		L7_7(A0_1, L6_6:parameter("name"))
	end
end
function EffectsLoader.load_effect(A0_8, A1_9)
	World:effect_manager():load(A1_9)
end
