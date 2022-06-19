local L0_0
L0_0 = MenuStateSyncTypes
L0_0 = L0_0 or {}
MenuStateSyncTypes = L0_0
L0_0 = MenuStateSyncTypes
function L0_0.get_sync_type_class(A0_1)
	if A0_1 == "to_ingame" then
		return MenuStateStartSyncToIngame
	elseif A0_1 == "to_frontend" then
		return MenuStateStartSyncToFrontend
	else
		assert(false, "Unknown sync type")
	end
end
