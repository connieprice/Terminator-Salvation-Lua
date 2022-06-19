Interactable = Interactable or class()
function Interactable.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._interact_effect = nil
	A0_0._is_interact_enabled = true
	A0_0._owner_rpc = Network:self()
	A0_0._all_rpc = Network:clients()
	A0_0._unit:set_extension_update_enabled("interact", false)
end
function Interactable.is_owner(A0_2)
	return managers.ownership:is_owner(A0_2._unit)
end
function Interactable.disable_interact(A0_3)
	local L1_4
	A0_3._is_interact_enabled = false
end
function Interactable.enable_interact(A0_5)
	local L1_6
	A0_5._is_interact_enabled = true
end
function Interactable.is_interact_enabled(A0_7)
	if not A0_7._is_interact_enabled then
		print(A0_7._unit)
	end
	return A0_7._is_interact_enabled
end
function Interactable.request_interact(A0_8, A1_9)
	local L3_10
	L3_10 = A0_8._owner_rpc
	L3_10 = L3_10.arbitrate_interact
	L3_10(L3_10, managers.unit_control_id:get_unit_id(A0_8._unit), managers.unit_control_id:get_unit_id(A1_9))
end
function Interactable.handle_rpc_arbitrate_interact(A0_11, A1_12)
	assert(A0_11:is_owner())
	if A0_11._is_interact_enabled then
		A0_11:do_arbitrate_interact(A1_12)
		A0_11._all_rpc:interact(managers.unit_control_id:get_unit_id(A0_11._unit), managers.unit_control_id:get_unit_id(A1_12))
	end
end
function Interactable.handle_rpc_interact(A0_13, A1_14)
	A0_13:do_interact(A1_14)
	if A0_13._interact_effect then
		managers.sequence:run_sequence_simple(A0_13._interact_effect, A0_13._unit)
	end
end
function Interactable.can_interact_with_player(A0_15, A1_16)
	return A0_15:is_interact_enabled() and A1_16:interact_query() and A1_16:interact_query():can_interact_with(A0_15:interactable_type())
end
function Interactable.do_arbitrate_interact(A0_17, A1_18)
end
function Interactable.interact(A0_19, A1_20)
end
function Interactable.interactable_type(A0_21)
	assert(false)
end
