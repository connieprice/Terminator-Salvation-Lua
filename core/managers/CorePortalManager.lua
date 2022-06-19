CorePortalManager = CorePortalManager or class()
CorePortalManager.EFFECT_MANAGER = World:effect_manager()
function CorePortalManager.init(A0_0)
	A0_0._portal_shapes = {}
	A0_0._all_units = {}
	A0_0._all_effects = {}
	A0_0._unit_groups = {}
	A0_0._deactivate_funtion = callback(A0_0, A0_0, "unit_deactivated")
end
function CorePortalManager.clear(A0_1)
	for 