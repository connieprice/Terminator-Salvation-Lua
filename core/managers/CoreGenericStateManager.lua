CoreGenericStateManager = CoreGenericStateManager or class()
function CoreGenericStateManager.init(A0_0, A1_1)
	A0_0._states = {}
	A0_0._slave_states = {}
	A0_0._instances = {}
	A0_0._updating_instances = {}
	A0_0._paused_updating_instances = {}
	A0_0._state_order = {}
	if A1_1 then
		A0_0._name = A1_1
		for 