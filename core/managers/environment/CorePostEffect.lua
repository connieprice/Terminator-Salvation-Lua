core:module("CorePostEffect")
core:require_module("CoreClass")
PostEffectModifier = PostEffectModifier or CoreClass.class()
function PostEffectModifier.init(A0_0)
	A0_0._params = {}
end
function PostEffectModifier.add(A0_1, A1_2)
	for 