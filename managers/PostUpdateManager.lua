PostUpdateManager = PostUpdateManager or class()
function PostUpdateManager.init(A0_0)
	A0_0._extensions = {}
end
function PostUpdateManager.register(A0_1, A1_2, A2_3)
	table.insert(A0_1._extensions, {_unit = A1_2, _extension = A2_3})
end
function PostUpdateManager.update(A0_4)
	local L1_5, L2_6
	L1_5, L2_6 = next(A0_4._extensions, L1_5)
	while L1_5 do
		L1_5, L2_6 = next(A0_4._extensions, L1_5)
		if alive(L2_6._unit) then
			L2_6._extension:post_update()
		else
			A0_4._extensions[L1_5] = nil
		end
	end
end
