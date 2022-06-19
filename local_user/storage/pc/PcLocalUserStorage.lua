require("local_user/storage/LocalUserStorage")
if not PcLocalUserStorage then
	PcLocalUserStorage = class(LocalUserStorage)
end
PcLocalUserStorage.open_storage_select = function(l_1_0)
	l_1_0:set_is_storage_selected()
end


