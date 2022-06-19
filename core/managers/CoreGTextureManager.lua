CoreGTextureManager = CoreGTextureManager or class()
function CoreGTextureManager.init(A0_0)
	A0_0._preloaded = {}
	A0_0._global_texture = nil
	A0_0._texture_name = nil
	A0_0._texture_type = nil
	A0_0._texture = nil
	A0_0._delay = nil
end
function CoreGTextureManager.set_texture(A0_1, A1_2, A2_3, A3_4)
	A0_1._delay = SystemInfo:platform() ~= "PS3" and A3_4
	A0_1._texture_name = A1_2
	A0_1._texture_type = A2_3
	if A3_4 then
		TextureCache:request(A1_2, A2_3, function()
			local L0_5, L1_6
		end)
	else
		A0_1:_retrieve()
	end
end
function CoreGTextureManager.preload(A0_7, A1_8, A2_9)
	if type(A1_8) == "string" then
		if not A0_7._preloaded[A1_8] then
			A0_7._preloaded[A1_8] = TextureCache:retrieve(A1_8, A2_9)
		end
	else
		for 