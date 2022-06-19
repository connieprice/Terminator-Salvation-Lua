core:module("CoreOldModule")
function base_is_required(A0_0)
	return A0_0 == "RELEASE" or A0_0 == "NETWORK" and Network:multiplayer() or A0_0 == "DEBUG" and (Application:ews_enabled() or Application:editor() or Application:debug_build())
end
function base_require(A0_1, A1_2, A2_3)
	if base_is_required(A2_3) then
		if A1_2 then
			require(A0_1 .. "_" .. A1_2)
		else
			require(A0_1)
		end
	end
end
function get_core_or_local(A0_4)
	return rawget(_G, A0_4) or rawget(_G, "Core" .. A0_4)
end
function core_or_local(A0_5, ...)
	return get_core_or_local(A0_5) and get_core_or_local(A0_5):new(...)
end
function core_prepare_full_load(A0_7, A1_8)
	if A1_8 and A1_8.prepare_full_load then
		A1_8:prepare_full_load(A0_7)
	end
	return A0_7
end
