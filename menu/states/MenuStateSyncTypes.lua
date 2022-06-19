if not MenuStateSyncTypes then
	MenuStateSyncTypes = {}
end
MenuStateSyncTypes.get_sync_type_class = function(l_1_0)
	if l_1_0 == "to_ingame" then
		return MenuStateStartSyncToIngame
	elseif l_1_0 == "to_frontend" then
		return MenuStateStartSyncToFrontend
	else
		assert(false, "Unknown sync type")
	end
end


