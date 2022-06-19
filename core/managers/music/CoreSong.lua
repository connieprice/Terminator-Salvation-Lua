local L0_0
L0_0 = core
L0_0 = L0_0.module
L0_0(L0_0, "CoreSong")
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L0_0, "CoreClass")
L0_0 = Song
if not L0_0 then
	L0_0 = CoreClass
	L0_0 = L0_0.class
	L0_0 = L0_0()
end
Song = L0_0
L0_0 = 0.5
ENGINE_WAIT = L0_0
L0_0 = "3.0,"
function Song.init(A0_1, A1_2, A2_3)
	local L3_4
	A0_1._song_name = A1_2
	L3_4 = A2_3.lookup
	L3_4 = L3_4(A2_3, "song", A1_2)
	if not L3_4:valid() then
		error(string.format("Can not load song (song_name=%s), check song in DB.", A1_2))
	end
	A0_1._song = A2_3:load_node(L3_4)
	for 