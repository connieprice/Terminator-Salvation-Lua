core:require_module("CoreMusicPlayer")
CoreActionManager = CoreActionManager or class(CallbackHandler)
function CoreActionManager.init(A0_0)
	CallbackHandler.init(A0_0)
	A0_0._update_vector = {}
end
function CoreActionManager.update(A0_1, A1_2, A2_3)
	CallbackHandler.update(A0_1, A2_3)
	for 