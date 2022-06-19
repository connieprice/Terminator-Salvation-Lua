require("local_user/storage/LocalUserStorage")
PcLocalUserStorage = PcLocalUserStorage or class(LocalUserStorage)
function PcLocalUserStorage.open_storage_select(A0_0)
	A0_0:set_is_storage_selected()
end
